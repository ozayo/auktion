"use client";

import { useState, useEffect } from "react";
import { fetchAPI } from "../lib/api";
import { useAuth } from "@/contexts/AuthContext";
import { useRouter } from "next/navigation";
import Link from "next/link";

interface BidFormProps {
  productId: string;
  refreshBids?: () => void;
  currentHighestBid?: number;
  startingPrice?: number;
}

// Minimum bid increment
const MIN_BID_INCREMENT = 50;

// Mesaj tipi için enum tanımlayalım
enum MessageType {
  SUCCESS = "success",
  INFO = "info",
  WARNING = "warning"
}

// Teklif onay durumları için enum
enum BidConfirmationType {
  REASONABLE_HIGH = "reasonable_high", // Yüksek ama makul teklif (min teklif x 5)
  ABNORMAL_HIGH = "abnormal_high",     // Anormal derecede yüksek teklif (min teklif x 10)
  ALREADY_HIGHEST = "already_highest"  // Kullanıcı zaten en yüksek teklifi vermişse
}

const BidForm: React.FC<BidFormProps> = ({ productId, refreshBids, currentHighestBid = 0, startingPrice = 0 }) => {
  const [amount, setAmount] = useState("");
  const [message, setMessage] = useState("");
  const [messageType, setMessageType] = useState<MessageType>(MessageType.INFO);
  const [temporarySuccessMessage, setTemporarySuccessMessage] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [highestBid, setHighestBid] = useState(0);
  const [isLoading, setIsLoading] = useState(true);
  const [userLastBid, setUserLastBid] = useState<number | null>(null);
  const router = useRouter();

  // Modal states
  const [showConfirmationModal, setShowConfirmationModal] = useState(false);
  const [tempBidAmount, setTempBidAmount] = useState<number | null>(null);
  const [confirmationType, setConfirmationType] = useState<BidConfirmationType>(BidConfirmationType.REASONABLE_HIGH);
  const [minimumBid, setMinimumBid] = useState<number>(0);

  const { user, isAuthenticated } = useAuth();
  const isLoggedIn = isAuthenticated && !!user;

  const redirectToLogin = () => {
    router.push('/signin');
  };

  useEffect(() => {
    let timeout: NodeJS.Timeout | null = null;

    if (isSubmitting) {
      timeout = setTimeout(() => {
        setIsSubmitting(false);
      }, 5000);
    }

    return () => {
      if (timeout) {
        clearTimeout(timeout);
      }
    };
  }, [isSubmitting]);

  useEffect(() => {
    setHighestBid(currentHighestBid);
  }, [currentHighestBid]);

  useEffect(() => {
    const suggestedBid = Math.max(currentHighestBid + MIN_BID_INCREMENT, startingPrice);
    setIsLoading(false);
  }, [currentHighestBid, startingPrice]);

  useEffect(() => {
    let timeout: NodeJS.Timeout | null = null;
    
    if (temporarySuccessMessage) {
      timeout = setTimeout(() => {
        setTemporarySuccessMessage("");
      }, 5000);
    }
    
    return () => {
      if (timeout) {
        clearTimeout(timeout);
      }
    };
  }, [temporarySuccessMessage]);

  useEffect(() => {
    // Teklif vermediyse kullanıcı
    if (userLastBid === null) {
      setMessage("Du har inte lagt något bud på denna produkt ännu.");
      setMessageType(MessageType.INFO);
      return;
    }
    
    // Kullanıcının teklifi en yüksek teklif mi?
    if (userLastBid === currentHighestBid) {
      setMessage("Du har det högsta budet.");
      setMessageType(MessageType.SUCCESS);
    } 
    // Kullanıcının teklifi en yüksek değilse ve teklif verdiyse
    else if (userLastBid > 0 && userLastBid < currentHighestBid) {
      setMessage("Ditt bud har överträffats av en annan användare.");
      setMessageType(MessageType.WARNING);
    }
  }, [currentHighestBid, userLastBid]);

  const handleBid = async (confirmed = false) => {
    if (!isLoggedIn || !user) {
      setMessage("Du måste vara inloggad för att bjuda.");
      return;
    }

    if (isSubmitting) {
      return; // Prevent multiple submissions
    }

    const bidAmount = parseFloat(amount);
    const minRequiredBid = Math.max(highestBid + MIN_BID_INCREMENT, startingPrice);
    setMinimumBid(minRequiredBid);
    
    // Eğer kullanıcı henüz onaylamamışsa ve teklif belirli eşikleri aşıyorsa onay göster
    if (!confirmed) {
      // Kullanıcı zaten en yüksek teklifi vermişse
      if (userLastBid !== null && userLastBid === highestBid && bidAmount > highestBid) {
        setConfirmationType(BidConfirmationType.ALREADY_HIGHEST);
        setTempBidAmount(bidAmount);
        setShowConfirmationModal(true);
        return;
      }
      // Diğer onay durumları
      // Anormal derecede yüksek teklif: minimum teklifin 10 katı veya üzeri
      if (bidAmount >= minRequiredBid * 10) {
        setConfirmationType(BidConfirmationType.ABNORMAL_HIGH);
        setTempBidAmount(bidAmount);
        setShowConfirmationModal(true);
        return;
      }
      // Yüksek ama makul teklif: minimum teklif + min bid increment 5 katı veya üzeri (yani 250 kr ve uzeri)
      else if (bidAmount >= minRequiredBid + (MIN_BID_INCREMENT*5)) {
        setConfirmationType(BidConfirmationType.REASONABLE_HIGH);
        setTempBidAmount(bidAmount);
        setShowConfirmationModal(true);
        return;
      }
      // Normal teklif: onay gerekmez
    }

    setIsSubmitting(true); // Disable button

    try {
      // Fetch product details
      const productLookupUrl = `/products?filters[id][$eq]=${productId}`;
      const productLookupData = await fetchAPI(productLookupUrl);

      if (!productLookupData || productLookupData.data.length === 0) {
        setMessage("Produkten kunde inte hittas.");
        return;
      }

      const documentId = productLookupData.data[0].documentId;

      // Validate bid
      if (isNaN(bidAmount) || bidAmount <= 0) {
        setMessage("Ditt bud måste vara ett positivt tal.");
        return;
      }
      if (bidAmount < highestBid + MIN_BID_INCREMENT) {
        setMessage(
          `Ditt bud måste vara minst ${MIN_BID_INCREMENT} kronor högre än det senaste budet.`
        );
        return;
      }

      if (bidAmount < startingPrice) {
        setMessage(
          `Ditt bud måste vara minst lika med utgångspriset (${startingPrice} SEK).`
        );
        return;
      }

      // Submit bid
      await fetchAPI("/bids", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          data: {
            Amount: bidAmount,
            user: user.documentId,
            product: documentId,
          },
        }),
      });

      // Geçici başarı mesajını set et - 5 saniye sonra kaybolacak
      setTemporarySuccessMessage("Ditt bud har registrerats!");
      setUserLastBid(bidAmount);
      
      // Successful bid - update the local highest bid and suggested amount
      setHighestBid(bidAmount);
      setAmount("");
      
      if (refreshBids) {
        // Veriler yenilenirken formu kısa süreliğine devre dışı bırak
        setIsLoading(true);
        refreshBids();
        // Kısa bir gecikme sonrası formu tekrar aktif hale getir
        setTimeout(() => {
          setIsLoading(false);
        }, 1000); // 1 saniyelik gecikme
      }
    } catch (error) {
      console.error("Error in handleBid:", error);
      setMessage("Ett fel har uppstått.");
      setMessageType(MessageType.WARNING);
    } finally {
      setIsSubmitting(false);
    }
  };

  useEffect(() => {
    const checkUserBids = async () => {
      if (!isLoggedIn || !user) return;
      
      try {
        // Kullanıcının bu ürün için yaptığı tüm teklifleri getir
        const bidsUrl = `/bids?filters[user][documentId][$eq]=${user.documentId}&filters[product][id][$eq]=${productId}&sort=Amount:desc&pagination[limit]=1`;
        const bidsData = await fetchAPI(bidsUrl);
        
        // Kullanıcının teklifi varsa, en yüksek teklifini kaydet
        if (bidsData.data.length > 0) {
          setUserLastBid(bidsData.data[0].Amount);
        }
      } catch (error) {
        console.error("Error checking user bids:", error);
      }
    };
    
    checkUserBids();
  }, [isLoggedIn, user, productId]);

  return (
    <div className="mt-8">
      <h2 className="text-xl font-semibold">Lägg ett bud</h2>
      {!isLoggedIn ? (
        <div>
          <p className="mb-2">Du måste vara inloggad för att lägga bud.</p>
          <button
            onClick={redirectToLogin}
            className="bg-blue-500 text-white px-4 py-2 hover:bg-blue-600 rounded transition"
          >
            Logga in
          </button>
          <Link href="/signup" className="ml-4 text-blue-500 hover:underline">
            Skapa konto
          </Link>
        </div>
      ) : (
        <div>
          <p className="mb-2">
            Budbelopp (minst {highestBid > 0 ? `${highestBid + MIN_BID_INCREMENT} SEK` : `${startingPrice} SEK`}):
          </p>
          <div className="flex gap-2 items-center w-full">
            {isLoading ? (
              <div className="animate-pulse h-10 w-full max-w-xs bg-gray-200 rounded"></div>
            ) : (
              <input
                type="number"
                placeholder={`${Math.max(highestBid + MIN_BID_INCREMENT, startingPrice)} SEK eller mer`}
                value={amount}
                onChange={(e) => setAmount(e.target.value)}
                className="border border-gray-200 p-2 w-2/3"
                min={Math.max(highestBid + MIN_BID_INCREMENT, startingPrice)}
                step={MIN_BID_INCREMENT}
              />
            )}
            <button
              onClick={() => handleBid()}
              disabled={isSubmitting || isLoading}
              className={`${
                isSubmitting || isLoading ? "bg-gray-500" : "bg-green-500 border border-green-500 hover:bg-green-600 hover:border-green-600 cursor-pointer w-1/3"
              } text-white px-4 py-2`}
            >
              {isLoading ? "Uppdaterar..." : "Lägg ett bud"}
            </button>
          </div>
        </div>
      )}
      
      {/* Geçici başarı mesajı - 5 saniye sonra kaybolacak */}
      {temporarySuccessMessage && (
        <div className="mt-2 p-2 rounded bg-green-100 text-green-800 border border-green-200">
          {temporarySuccessMessage}
        </div>
      )}
      
      {/* Kalıcı durum mesajı */}
      {message && (
        <div className={`mt-2 p-2 rounded ${
          messageType === MessageType.SUCCESS ? 'bg-green-100 text-green-800 border border-green-200' :
          messageType === MessageType.WARNING ? 'bg-yellow-100 text-yellow-800 border border-yellow-200' :
          'bg-blue-100 text-blue-800 border border-blue-200'
        }`}>
          {message}
        </div>
      )}

      {/* Confirmation Modal */}
      {showConfirmationModal && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-10">
          <div className="bg-white px-8 py-6 rounded-lg shadow-lg">
            <h3 className="text-lg font-bold">Bekräfta ditt bud</h3>
            <div className="mt-4">
              {confirmationType === BidConfirmationType.ALREADY_HIGHEST ? (
                <>
                  <p className="text-orange-600 font-semibold">Du har redan det högsta budet!</p>
                  <p>Ditt nuvarande bud är <strong>{userLastBid} SEK</strong>.</p>
                  <p>Är du säker på att du vill lägga ett nytt bud på <strong>{tempBidAmount} SEK</strong>?</p>
                </>
              ) : confirmationType === BidConfirmationType.REASONABLE_HIGH ? (
                <>
                  <p>Du är på väg att lägga ett bud som är betydligt högre än minimum ({minimumBid} SEK).</p>
                  <p>Är du säker på att du vill bjuda <strong>{tempBidAmount} SEK</strong>?</p>
                </>
              ) : (
                <>
                  <p className="text-red-600 font-semibold">Varning: Extremt högt bud!</p>
                  <p>Du är på väg att lägga ett bud som är <strong>10 gånger högre</strong> än minimum ({minimumBid} SEK).</p>
                  <p>Är du verkligen säker på att du vill bjuda <strong>{tempBidAmount} SEK</strong>?</p>
                  <p className="text-gray-600 italic mt-2">Din plånbok kommer tacka dig om du tänker efter en gång till.</p>
                </>
              )}
            </div>
            <div className="mt-6 flex justify-end space-x-4">
              <button
                onClick={() => setShowConfirmationModal(false)}
                className="px-4 py-2 bg-gray-300 text-gray-700 rounded-lg"
              >
                Avbryt
              </button>
              <button
                onClick={() => {
                  setShowConfirmationModal(false);
                  handleBid(true); // Proceed with bid
                }}
                className={`px-4 py-2 text-white rounded-lg ${
                  confirmationType === BidConfirmationType.ABNORMAL_HIGH 
                    ? 'bg-red-500 hover:bg-red-600' 
                    : confirmationType === BidConfirmationType.ALREADY_HIGHEST
                    ? 'bg-orange-500 hover:bg-orange-600'
                    : 'bg-green-500 hover:bg-green-600'
                }`}
              >
                Bekräfta
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default BidForm;
