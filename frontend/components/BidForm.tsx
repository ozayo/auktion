"use client";

import { useState } from "react";
import { fetchAPI } from "../lib/api";
import { useAuth } from "@/contexts/AuthContext";
import { API_URL } from "../lib/api";

interface BidFormProps {
  productId: string;
}

export default function BidForm({ productId }: BidFormProps) {
  const [amount, setAmount] = useState("");
  const [message, setMessage] = useState("");
  const [localEmail, setLocalEmail] = useState<string>("");
  const [localName, setLocalName] = useState<string>("");
  const [isLoginModalOpen, setIsLoginModalOpen] = useState<boolean>(false);
  const [isSignUpModalOpen, setIsSignUpModalOpen] = useState<boolean>(false);

  const { isLoggedIn, userEmail, userName, logIn } = useAuth();

  const openLoginModal = () => setIsLoginModalOpen(true);
  const closeLoginModal = () => setIsLoginModalOpen(false);
  const openSignUpModal = (email: string) => {
    setLocalEmail(email);
    setIsLoginModalOpen(false);
    setIsSignUpModalOpen(true);
  };
  const closeSignUpModal = () => {
    setIsSignUpModalOpen(false);
    setLocalEmail("");
    setLocalName("");
  };

  const handleLogin = async () => {
    if (!localEmail) {
      setMessage("Vänligen fyll i e-postadress.");
      return;
    }

    try {
      const query = `filters[email][$eq]=${encodeURIComponent(localEmail)}`;
      const response = await fetch(`${API_URL}/api/bidusers?${query}`);
      if (!response.ok) throw new Error("Failed to fetch users");

      const data = await response.json();

      if (data.data.length > 0) {
        logIn(localEmail);
        closeLoginModal();
        setMessage("Inloggad!");
      } else {
        setMessage("Email not found. Skapa konto istället.");
        openSignUpModal(localEmail);
      }
    } catch (error) {
      console.error("Login error:", error);
      setMessage("Ett fel uppstod vid inloggningen. Försök igen.");
    }
  };

  const handleSignUp = async () => {
    if (!localEmail || !localName) {
      setMessage("Vänligen fyll i alla fält.");
      return;
    }

    try {
      const query = `filters[email][$eq]=${encodeURIComponent(localEmail)}`;
      const checkResponse = await fetch(`${API_URL}/api/bidusers?${query}`);
      if (!checkResponse.ok)
        throw new Error("Failed to check existing accounts");

      const checkData = await checkResponse.json();

      if (checkData.data.length > 0) {
        setMessage("Denna e-postadress är redan registrerad.");
        return;
      }

      const payload = {
        data: {
          Name: localName,
          email: localEmail,
          active: true,
          bids: [],
        },
      };

      const createResponse = await fetch(`${API_URL}/api/bidusers`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
      });

      if (!createResponse.ok) throw new Error("Failed to create account");

      const responseData = await createResponse.json();
      logIn(localEmail, localName);
      closeSignUpModal();
      setMessage("Kontot skapades framgångsrikt!");
    } catch (error) {
      console.error("Sign-up error:", error);
      setMessage("Ett fel uppstod vid skapandet av kontot.");
    }
  };

