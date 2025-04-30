"use client";

import React, { useState } from "react";
import Link from "next/link";
import Image from "next/image";
import SaveToFavoritesButton from "@/components/SaveToFavoritesButton";
import LotteryRegistrationButton from "./custom/lottery-registration-button";
import BiddingButton from "./custom/bidding-button";
import Countdown from "./Countdown";
import { formatCurrency } from "@/lib/utils";
import { API_URL } from "@/lib/api";
import { calculateRemainingTime } from "@/utils/calculateRemainingTime";
import { Product } from "@/types";
import { useCategories } from "@/contexts/CategoryContext";

interface FavoriteProductCardProps {
  product: Product & {
    isRegistered?: boolean;
    highestBid?: number;
    userBid?: number;
    type: 'bidding' | 'lottery';
  };
  onFavoriteChange?: (documentId?: string) => void;
}

const FavoriteProductCard: React.FC<FavoriteProductCardProps> = ({
  product,
  onFavoriteChange,
}) => {
  const { categories: allCategories } = useCategories();
  const {
    id,
    documentId,
    title,
    lottery_product,
    price,
    ending_date,
    main_picture,
    categories,
    isRegistered,
    highestBid,
    userBid,
    type
  } = product;

  const [loading, setLoading] = useState(false);
  const endDate = new Date(ending_date);
  const hasEnded = new Date() > endDate;
  
  // Resim URL'sini hazırla - farklı veri yapılarını ele al
  let imageUrl = "/placeholder.jpg";
  try {
    if (main_picture) {
      const mp = main_picture as any;
      if (mp.data?.attributes?.url) {
        imageUrl = `${API_URL}${mp.data.attributes.url}`;
      } else if (mp.data?.attributes?.formats?.thumbnail?.url) {
        imageUrl = `${API_URL}${mp.data.attributes.formats.thumbnail.url}`;
      } else if (typeof mp === 'object' && 'url' in mp) {
        imageUrl = `${API_URL}${mp.url}`;
      } else if (typeof mp === 'string') {
        imageUrl = mp.startsWith('http') ? mp : `${API_URL}${mp}`;
      }
    }
  } catch (error) {
    console.error("Error processing image URL:", error);
    imageUrl = "/placeholder.jpg";
  }
  
  // Kategori eşleştirme mantığı
  let productCategories: any[] = [];
  
  // Debug için API'den gelen tüm ürün bilgilerini konsola yazdıralım
  console.log("Product full data:", product);
  console.log("Product categories raw:", product?.categories);
  
  try {
    // Eğer categories bir array ise (eski format)
    if (Array.isArray(categories) && categories.length > 0) {
      productCategories = categories;
    } 
    // Eğer categories.data bir array ise (Strapi v5 format)
    else if ((categories as any)?.data && Array.isArray((categories as any).data)) {
      // Her bir categori için ID'yi çıkart
      const categoryIds = (categories as any).data.map((cat: any) => cat.id);
      // CategoryContext'ten ID'lere göre kategori bilgilerini bul
      productCategories = allCategories.filter(cat => categoryIds.includes(cat.id));
    }
    
    console.log("Matched product categories:", productCategories);
  } catch (error) {
    console.error("Error matching categories:", error);
  }
  
  const handleFavoriteChange = () => {
    if (typeof onFavoriteChange === "function") {
      onFavoriteChange(documentId || String(id));
    }
  };

  const remainingTime = calculateRemainingTime(ending_date);
  const cardClassName = `product-card-wrapper relative border border-gray-200 bg-white hover:bg-gray-50 ${
    lottery_product ? 'lottery' : 'bidding'
  }`;

  return (
    <div className={cardClassName}>
      {/* Favorites Button */}
      <div className="absolute top-3 right-3 z-10 hover:scale-110">
        <SaveToFavoritesButton
          productId={id}
          onFavoriteChange={handleFavoriteChange}
        />
      </div>
    
      {/* Categories */}
      <div className="absolute top-4 left-4 flex gap-2 z-10">
        {productCategories.length > 0 ? (
          productCategories.map((category: any) => (
            <Link
              href={`/category/${category.slug}`}
              key={category.id}
              className="hover:opacity-90 transition-opacity"
              onClick={(e) => e.stopPropagation()}
            >
              <span className="text-white rounded-full bg-blue-950 py-1 px-4 text-sm inline-block">
                {category.category_name}
              </span>
            </Link>
          ))
        ) : (
          <span className="text-gray-500 text-sm">No categories</span>
        )}
      </div>

      {/* Product Link */}
      <Link className="block p-4" href={`/product/${documentId || id}`}>
        <div className="product-card">
          {/* Product Image */}
          <div className="product-images relative h-48 w-full">
            <img
              src={imageUrl}
              alt={title || "Product image"}
              className="w-full h-full object-cover mb-2"
            />
          </div>        
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
                  <p className="text-gray-900 font-bold text-sm">
                    {formatCurrency(price ?? 0)}
                  </p>
                </div>

                {lottery_product ? (
                  <div className="flex flex-col text-center">
                    <p className="text-gray-600 text-xs">Status</p>
                    {isRegistered ? (
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
                        {highestBid ? formatCurrency(highestBid) : "Inga bud"}
                      </p>
                    </div>
                    <div className="flex flex-col text-center">
                      <p className="text-gray-600 text-xs">Mitt högsta bud</p>
                      <p className="text-gray-900 font-bold text-sm">
                        {userBid ? formatCurrency(userBid) : "-"}
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
                      {lottery_product ? 'Lotteri avslutas' : 'Budgivning avslutas'}
                    </p>
                    <p className="text-gray-800 font-bold text-lg">
                      {remainingTime}
                    </p>
                  </>
                ) : (
                  <p className="text-red-500">
                    {lottery_product ? 'Lotteriet avslutades' : 'Budgivningen avslutades'}
                  </p>
                )}
              </div>
            </div>
          </div>
        </div>
      </Link>
    </div>
  );
};

export default FavoriteProductCard; 