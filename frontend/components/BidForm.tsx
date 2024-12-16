"use client";

import { useState, useEffect } from "react";
import { fetchAPI } from "../lib/api";
import { useAuth } from "@/contexts/AuthContext";
import AuthModals from "./AuthModals";

interface BidFormProps {
  productId: string;
  refreshBids?: () => void;
}

const BidForm: React.FC<BidFormProps> = ({ productId, refreshBids }) => {
  const [amount, setAmount] = useState("");
  const [message, setMessage] = useState("");
  const [isLoginModalOpen, setIsLoginModalOpen] = useState(false);
  const [isSignUpModalOpen, setIsSignUpModalOpen] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const { isLoggedIn, userEmail, userName } = useAuth();

  const openLoginModal = () => setIsLoginModalOpen(true);
  const closeLoginModal = () => setIsLoginModalOpen(false);
  const openSignUpModal = () => {
    setIsLoginModalOpen(false);
    setIsSignUpModalOpen(true);
  };
  const closeSignUpModal = () => setIsSignUpModalOpen(false);

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

  const handleBid = async () => {
    if (!isLoggedIn) {
      setMessage("Du måste logga in för att bjuda.");
      return;
    }

    if (isSubmitting) {
      return; // Prevent multiple submissions
    }

    setIsSubmitting(true); // Disable button
    

    try {
      let biduserDocumentId;

      // Fetch or create the biduser
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

      // Fetch product details
      const productLookupUrl = `/products?filters[id][$eq]=${productId}`;
      const productLookupData = await fetchAPI(productLookupUrl);

      if (!productLookupData || productLookupData.data.length === 0) {
        setMessage("Produkten kunde inte hittas.");
        return;
      }

      const documentId = productLookupData.data[0].documentId;

      // Fetch the starting price and highest bid
      const productUrl = `/products/${documentId}`;
      const productData = await fetchAPI(productUrl);

      const startingPrice = productData.data?.price || 0;

      const bidsUrl = `/bids?filters[product][documentId][$eq]=${documentId}&sort=Amount:desc&pagination[limit]=1`;
      const bidsData = await fetchAPI(bidsUrl);
      const highestBid = bidsData.data.length > 0 ? bidsData.data[0].Amount : 0;

      // Validate bid
      const bidAmount = parseFloat(amount);
      if (isNaN(bidAmount) || bidAmount <= 0) {
        setMessage("Budbeloppet måste vara ett positivt tal.");
        return;
      }
      if (bidAmount < highestBid + 50) {
        setMessage(
          `Ditt bud måste vara minst 50 kronor högre än det senaste budet (${highestBid} SEK).`
        );
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

      // Submit bid
      const createBidResponse = await fetchAPI("/bids", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          data: {
            Amount: bidAmount,
            biduser: biduserDocumentId,
            product: documentId,
          },
        }),
      });

      setMessage("Ditt bud har registrerats!");
      setAmount("");
      // Call the refreshBids callback
      if (refreshBids) {
      refreshBids();
      }
    } catch (error) {
      console.error("Error in handleBid:", error);
      setMessage("Ett fel har uppstått.");
    }
  };

  return (
    <div className="mt-8">
      <h2 className="text-xl font-semibold">Lägg ett bud</h2>
      {!isLoggedIn ? (
        <button
          onClick={openLoginModal}
          className="bg-blue-500 text-white px-4 py-2"
        >
          Logga in
        </button>
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
            disabled={isSubmitting} // Disable button when submitting
            className={`${
              isSubmitting ? "bg-gray-500" : "bg-green-500"
            } text-white px-4 py-2`}
          >
            Lägg ett bud
          </button>
        </div>
      )}
      {message && <p className="mt-2">{message}</p>}
      <AuthModals
        isLoginModalOpen={isLoginModalOpen}
        closeLoginModal={closeLoginModal}
        isSignUpModalOpen={isSignUpModalOpen}
        closeSignUpModal={closeSignUpModal}
        openSignUpModal={openSignUpModal}
      />
    </div>
  );
};

export default BidForm;
