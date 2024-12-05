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
