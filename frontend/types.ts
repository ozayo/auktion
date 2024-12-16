

export interface Bid {
  id: string;
  Amount: number;
  product: {
    id: string;
    documentId: string;
    title: string;
    description: string;
    price: number;
    ending_date: string;
    createdAt: string;
    main_picture: { url: string; alternativeText?: string } | null;
    highestBid: number | null;
    categories?: { category_name: string }[];
  };
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