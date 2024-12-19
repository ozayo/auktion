// product/[id]/page.tsx
"use client";
import { useState, useEffect } from "react";
import { useParams } from "next/navigation";
import { fetchAPI, API_URL } from "@/lib/api";
import BidForm from "@/components/BidForm";
import LotForm from "@/components/LotForm";
import BidderList from "@/components/BidderList";
import BidderListLot from "@/components/BidderListLot";
import ProductImage from "@/components/ProductImage";
import EndInfo from "@/components/EndInfo";
import EndInfoLot from "@/components/EndInfoLot";
import { calculateRemainingTime } from "@/utils/calculateRemainingTime";
import { dateFormatShort } from "@/utils/dateFormat";
import Link from "next/link";
import SaveToFavoritesButton from "@/components/SaveToFavoritesButton";
interface ProductPageProps {
  onFavoriteChange?: () => void; // Optional callback function
}
export default function ProductPage({onFavoriteChange}: ProductPageProps) {
  const params = useParams();
  const documentId = params?.id;
  const [product, setProduct] = useState<any>(null);
  const [sortedBids, setSortedBids] = useState<any[]>([]);
  // Called every 5 seconds for bidding products but also used for immediate refresh after register/unregister actions.
  const fetchProductData = async () => {
    if (!documentId) return;
    try {
      const response = await fetchAPI(
        `/products/${documentId}?populate[0]=bids.biduser&populate[1]=main_picture&populate[2]=gallery&populate[3]=categories&populate[4]=lottery_users.biduser`
      );
      const productData = response.data;
      if (productData) {
        const bids = productData.bids || [];
        const sorted = [...bids].sort(
          (a: any, b: any) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime()
        );
        setProduct(productData);
        setSortedBids(sorted);
      } else {
        setProduct(null);
      }
    } catch (error) {
      console.error("Error retrieving product data:", error);
      setProduct(null);
    }
  };
  useEffect(() => {
    fetchProductData();
    const interval = setInterval(() => {
      // Refreshes data every 5 seconds for bidding products
      fetchProductData();
    }, 5000);
    return () => clearInterval(interval);
  }, [documentId]);
  if (!product) {
    return <div>Product not found or loading...</div>;
  }
  const isLotteryProduct = product.lottery_product === true;
  const { title, description, price, main_picture, gallery, categories, ending_date, lottery_users } = product;
  const totalBids = sortedBids.length;
  const highestBid = sortedBids.length > 0 ? sortedBids[0].Amount : null;
  const highestBidder = sortedBids.length > 0 ? sortedBids[0].biduser?.Name : "Unknown";
  const remainingTime = calculateRemainingTime(ending_date);
  const formattedEndingDate = dateFormatShort(ending_date);
  // This callback is passed to LotForm to immediately refresh data after register/unregister actions
  const handleImmediateUpdate = () => {
    fetchProductData();
  };
  return (
    <div className="py-6 grid grid-cols-1 lg:grid-cols-2 gap-8">
      <div className="flex flex-col">
        <ProductImage
          mainPicture={{
            url: main_picture?.url
              ? `${API_URL}${main_picture.url}`
              : "/placeholder.png",
          }}
          gallery={gallery?.map((img: any) => ({
            url: `${API_URL}${img.url}`,
          }))}
        />
      </div>
      <div className="flex flex-col">
        <h1 className="text-3xl font-bold">{title}</h1>
        <div className="flex flex-row justify-between">
          <p className="text-gray-600 mt-2">
            Kategori:{" "}
            {categories?.length > 0
              ? categories.map((category: any, index: number) => (
                  <span key={category.id}>
                    <Link
                      href={`/category/${category.slug}`}
                      className="text-blue-500 hover:underline"
                    >
                      {category.category_name}
                    </Link>
                    {index < categories.length - 1 && ", "}
                  </span>
                ))
              : "No categories available"}
          </p>
          <SaveToFavoritesButton
            productId={product.id}
            onFavoriteChange={onFavoriteChange}
            withText={true}
          />
        </div>
        <div className="flex items-center justify-between mt-4">
          <div className="flex flex-col text-center">
            <p className="text-gray-600 text-xs">Utgångspris</p>
            <p className="text-gray-900 font-bold text-sm">{price ?? 0} SEK</p>
          </div>
          {!isLotteryProduct && highestBid !== null && (
            <div className="flex flex-col text-center">
              <p className="text-gray-600 text-xs">Ledande bud</p>
              <p className="text-gray-900 font-bold">{highestBid} SEK</p>
            </div>
          )}
          <div className="flex flex-col text-center">
            {isLotteryProduct ? (
              <>
                <p className="text-gray-600 text-xs">Antal deltagare</p>
                <p className="text-gray-900 font-bold text-sm">
                  {Array.isArray(lottery_users) ? lottery_users.length : 0}
                </p>
              </>
            ) : (
              <>
                <p className="text-gray-600 text-xs">Antal bud</p>
                <p className="text-gray-900 font-bold">{totalBids}</p>
              </>
            )}
          </div>
          <div className="flex flex-col text-center">
            {remainingTime ? (
              <p className="text-gray-600 text-xs">
                {isLotteryProduct ? "Lotteri avslutas" : "Budgivning avslutas"}
              </p>
            ) : (
              <p className="text-gray-600 text-xs">
                {isLotteryProduct
                  ? "Lotteri avslutades"
                  : "Budgivningen avslutades"}
              </p>
            )}
            {remainingTime ? (
              <p className="text-gray-900 font-bold">{remainingTime}</p>
            ) : (
              <p className="text-gray-900 font-bold">{formattedEndingDate}</p>
            )}
          </div>
        </div>
        {remainingTime ? (
          isLotteryProduct ? (
            <LotForm
              productId={product.documentId}
              onUpdate={handleImmediateUpdate}
            />
          ) : (
            <BidForm productId={product.id} />
          )
        ) : isLotteryProduct ? (
          <EndInfoLot winner={product.lottery_winner?.biduser || null} />
        ) : (
          <EndInfo username={highestBidder} highestBid={highestBid || 0} />
        )}
        {isLotteryProduct ? (
          <BidderListLot lotteryUsers={product.lottery_users || []} />
        ) : (
          <BidderList bids={sortedBids} />
        )}
      </div>
      <div className="lg:col-span-2 mt-8">
        <h2 className="text-2xl font-bold my-2">Beskrivning</h2>
        <p className="whitespace-pre-line">{description}</p>
      </div>
    </div>
  );
}