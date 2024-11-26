// app/product/[id]/page.tsx
"use client";

import { useState, useEffect } from "react";
import { useParams } from "next/navigation";
import { fetchAPI, API_URL } from "@/lib/api";
import BidForm from "@/components/BidForm";
import BidderList from "@/components/BidderList";
import ProductImage from "@/components/ProductImage";

export default function ProductPage() {
  const params = useParams();
  const documentId = params?.id;
  const [product, setProduct] = useState<any>(null);
  const [sortedBids, setSortedBids] = useState<any[]>([]);
  const highestBid = sortedBids.length > 0 ? sortedBids[0].Amount : null;


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

  const { title, description, price, main_picture, gallery, categories } =
    product;

  return (
    <div className="py-6 grid grid-cols-1 lg:grid-cols-2 gap-8">
      <div className="flex flex-col">
        {/* Product Image */}
        <ProductImage
          mainPicture={{
            url: `${API_URL}${main_picture.url}`
          }}
          gallery={gallery?.map((img: any) => ({
            url: `${API_URL}${img.url}`
          }))}
        />
      </div>
      <div className="flex flex-col">
        <h1 className="text-3xl font-bold">{title}</h1>
        <p className="text-gray-600 mt-2">
          Categories:{" "}
          {categories
            ?.map((cat: any) => cat.category_name)
            .join(", ") || "No categories available"}
        </p>
        <div className="flex items-center justify-between mt-4">
          <p className="text-gray-600 ">Utgångspris: {price} SEK</p>
          {highestBid !== null && (
            <p className="text-gray-600 font-bold">Högsta bud: {highestBid} SEK</p>
          )}
          <p className="text-gray-600">12 bid</p>
          <p className="text-gray-600">3 DAYS 12 HOURS 8 MIN</p>
        </div>
        {/* Bid Submission Form */}
        <BidForm productId={product.id} />
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
