"use client";

import React, { useState } from "react";
import { useAuth } from "@/contexts/AuthContext";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { formatCurrency } from "@/lib/utils";

interface BiddingButtonProps {
  productId: number | string;
  currentBid: number;
  startingPrice: number;
}

const BiddingButton: React.FC<BiddingButtonProps> = ({
  productId,
  currentBid,
  startingPrice,
}) => {
  const { isAuthenticated } = useAuth();
  const router = useRouter();
  const [isOpen, setIsOpen] = useState(false);
  const [bidAmount, setBidAmount] = useState<number>(
    currentBid ? currentBid + 50 : startingPrice
  );
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const minimumBid = currentBid ? currentBid + 50 : startingPrice;

  const toggleBidForm = () => {
    if (!isAuthenticated) {
      router.push("/login");
      return;
    }
    setIsOpen(!isOpen);
    setError(null);
  };

  const handleBidChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const value = parseInt(e.target.value);
    setBidAmount(isNaN(value) ? minimumBid : value);
  };

  const placeBid = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!isAuthenticated) {
      router.push("/login");
      return;
    }

    if (bidAmount < minimumBid) {
      setError(`Budet måste vara minst ${formatCurrency(minimumBid)}`);
      return;
    }

    setLoading(true);
    setError(null);

    try {
      const response = await fetch("/api/bids", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          productId,
          amount: bidAmount,
        }),
      });

      const data = await response.json();

      if (data.ok) {
        setIsOpen(false);
        router.refresh();
      } else {
        setError(data.error || "Failed to place bid");
      }
    } catch (error) {
      console.error("Error placing bid:", error);
      setError("Ett fel inträffade. Försök igen senare.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="w-full">
      {!isOpen ? (
        <Button
          onClick={toggleBidForm}
          className="w-full"
          variant="default"
        >
          Lägg bud
        </Button>
      ) : (
        <form onSubmit={placeBid} className="space-y-2">
          <div className="flex items-center gap-2">
            <Input
              type="number"
              value={bidAmount}
              onChange={handleBidChange}
              min={minimumBid}
              step="50"
              disabled={loading}
              className="flex-1"
            />
            <span className="text-sm whitespace-nowrap">SEK</span>
          </div>
          
          {error && <p className="text-red-500 text-xs">{error}</p>}
          
          <div className="text-xs text-gray-500 mb-2">
            Minsta bud: {formatCurrency(minimumBid)}
          </div>
          
          <div className="flex gap-2">
            <Button
              type="submit"
              disabled={loading}
              className="flex-1"
            >
              {loading ? (
                <div className="flex items-center">
                  <div className="w-4 h-4 border-t-2 border-b-2 border-white rounded-full animate-spin mr-2"></div>
                  Laddar...
                </div>
              ) : (
                "Bekräfta"
              )}
            </Button>
            <Button
              type="button"
              variant="outline"
              onClick={() => setIsOpen(false)}
              disabled={loading}
              className="flex-1"
            >
              Avbryt
            </Button>
          </div>
        </form>
      )}
    </div>
  );
};

export default BiddingButton; 