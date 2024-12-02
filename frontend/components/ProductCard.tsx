import Link from "next/link";
import { API_URL } from "../lib/api";
import { calculateRemainingTime } from "@/utils/calculateRemainingTime";

interface ProductCardProps {
  product: any;
  showCategories?: boolean; // New prop to toggle categories
  showTotalBids?: boolean; // New prop to toggle total bids
}

export default function ProductCard({ product, showCategories = true, showTotalBids = true }: ProductCardProps) {
  if (!product) {
    console.error("Product is undefined:", product);
    return null; // or show an appropriate error message
  }

  const { id, title, price, main_picture, categories, bids, ending_date } = product;

  const imageUrl = main_picture?.url
    ? `${API_URL}${main_picture.url}`
    : "/placeholder.png";

  // Calculate highest bid and total bids
  const highestBid =
    bids && bids.length > 0
      ? Math.max(...bids.map((bid: any) => bid.Amount))
      : null;
  const totalBids = bids ? bids.length : 0;

  // Calculate remaining time
  const remainingTime = calculateRemainingTime(ending_date);

  return (
    <div className="border rounded border-gray-100 p-4 bg-gray-50">
      {/* Product Image */}
      <img
        src={imageUrl}
        alt={title}
        className="w-full h-48 object-cover mb-2"
      />

      {/* Product Title */}
      <h2 className="text-xl font-semibold">{title}</h2>

      {/* Base Price */}
      <p className="text-gray-700">Utgångspris: {price} SEK</p>

      {/* Categories */}
      {showCategories && (
        <p className="text-gray-600 mt-2">
          Categories:{" "}
          {categories?.length > 0
            ? categories.map((category: any, index: number) => (
                <span key={category.id}>
                  <Link
                    href={`/category/${category.documentId}`}
                    className="text-blue-500 hover:underline"
                  >
                    {category.category_name}
                  </Link>
                  {index < categories.length - 1 && ", "}
                </span>
              ))
            : "No categories available"}
        </p>
      )}

      {/* Highest Bid */}
      {highestBid !== null && (
        <p className="text-gray-700 mt-2">
          Högsta bud: <span className="font-bold">{highestBid} SEK</span>
        </p>
      )}

      {/* Total Bids */}
      {showTotalBids && (
        <p className="text-gray-700 mt-1">
          Antal bud: <span className="font-bold">{totalBids}</span>
        </p>
      )}

      {/* Remaining Time */}
      <p className="text-gray-700 mt-1">
        {remainingTime ? (
          <>
            Tid kvar: <span className="font-bold">{remainingTime}</span>
          </>
        ) : (
          <span className="text-red-500">Budgivningen avslutades</span>
        )}
      </p>

      {/* Details Link */}
      <Link
        href={`/product/${product.documentId}`}
        className="text-blue-500 mt-2 inline-block"
      >
        Se Detaljer
      </Link>
    </div>
  );
}
