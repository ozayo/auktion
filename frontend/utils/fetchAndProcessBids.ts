import { API_URL } from "@/lib/api";
import { Bid } from "@/types";


export const fetchAndProcessBids = async (email: string): Promise<Bid[]> => {
  try {
    const response = await fetch(
      `${API_URL}/api/bids?filters[biduser][email][$eq]=${encodeURIComponent(
        email
      )}&populate=product.main_picture&populate=product.bids&populate=product.categories`
    );
    if (!response.ok) throw new Error("Failed to fetch bids");

    const data = await response.json();

    const groupedBids: Record<string, Bid> = {};

    data.data.forEach((bid: any) => {
      const productId: string = bid.product.id;

      const highestBid: number | null =
        bid.product.bids?.reduce((max: number, curr: any) => {
          return Math.max(max, curr.Amount);
        }, 0) || null;

      groupedBids[productId] = {
        id: bid.id,
        Amount: bid.Amount,
        product: {
          ...bid.product,
          highestBid,
          categories: bid.product.categories || [],
        },
      };
    });

    return Object.values(groupedBids);
  } catch (error) {
    console.error("Error fetching bids:", error);
    throw error;
  }
};
