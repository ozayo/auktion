import Link from "next/link";
import { API_URL } from "../lib/api";
import { calculateRemainingTime } from "@/utils/calculateRemainingTime";
import SaveToFavoritesButton from "./SaveToFavoritesButton";

interface ProductCardProps {
  product: any;
  showTotalBids?: boolean; // Toggle total bids visibility
  userBid?: number | null; // Optional user's highest bid (for my_page)
  onFavoriteChange?: () => void;
  borderless?: boolean;
}

export default function ProductCard({
  product,
  showTotalBids = true,
  userBid = null,
  onFavoriteChange,
  borderless = false,
}: ProductCardProps) {
  if (!product) {
    console.error("Product is undefined:", product);
    return null;
  }

  const { id, title, price, main_picture, categories, bids, ending_date } =
    product;

  const imageUrl = main_picture?.url
    ? `${API_URL}${main_picture.url}`
    : "/placeholder.png";

  const highestBid =
    bids && bids.length > 0
      ? Math.max(...bids.map((bid: any) => bid.Amount))
      : null;

  const totalBids = bids ? bids.length : 0;
  const remainingTime = calculateRemainingTime(ending_date);

  return (
    <div
      className={`product-card-wrapper relative bidding ${
        borderless ? "" : "border"
      } bg-white p-4 hover:bg-gray-50`}
    >
      {/* Favorites Button */}
      <div
        className="absolute top-2 right-2 z-10"
        style={{
          position: "absolute",
          top: "12px",
          right: "12px",
        }}
      >
        <SaveToFavoritesButton
          productId={product.id}
          onFavoriteChange={onFavoriteChange}
        />
      </div>

      <Link className="block" href={`/product/${product.documentId}`}>
        <div className="product-card">
          {/* Product Image */}
          <div className="product-images relative">
            <img
              src={imageUrl}
              alt={title}
              className="w-full h-48 object-cover mb-2"
            />
            {/* Categories */}
            <div className="absolute top-0 left-0">
              {categories?.length > 0 ? (
                categories.map((category: any, index: number) => (
                  <span
                    className="text-white rounded-full bg-blue-950 py-1 px-4 text-sm mr-2"
                    key={category.id || `category-${index}`}
                  >
                    {category.category_name}
                  </span>
                ))
              ) : (
                <span className="text-gray-500 text-sm">No categories</span>
              )}
            </div>
          </div>

          {/* Product Details */}
          <div className="product-details flex flex-col">
            {/* Product Title */}
            <div className="title min-h-16">
              <h2 className="text-xl font-semibold">{title}</h2>
            </div>

            {/* Middle Section */}
            <div className="middle">
              <div className="flex items-center justify-between py-2">
                {/* Base Price */}
                <div className="flex flex-col text-center">
                  <p className="text-gray-600 text-xs">Utgångspris</p>
                  <p className="text-gray-900 font-bold text-sm">{price ?? 0} SEK</p>
                </div>

                {/* Highest Bid */}
                <div className="flex flex-col text-center">
                  <p className="text-gray-600 text-xs">Ledande bud</p>
                  <p className="text-gray-900 font-bold text-sm">
                    {highestBid ? `${highestBid} SEK` : "Inga bud"}
                  </p>
                </div>

                {/* My Highest Bid */}
                {userBid !== null && (
                  <div className="flex flex-col text-center">
                    <p className="text-gray-600 text-xs">Mitt högsta bud</p>
                    <p className="text-gray-900 font-bold text-sm">
                      {userBid} SEK
                    </p>
                  </div>
                )}

                {/* Total Bids */}
                {showTotalBids && (
                  <div className="flex flex-col text-center">
                    <p className="text-gray-600 text-xs">Antal bud</p>
                    <p className="text-gray-900 font-bold text-sm">
                      {totalBids}
                    </p>
                  </div>
                )}
              </div>

              {/* Remaining Time */}
              <div className="items-center flex flex-col justify-center min-h-14 mb-3">
                {remainingTime ? (
                  <>
                    <p className="text-gray-600 text-xs">Budgivning avslutas</p>
                    <p className="text-gray-800 font-bold text-lg">
                      {remainingTime}
                    </p>
                  </>
                ) : (
                  <p className="text-red-500">Budgivningen avslutades</p>
                )}
              </div>
            </div>
          </div>
        </div>
      </Link>
    </div>
  );
}
