export interface Bid {
  id: number;
  Amount: number;
  product: ProductWithStatus;
}

export interface FavoritesContextProps {
  favorites: number[];
  addFavorite: (productId: number) => void; // No need for async here
  removeFavorite: (productId: number) => void; // No need for async here
  isFavorite: (productId: number) => boolean;
  userDocumentId: string | null;
  userEmail: string | null;
  clearFavorites: () => void;
}

export interface Product {
  id: number;
  documentId: string;
  title: string;
  description: string | null;
  price: number | null;
  ending_date: string;
  createdAt: string;
  main_picture?: {
    url: string;
  };
  categories?: {
    id: number;
    category_name: string;
  }[];
  lottery_product: boolean;
  lottery_winner: string | null;
  manual_lottery: boolean | null;
  lottery_users?: any[];
}

export interface ProductWithStatus extends Product {
  type: 'bidding' | 'lottery';
  total_bids?: number;      // Bidding ürünleri için
  highest_bid?: number;     // Bidding ürünleri için
  userBid?: number;         // Bidding ürünleri için
  isHighestBidder?: boolean; // Bidding ürünleri için
}