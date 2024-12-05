"use client";

import { useState, useEffect } from "react";
import { useParams } from "next/navigation";
import { fetchAPI, API_URL } from "@/lib/api";
import BidForm from "@/components/BidForm";
import BidderList from "@/components/BidderList";
import ProductImage from "@/components/ProductImage";
import EndInfo from "@/components/EndInfo";
import { calculateRemainingTime } from "@/utils/calculateRemainingTime";
import { dateFormatShort } from "@/utils/dateFormat";
import Link from "next/link";

export default function ProductPage() {
  const params = useParams();
  const documentId = params?.id;
  const [product, setProduct] = useState<any>(null);
  const [sortedBids, setSortedBids] = useState<any[]>([]);

  const totalBids = sortedBids.length;

  const fetchProductData = async () => {
    if (!documentId) return;

    try {
      const response = await fetchAPI(
        `/products/${documentId}?populate[0]=bids&populate[1]=bids.biduser&populate[2]=main_picture&populate[3]=gallery&populate[4]=categories`
      );
      const productData = response.data;

      if (productData) {
        const bids = productData.bids || [];
        const sorted = [...bids].sort((a: any, b: any) =>
          new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime()
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
      fetchProductData();
    }, 5000); // Update every 5 seconds

    return () => clearInterval(interval);
  }, [documentId]);

  if (!product) {
    return <div>Product not found or loading...</div>;
  }

  const { title, description, price, main_picture, gallery, categories, ending_date } = product;

  // Highest info
  const highestBid = sortedBids.length > 0 ? sortedBids[0].Amount : null;
  const highestBidder = sortedBids.length > 0 ? sortedBids[0].biduser?.Name : "Unknown";

  // RemainingTime
  const remainingTime = calculateRemainingTime(ending_date);
  // Formatted Ending Date
  const formattedEndingDate = dateFormatShort(ending_date);

  return (
    <div className="py-6 grid grid-cols-1 lg:grid-cols-2 gap-8">
      <div className="flex flex-col">
        {/* Product Image */}
        <ProductImage
          mainPicture={{
            url: main_picture?.url ? `${API_URL}${main_picture.url}` : "/placeholder.png",
          }}
          gallery={gallery?.map((img: any) => ({
            url: `${API_URL}${img.url}`,
          }))}
        />
      </div>
      <div className="flex flex-col">
        <h1 className="text-3xl font-bold">{title}</h1>
              <p className="text-gray-600 mt-2">
        Kategori:{" "}
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
      
        <div className="flex items-center justify-between mt-4">
          <div className="flex flex-col text-center">
            <p className="text-gray-600 text-xs">Utgångspris</p>
            <p className="text-gray-900 font-bold">{price} SEK</p>
          </div>
          <div className="flex flex-col text-center">
            {highestBid !== null && (
              <>
                <p className="text-gray-600 text-xs">Ledande bud</p>
                <p className="text-gray-900 font-bold">{highestBid} SEK</p>
              </>
            )}
          </div>
          <div className="flex flex-col text-center">
            <p className="text-gray-600 text-xs">Antal bud</p>
            <p className="text-gray-900 font-bold">{totalBids}</p>
          </div>
          {/* Auction Ending Countdown */}
          <div className="flex flex-col text-center">
            {remainingTime ? (
              <p className="text-gray-600 text-xs">Budgivning avslutas</p>
            ) : (
              <p className="text-gray-600 text-xs">Budgivningen avslutades</p>
            )}
            {remainingTime ? (
              <p className="text-gray-900 font-bold">{remainingTime}</p>
              ) : (
              <p className="text-gray-900 font-bold">{formattedEndingDate}</p>
            )}
          </div>
          
          {/* Auction Ending Date */}
          {/* {remainingTime &&
            <p className="text-gray-600 mt-2">
              Slutar: <p className="font-semibold">{formattedEndingDate}</p>
            </p>} */}
        </div>
        {/* Bid Submission Form */}
        {remainingTime ? (
          <BidForm productId={product.id}/>
        ) : (
          <EndInfo username={highestBidder} highestBid={highestBid || 0} />
        )}
        {/* List of Bidders */}
        <BidderList bids={sortedBids} />
      </div>
      <div className="lg:col-span-2 mt-8">
        <h2 className="text-2xl font-bold my-2">Beskrivning</h2>
        <p className="whitespace-pre-line">{description}</p>
      </div>
    </div>
  );
}