const handleBid = async () => {
  if (!isLoggedIn) {
    setMessage("Du måste logga in för att bjuda.");
    
    return;
  }

  try {
    let biduserDocumentId;

    
    const bidusersData = await fetchAPI(
      `/bidusers?filters[email][$eq]=${encodeURIComponent(userEmail)}`
    );
   

    if (bidusersData.data.length > 0) {
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

    

    // Fetch product by numeric ID to retrieve its documentId
    const productLookupUrl = `/products?filters[id][$eq]=${productId}`;
    
    const productLookupData = await fetchAPI(productLookupUrl);

    if (!productLookupData || productLookupData.data.length === 0) {
      console.error("Failed to fetch product for ID:", productId);
      setMessage("Produkten kunde inte hittas.");
      return;
    }

    const documentId = productLookupData.data[0].documentId;
    

    // Fetch product details using documentId
    const productUrl = `/products/${documentId}`;
   
    const productData = await fetchAPI(productUrl);

    if (!productData || !productData.data) {
      console.error("Product not found for documentId:", documentId);
      setMessage("Produkten kunde inte hittas.");
      return;
    }
    

    const startingPrice = productData.data?.price || 0;
   

    // Fetch the highest current bid for the product
    const bidsUrl = `/bids?filters[product][documentId][$eq]=${encodeURIComponent(
      documentId
    )}&sort=Amount:desc&pagination[limit]=1`;
   
    const bidsData = await fetchAPI(bidsUrl);
   
    const highestBid =
      bidsData.data && bidsData.data.length > 0 ? bidsData.data[0].Amount : 0;
    

    // Validate the new bid amount
    const bidAmount = parseFloat(amount);
   

    if (isNaN(bidAmount) || bidAmount <= 0) {
      setMessage("Budbeloppet måste vara ett positivt tal.");
      
      return;
    }
    if (bidAmount <= highestBid) {
      setMessage(
        `Ditt bud måste vara högre än det senaste budet (${highestBid}).`
      );
      
      return;
    }
    if (bidAmount < startingPrice) {
      setMessage(
        `Ditt bud måste vara minst lika med utgångspriset (${startingPrice} SEK).`
      );
      
      return;
    }

    // Create the new bid
   
    const createBidResponse = await fetchAPI("/bids", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        data: {
          Amount: bidAmount,
          biduser: biduserDocumentId, // Using biduser documentId
          product: documentId, // Using product documentId
        },
      }),
    });
   

    setMessage("Ditt bud har registrerats!");
    
    setAmount("");
  } catch (error) {
    console.error("Error in handleBid:", error);
    setMessage("Ett fel har uppstått.");
  }
};





  return (
    <div className="mt-8">
      <h2 className="text-xl font-semibold">Lägg ett bud</h2>
      {!isLoggedIn ? (
        <div>
          <button
            onClick={openLoginModal}
            className="bg-blue-500 text-white px-4 py-2"
          >
            Logga in
          </button>
        </div>
      ) : (
        <div>
          <p>Budbelopp:</p>
          <input
            type="number"
            placeholder="Budbelopp:"
            value={amount}
            onChange={(e) => setAmount(e.target.value)}
            className="border p-2 mr-2"
          />
          <button
            onClick={handleBid}
            className="bg-green-500 text-white px-4 py-2"
          >
            Lägg ett bud
          </button>
        </div>
      )}
      {message && <p className="mt-2">{message}</p>}

      {/* Login Modal */}
      {isLoginModalOpen && (
        <div className="fixed inset-0 bg-gray-800 bg-opacity-50 flex justify-center items-center z-50">
          <div className="bg-white p-6 rounded-md shadow-md w-96">
            <h2 className="text-xl font-bold mb-4">Logga in</h2>
            <input
              type="email"
              placeholder="Email"
              value={localEmail}
              onChange={(e) => setLocalEmail(e.target.value)}
              className="border p-2 mb-2 w-full"
            />
            <div className="flex justify-end gap-2">
              <button
                onClick={closeLoginModal}
                className="px-4 py-2 bg-gray-300 hover:bg-gray-400 rounded"
              >
                Avbryt
              </button>
              <button
                onClick={handleLogin}
                className="px-4 py-2 bg-blue-500 text-white hover:bg-blue-600 rounded"
              >
                Logga in
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Sign-Up Modal */}
      {isSignUpModalOpen && (
        <div className="fixed inset-0 bg-gray-800 bg-opacity-50 flex justify-center items-center z-50">
          <div className="bg-white p-6 rounded-md shadow-md w-96">
            <h2 className="text-xl font-bold mb-4">Skapa konto</h2>
            <input
              type="email"
              placeholder="Email"
              value={localEmail}
              onChange={(e) => setLocalEmail(e.target.value)}
              className="border p-2 mb-2 w-full"
            />
            <input
              type="text"
              placeholder="Namn"
              value={localName}
              onChange={(e) => setLocalName(e.target.value)}
              className="border p-2 mb-4 w-full"
            />
            <div className="flex justify-end gap-2">
              <button
                onClick={closeSignUpModal}
                className="px-4 py-2 bg-gray-300 hover:bg-gray-400 rounded"
              >
                Avbryt
              </button>
              <button
                onClick={handleSignUp}
                className="px-4 py-2 bg-blue-500 text-white hover:bg-blue-600 rounded"
              >
                Skapa konto
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
