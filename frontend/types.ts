export interface Bid {
  id: number;
  Amount: number;
  biduser?: {
    id: number;
    email: string;
    slug: string;
  };
  product: Product;  // Product özelliğini ekledik
}

export interface FavoritesContextProps {
  favorites: number[];
  addFavorite: (productId: number) => void; // No need for async here
  removeFavorite: (productId: number) => void; // No need for async here
  isFavorite: (productId: number) => boolean;
  userDocumentId: string | null;
  userEmail: string | null;
  userName: string | null; 
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
    slug: string;
  }[];
  lottery_product: boolean;
  lottery_winner: string | null;
  manual_lottery: boolean | null;
  lottery_users?: any[];
  bids?: Bid[];  // Bid interface'ini ekledik
}

export interface ProductWithStatus extends Product {
  type: 'bidding' | 'lottery';
  total_bids?: number;      // Bidding ürünleri için
  highest_bid?: number;     // Bidding ürünleri için
  userBid?: number;         // Bidding ürünleri için
  isHighestBidder?: boolean; // Bidding ürünleri için
}

export type ProductSortingType = 
  | 'newfirst'    // createdAt:desc
  | 'oldfirst'    // createdAt:asc
  | 'timeshort'   // ending_date:asc
  | 'timelong'    // ending_date:desc
  | 'highbid'     // highestBid:desc
  | 'lowbid';     // highestBid:asc

export type ProductType = 'lottery' | 'bidding' | 'all' | 'lotteryManual' | 'lotteryAuto';

export interface ProductListProps {
  productType?: ProductType;
  showItems?: number;
  sorting?: boolean | 'custom';
  customSorting?: ProductSortingType[];
  showImage?: boolean;
  title?: string;
  showOld?: boolean;  // Eski ürünleri göster/gizle
}