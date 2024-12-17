// components/LotForm.tsx
// mostly working version 16/dec / sendind data works

import React, { useState, useEffect } from "react";
import { fetchAPI } from "../lib/api";
import { useAuth } from "@/contexts/AuthContext";

interface LotFormProps {
  productId: string;
  onUpdate?: () => void; // Added to trigger immediate refresh
}

const LOTTERY_LIMIT = 5;

const LotForm: React.FC<LotFormProps> = ({ productId, onUpdate }) => {
  const { isLoggedIn, userEmail, userName } = useAuth();
  const [registeredProductsCount, setRegisteredProductsCount] = useState(0);
  const [isRegisteredForThisProduct, setIsRegisteredForThisProduct] = useState(false);
  const [lotteryUserDocumentId, setLotteryUserDocumentId] = useState<string | null>(null);
  const [message, setMessage] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);

const fetchUserLotteryData = async () => {
  if (!isLoggedIn) return;

  try {
    const userEmailEncoded = encodeURIComponent(userEmail);
    const response = await fetchAPI(
      `/lottery-users?filters[biduser][email][$eq]=${userEmailEncoded}&populate[biduser]=true&populate[products]=true`
    );

    if (response?.data) {
      // Filter ending date products
      const registeredProducts = response.data.flatMap((entry: any) => {
        if (entry.products) {
          return entry.products.filter((product: any) => {
            const endingDate = new Date(product.ending_date);
            return endingDate > new Date();
          });
        }
        return [];
      });

      // Count expired products
      setRegisteredProductsCount(registeredProducts.length);

      // Check if you are registered for the current product
      const registeredEntry = response.data.find((entry: any) =>
        entry.products.some((product: any) => product.documentId === productId)
      );

      if (registeredEntry) {
        setIsRegisteredForThisProduct(true);
        setLotteryUserDocumentId(registeredEntry.documentId);
      } else {
        setIsRegisteredForThisProduct(false);
        setLotteryUserDocumentId(null);
      }
    } else {
      setRegisteredProductsCount(0);
      setIsRegisteredForThisProduct(false);
      setLotteryUserDocumentId(null);
    }
  } catch (error) {
    console.error("Error fetching user lottery data:", error);
    setMessage("Ett fel har uppstått.");
  }
};


const handleRegister = async () => {
  if (isSubmitting || isRegisteredForThisProduct || registeredProductsCount >= LOTTERY_LIMIT) {
    return;
  }
  if (!isLoggedIn) {
    setMessage("Du måste logga in för att delta.");
    return;
  }
  setIsSubmitting(true);

  try {
    let biduserDocumentId;

    // Check or create user
    const bidusersData = await fetchAPI(
      `/bidusers?filters[email][$eq]=${encodeURIComponent(userEmail)}`
    );

    if (bidusersData?.data?.length > 0) {
      biduserDocumentId = bidusersData.data[0].documentId;
    } else {
      const newUser = await fetchAPI("/bidusers", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          data: {
            email: userEmail,
            Name: userName,
          },
        }),
      });
      biduserDocumentId = newUser.data.documentId;
    }

    // Lottery User registry
    await fetchAPI("/lottery-users", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        data: {
          biduser: biduserDocumentId,
          products: {
            connect: [{ documentId: productId }],
          },
        },
      }),
    });

      setMessage("Du har registrerats!");
      fetchUserLotteryData();
      if (onUpdate) onUpdate();
    } catch (error) {
      console.error("Error registering for lottery:", error);
      setMessage("Ett fel har uppstått.");
    } finally {
      setIsSubmitting(false);
    }
  };



  const handleUnregister = async () => {
    if (!isLoggedIn || !lotteryUserDocumentId || isSubmitting) return;
    setIsSubmitting(true);
    try {
      const response = await fetchAPI(`/lottery-users/${lotteryUserDocumentId}`, {
        method: "DELETE",
      });
      if (response.status === 204) {
        setMessage("Din registrering har tagits bort!");
        fetchUserLotteryData();
        if (onUpdate) onUpdate(); // Trigger immediate update
        return;
      }
      if (response.ok) {
        setMessage("Din registrering har tagits bort!");
        fetchUserLotteryData();
        if (onUpdate) onUpdate();
      } else {
        throw new Error(response?.error?.message || "Failed to unregister from lottery.");
      }
    } catch (error) {
      console.error("Error unregistering from lottery:", error);
      setMessage("Ett fel har uppstått.");
    } finally {
      setIsSubmitting(false);
    }
  };

  useEffect(() => {
    fetchUserLotteryData();
  }, [isLoggedIn]);

  return (
    <div className="mt-8">
      <h2 className="text-xl font-semibold">Lotteriet</h2>
      {!isLoggedIn ? (
        <button onClick={() => setMessage("Du måste logga in för att delta.")}
                className="bg-blue-500 text-white px-4 py-2 mt-2">
          Logga in
        </button>
      ) : (
        <div>
          <p className="text-gray-700">
            {isRegisteredForThisProduct
              ? "Du har redan registrerat dig för denna produkt."
              : `Du har registrerat dig för ${registeredProductsCount} produkter totalt, din gräns är ${LOTTERY_LIMIT}.`}
          </p>
          {!isRegisteredForThisProduct ? (
            <button
              onClick={handleRegister}
              disabled={registeredProductsCount >= LOTTERY_LIMIT || isSubmitting}
              className={`mt-4 px-4 py-2 text-white rounded ${
                registeredProductsCount >= LOTTERY_LIMIT ? "bg-gray-400 cursor-not-allowed" : "bg-green-500"
              }`}
            >
              Registrera mig
            </button>
          ) : (
            <button
              onClick={handleUnregister}
              disabled={isSubmitting}
              className="mt-4 px-4 py-2 bg-red-500 text-white rounded"
            >
              Ta bort mig
            </button>
          )}
        </div>
      )}
      {message && <p className="text-red-500 mt-2">{message}</p>}
    </div>
  );
};

export default LotForm;
