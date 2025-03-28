import Link from "next/link";
import { API_URL } from "@/lib/api";
import { calculateRemainingTime } from "@/utils/calculateRemainingTime";
import SaveToFavoritesButton from "./SaveToFavoritesButton";
import { Product } from "@/types";

interface FavoriteProductCardProps {
  product: Product & {
    isRegistered?: boolean;
    highestBid?: number;
    userBid?: number;
    type: 'bidding' | 'lottery';
  };
  onFavoriteChange?: () => void;
  
}

const getCategoryName = (categories: Product['categories']) => {
  if (!categories || categories.length === 0) {
    return null;
  }
  return categories[0]?.category_name;
};

export default function FavoriteProductCard({
  product,
  onFavoriteChange,
}: FavoriteProductCardProps) {
  const imageUrl = product.main_picture?.url
    ? `${API_URL}${product.main_picture.url}`
    : "/placeholder.png";

  const remainingTime = calculateRemainingTime(product.ending_date);
  const categoryName = getCategoryName(product.categories);
  const cardClassName = `product-card-wrapper relative border border-gray-200 bg-white hover:bg-gray-50 ${
    product.lottery_product ? 'lottery' : 'bidding'
  }`;

  return (
    <div className={cardClassName}>
      {/* Favorites Button */}
      <div className="absolute top-3 right-3 z-10 hover:scale-110">
        <SaveToFavoritesButton
          productId={product.id}
          onFavoriteChange={onFavoriteChange}
        />
      </div>
    
      {/* Categories */}
      <div className="absolute top-4 left-4 flex gap-2 z-10">
        {categoryName ? (
          <Link
            href={`/category/${product.categories?.[0]?.slug}`}
            className="hover:opacity-90 transition-opacity"
            onClick={(e) => e.stopPropagation()}
          >
            <span className="text-white rounded-full bg-blue-950 py-1 px-4 text-sm inline-block">
              {categoryName}
            </span>
          </Link>
        ) : (
          <span className="text-gray-500 text-sm">No categories</span>
        )}
      </div>


      {/* Product Link */}
      <Link className="block p-4" href={`/product/${product.documentId}`}>
        <div className="product-card">
          {/* Product Image */}
          <div className="product-images relative">
            <img
              src={imageUrl}
              alt={product.title}
              className="w-full h-48 object-cover mb-2"
            />
          </div>        
          <div className="product-details flex flex-col">
            {/* Product Title */}
            <div className="title min-h-16">
              <h2 className="text-xl font-semibold">{product.title}</h2>
            </div>

            {/* Middle Section */}
            <div className="middle">
              <div className="flex items-center justify-between py-2">
                {/* Base Price */}
                <div className="flex flex-col text-center">
                  <p className="text-gray-600 text-xs">Utgångspris</p>
                  <p className="text-gray-900 font-bold text-sm">
                    {product.price ?? 0} SEK
                  </p>
                </div>

                {product.lottery_product ? (
                  <div className="flex flex-col text-center">
                    <p className="text-gray-600 text-xs">Status</p>
                    {product.isRegistered ? (
                      <p className="text-green-600 font-semibold text-sm">
                        Du har registrerats!
                      </p>
                    ) : (
                      <p className="text-yellow-600 font-semibold text-sm">
                        Du är inte registrerad
                      </p>
                    )}
                  </div>
                ) : (
                  <>
                    <div className="flex flex-col text-center">
                      <p className="text-gray-600 text-xs">Ledande bud</p>
                      <p className="text-gray-900 font-bold text-sm">
                        {product.highestBid ? `${product.highestBid} SEK` : "Inga bud"}
                      </p>
                    </div>
                    <div className="flex flex-col text-center">
                      <p className="text-gray-600 text-xs">Mitt högsta bud</p>
                      <p className="text-gray-900 font-bold text-sm">
                        {product.userBid ? `${product.userBid} SEK` : "-"}
                      </p>
                    </div>
                  </>
                )}
              </div>

              {/* Remaining Time */}
              <div className="items-center flex flex-col justify-center min-h-14 mb-3">
                {remainingTime ? (
                  <>
                    <p className="text-gray-600 text-xs">
                      {product.lottery_product ? 'Lotteri avslutas' : 'Budgivning avslutas'}
                    </p>
                    <p className="text-gray-800 font-bold text-lg">
                      {remainingTime}
                    </p>
                  </>
                ) : (
                  <p className="text-red-500">
                    {product.lottery_product ? 'Lotteriet avslutades' : 'Budgivningen avslutades'}
                  </p>
                )}
              </div>
            </div>
          </div>
        </div>
      </Link>
    </div>
  );
} 