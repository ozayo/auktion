import { API_URL } from "@/lib/api";
import { Bid, Product } from "@/types";

interface BidResponse {
  id: number;
  Amount: number;
  product: Product & {
    bids: Array<{
      id: number;
      Amount: number;
      biduser: {
        id: number;
        email: string;
      };
    }>;
  };
}

export const fetchAndProcessBids = async (email: string): Promise<Bid[]> => {
  try {
    const response = await fetch(
      `${API_URL}/api/bids?filters[biduser][email][$eq]=${encodeURIComponent(
        email
      )}&populate=product.main_picture&populate=product.categories&populate=product.bids.biduser`
    );

    if (!response.ok) throw new Error("Failed to fetch bids");

    const data = await response.json();

    return data.data.map((bid: BidResponse) => {
      const product = bid.product;
      const allBids = product.bids || [];
      
      const highestBid = allBids.length > 0 
        ? Math.max(...allBids.map(b => b.Amount))
        : 0;

      const userBids = allBids
        .filter(b => b.biduser?.email === email)
        .map(b => b.Amount);
      
      const userHighestBid = userBids.length > 0 
        ? Math.max(...userBids)
        : 0;

      return {
        id: bid.id,
        Amount: bid.Amount,
        product: {
          ...product,
          total_bids: allBids.length,
          highest_bid: highestBid,
          userBid: userHighestBid,
          isHighestBidder: userHighestBid === highestBid,
          type: 'bidding' as const
        }
      };
    });
  } catch (error) {
    console.error("Error in fetchAndProcessBids:", error);
    return [];
  }
};
