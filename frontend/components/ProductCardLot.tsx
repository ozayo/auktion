// components/ProductCardLot.tsx

import Link from "next/link";
import { API_URL } from "../lib/api";
import { calculateRemainingTime } from "@/utils/calculateRemainingTime";

interface ProductCardLotProps {
  product: any;
  showCategories?: boolean; // New prop to toggle categories
}

export default function ProductCardLot({ product, showCategories = true }: ProductCardLotProps) {
  if (!product) {
    console.error("Product is undefined:", product);
    return null; // or show an appropriate error message
  }

  const { id, title, price, main_picture, categories, lottery_users, ending_date } = product;

  // Debugging lottery_users
  // console.log("Lottery Users for product:", product.title, lottery_users);


  const imageUrl = main_picture?.url
    ? `${API_URL}${main_picture.url}`
    : "/placeholder.png";

  // Calculate remaining time
  const remainingTime = calculateRemainingTime(ending_date);

  return (
    <Link
      className="border bg-green-50 p-4 hover:bg-gray-50 flex flex-col"
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
          <div className="absolute top-0 right-0">
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
  );
}
