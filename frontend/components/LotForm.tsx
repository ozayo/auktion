import React, { useState, useEffect } from "react";
import { fetchAPI } from "../lib/api";
import { useAuth } from "@/contexts/AuthContext";

interface LotFormProps {
  productId: string;         // Eskisi gibi "productId" => aslında product.documentId
  onUpdate?: () => void;     // Kayıt eklenince/silince otomatik yenileme
  showHeader?: boolean;      // Üst başlığı göster/gizle
}

// Maksimum katılım
const LOTTERY_LIMIT = 5; // Kullanıcı başına maksimum katılım sayısı

const LotForm: React.FC<LotFormProps> = ({
  productId,
  onUpdate,
  showHeader = true,
}) => {
  // Yeni AuthContext
  // user => { id, email, username, documentId, ... }
  // isAuthenticated => kullanıcı giriş yapmış mı
  const { user, isAuthenticated } = useAuth();

  // Kaç ürüne kayıtlı olduğu
  const [registeredProductsCount, setRegisteredProductsCount] = useState(0);
  // Bu ürüne kayıtlı mı?
  const [isRegisteredForThisProduct, setIsRegisteredForThisProduct] = useState(false);
  // lottery-users tablosundaki kaydın documentId'si
  const [lotteryUserDocumentId, setLotteryUserDocumentId] = useState<string | null>(null);

  const [message, setMessage] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);

  // 1) Kullanıcının hangi ürünlere kayıtlı olduğunu sorgula
  const fetchUserLotteryData = async () => {
    if (!isAuthenticated || !user?.email) return;

    try {
      const userEmailEncoded = encodeURIComponent(user.email);
      // Eskiden: `/lottery-users?filters[biduser][email][$eq]=...`
      // Şimdi:   `/lottery-users?filters[user][email][$eq]=...`
      const response = await fetchAPI(
        `/lottery-users?filters[user][email][$eq]=${userEmailEncoded}&populate[user]=true&populate[products]=true`
      );

      // Yanıt geldiyse
      if (response?.data) {
        // Tüm kayıtlı ürünleri toplayalım
        const registeredProducts = response.data.flatMap((entry: any) => {
          if (entry.products) {
            // Bitiş tarihi gelecek olanları saymak istediğimizi varsayıyoruz
            return entry.products.filter((p: any) => {
              const endingDate = new Date(p.ending_date);
              return endingDate > new Date();
            });
          }
          return [];
        });
        setRegisteredProductsCount(registeredProducts.length);

        // Bu ürüne kayıtlı bir entry var mı?
        const currentEntry = response.data.find((entry: any) =>
          entry.products.some((p: any) => p.documentId === productId)
        );
        if (currentEntry) {
          setIsRegisteredForThisProduct(true);
          // Strapi'de "documentId" alanı var ise
          // (lottery-user kaydında da documentId olduğunu varsayıyoruz)
          setLotteryUserDocumentId(currentEntry.documentId || null);
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

  // 2) Kaydolma
  const handleRegister = async () => {
    // Zaten kayıtlıysa veya limit dolmuşsa ya da işlem devam ediyorsa engelle
    if (
      isSubmitting ||
      isRegisteredForThisProduct ||
      registeredProductsCount >= LOTTERY_LIMIT
    ) {
      return;
    }
    if (!isAuthenticated || !user) {
      setMessage("Du måste logga in för att delta.");
      return;
    }

    setIsSubmitting(true);

    try {
      // Yeni bir lottery-user kaydı POST ediyoruz
      // Eskiden: "biduser: biduserDocumentId"
      // Şimdi:   "user: user.documentId"
      // Ürünü de "documentId" ile relate ediyoruz
      await fetchAPI("/lottery-users", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          data: {
            user: user.documentId, // Strapi user'ın documentId'si
            products: {
              connect: [{ documentId: productId }],
            },
            // lottery-user'ın da bir documentId'si isterseniz oluşturabilirsiniz (UID / unique alan)
            // documentId: crypto.randomUUID(),
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

  // 3) Kaydı silme
  const handleUnregister = async () => {
    if (!isAuthenticated || !lotteryUserDocumentId || isSubmitting) return;
    setIsSubmitting(true);

    try {
      // Eskiden: DELETE /lottery-users/${lotteryUserDocumentId}
      // Aynı mantık: lottery-user kaydında "documentId" var sayıyoruz
      const resp = await fetchAPI(`/lottery-users/${lotteryUserDocumentId}`, {
        method: "DELETE",
      });

      if (resp.ok || resp.status === 204) {
        setMessage("Din registrering har tagits bort!");
        fetchUserLotteryData();
        if (onUpdate) onUpdate();
      } else {
        throw new Error(
          resp?.error?.message || "Failed to unregister from lottery."
        );
      }
    } catch (error) {
      console.error("Error unregistering from lottery:", error);
      setMessage("Ett fel har uppstått.");
    } finally {
      setIsSubmitting(false);
    }
  };

  // Sayfa yüklenince veya kullanıcı değişince verileri tazele
  useEffect(() => {
    fetchUserLotteryData();
  }, [isAuthenticated, user]);

  return (
    <div className="mt-4">
      {showHeader && <h2 className="text-xl font-semibold">Lotteriet</h2>}

      {/* Kullanıcı giriş yapmamışsa */}
      {showHeader && !isAuthenticated && (
        <p className="text-gray-700">Du måste logga in för att delta i lotteriet.</p>
      )}

      {/* Bilgi gösterimi */}
      {showHeader && isAuthenticated && (
        <p className="text-gray-700">
          {isRegisteredForThisProduct
            ? "Du har redan registrerat dig för denna produkt."
            : `Du har registrerat dig för ${registeredProductsCount} produkter totalt, din gräns är ${LOTTERY_LIMIT}.`}
        </p>
      )}

      {/* Kayıt ol / Kayıt sil butonları */}
      {!isRegisteredForThisProduct ? (
        <button
          onClick={handleRegister}
          disabled={registeredProductsCount >= LOTTERY_LIMIT || isSubmitting}
          className={`mt-4 px-4 py-2 text-white rounded ${
            registeredProductsCount >= LOTTERY_LIMIT
              ? "bg-gray-400 cursor-not-allowed"
              : "bg-green-500"
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

      {message && <p className="text-red-500 mt-2">{message}</p>}
    </div>
  );
};

export default LotForm;
