// components/ProductCardLot.tsx

import Link from "next/link";
import { API_URL } from "../lib/api";
import { calculateRemainingTime } from "@/utils/calculateRemainingTime";
import SaveToFavoritesButton from "./SaveToFavoritesButton";

interface ProductCardLotProps {
  product: any;
  showCategories?: boolean; // New prop to toggle categories
  onFavoriteChange?: () => void;
  borderless?: boolean;
  colorless?: boolean;
}

export default function ProductCardLot({
  product,
  onFavoriteChange,
  borderless = false,
  colorless = false,
  showCategories = true }:
  ProductCardLotProps) {
  if (!product) {
    console.error("Product is undefined:", product);
    return null; // or show an appropriate error message
  }

  const { id, title, price, main_picture, categories, ending_date } = product;

  const imageUrl = main_picture?.url
    ? `${API_URL}${main_picture.url}`
    : "/placeholder.png";

  // Calculate remaining time
  const remainingTime = calculateRemainingTime(ending_date);

  return (
    <div className="relative lottery">
          {/* Favorites Button */}
      <div className="absolute top-3 right-3 z-10">
        <SaveToFavoritesButton
          productId={product.id}
          onFavoriteChange={onFavoriteChange}
        />
      </div>
    <Link
        className={`${borderless ? "" : "border"} ${colorless ? "" : "bg-green-50"} p-4 hover:bg-gray-50 flex flex-col z-0`}
      href={`/product/${product.documentId}`}
    >
      <div className="product-card">
        <div className="product-images relative">
          {/* Product Image */}
          <img
            src={imageUrl}
            alt={title}
            className="w-full h-48 object-cover mb-2"
          />
          {/* Categories badge */}
          <div className="absolute top-0 left-0">
            {categories?.length > 0
              ? categories.map((category: any, index: number) => (
                  <span
                    className="text-white rounded-full bg-blue-950 py-1 px-4 text-sm"
                    key={category.id || `category-${index}`}
                  >
                    {category.category_name}
                    {index < categories.length - 1 && ", "}
                  </span>
                ))
              : "No categories available"}
          </div>

        </div>
        <div className="product-details flex flex-col">
          <div className="title min-h-16">
            {/* Product Title */}
            <h2 className="text-xl font-semibold">{title}</h2>
          </div>
          <div className="middle">
            <div className="flex items-center justify-between py-2">
              <div className="flex flex-col text-center">
                {/* Base Price */}
                <p className="text-gray-600 text-xs">Utgångspris</p>
                <p className="text-gray-900 font-bold text-sm">{price ?? 0} SEK</p>
              </div>
              <div className="flex flex-col text-center">
                {/* Total Lottery Users */}
                <p className="text-gray-600 text-xs">Antal deltagare</p>
                <p className="text-gray-900 font-bold text-sm">
                  {Array.isArray(product.lottery_users) ? product.lottery_users.length : 0}
                </p>
              </div>
            </div>
            <div className="items-center flex flex-col justify-center min-h-14 mb-3">
              {/* Remaining Time */}
              {remainingTime ? (
                <>
                  <p className="text-gray-600 text-xs">Lotteri avslutas</p>
                  <p className="text-gray-800 font-bold text-lg">{remainingTime}</p>
                </>
              ) : (
                <p className="text-red-500">Lotteri avslutades</p>
              )}
            </div>
          </div>
        </div>
      </div>
    </Link>
    </div>
  );
}
