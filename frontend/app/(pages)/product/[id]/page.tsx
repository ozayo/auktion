// app/product/[id]/page.tsx

"use client";

import { useState, useEffect } from 'react';
import { useParams } from 'next/navigation';
import { fetchAPI, API_URL } from '@/lib/api';
import BidForm from '@/components/BidForm';
import BidderList from '@/components/BidderList';

export default function ProductPage() {
  const params = useParams();
  const documentId = params?.id;
  const [product, setProduct] = useState<any>(null);
  const [sortedBids, setSortedBids] = useState<any[]>([]);

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
      console.error('Error retrieving product data:', error);
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

  const { id: productId, title, description, price, main_picture, category_name, categories } = product;

  return (
    <main className="container mx-auto p-4">
      <h1 className="text-2xl font-bold mb-4">{title}</h1>
      {/* Product Information*/}
      <img
        src={
          main_picture?.url
            ? `${API_URL}${main_picture.url}`
            : '/placeholder.png'
        }
        alt={title}
        className="w-full h-64 object-cover mb-4"
      />
      <p>{description}</p>
      <p className="text-gray-700 mt-2">Utgångspris: {price} SEK</p>
      <p className="text-gray-700 mt-2">
        Categories: {categories.map((cat: any) => cat.category_name).join(', ') || 'No categories available'}
      </p>

      {/* List of Bidders*/}
      <BidderList bids={sortedBids} />

      {/* Bid Submission Form */}
      <BidForm productId={productId} />
    </main>
  );
}
