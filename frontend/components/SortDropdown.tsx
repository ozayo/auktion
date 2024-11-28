"use client";

interface SortDropdownProps {
  products: any[];
  setSortedProducts: (products: any[]) => void;
}

export default function SortDropdown({ products, setSortedProducts }: SortDropdownProps) {
  const handleSortChange = (value: string) => {
    const sortedProducts = [...products]; // Create a copy of the original list to avoid mutating it

    switch (value) {
      case "highestBid:desc":
        sortedProducts.sort((a, b) => {
          const highestBidA = a.bids?.length > 0 ? Math.max(...a.bids.map((bid: any) => bid.Amount)) : 0;
          const highestBidB = b.bids?.length > 0 ? Math.max(...b.bids.map((bid: any) => bid.Amount)) : 0;
          return highestBidB - highestBidA; // Sort from highest to lowest bid
        });
        break;

      case "highestBid:asc":
        sortedProducts.sort((a, b) => {
          const highestBidA = a.bids?.length > 0 ? Math.max(...a.bids.map((bid: any) => bid.Amount)) : 0;
          const highestBidB = b.bids?.length > 0 ? Math.max(...b.bids.map((bid: any) => bid.Amount)) : 0;
          return highestBidA - highestBidB; // Sort from lowest to highest bid
        });
        break;

      case "createdAt:asc":
        sortedProducts.sort((a, b) => new Date(a.createdAt).getTime() - new Date(b.createdAt).getTime());
        break;

      case "createdAt:desc":
      default:
        sortedProducts.sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime());
        break;
    }

    setSortedProducts(sortedProducts);
  };

  return (
    <div className="flex items-center gap-2 mb-4">
      <label htmlFor="sort" className="text-gray-700 font-semibold">
        Sortera:
      </label>
      <select
        id="sort"
        onChange={(e) => handleSortChange(e.target.value)}
        className="border border-gray-300 rounded p-2"
      >
        <option value="createdAt:desc">Nyaste först</option>
        <option value="createdAt:asc">Äldsta först</option>
        <option value="highestBid:desc">Högsta bud först</option>
        <option value="highestBid:asc">Lägsta bud först</option>
      </select>
    </div>
  );
}
