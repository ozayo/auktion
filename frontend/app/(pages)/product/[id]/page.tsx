// app/product/[id]/page.tsx

"use client";

import { useState, useEffect } from 'react';
import { useParams } from 'next/navigation';
import { fetchAPI, API_URL } from '@/lib/api';
import BidForm from '@/components/BidForm';

export default function ProductPage() {
  const params = useParams();
  const documentId = params?.id;
  const [product, setProduct] = useState<any>(null);
  const [sortedBids, setSortedBids] = useState<any[]>([]);

  const fetchProductData = async () => {
    if (!documentId) return;

    try {
      const response = await fetchAPI(
        `/products/${documentId}?populate=*`
      );
      const productData = response.data; // We get the first (and only) product

      if (productData) {
        setProduct(productData);

        const bids = productData.bids || [];
        const sorted = [...bids].sort((a: any, b: any) => b.Amount - a.Amount);
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
    }, 3000); // Update every 3 seconds

    return () => clearInterval(interval);
  }, [documentId]);

  if (!product) {
    return <div>Product not found or loading...</div>;
  }

  const { id: productId, title, description, price, main_picture } = product;

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

      {/* List of Bidders*/}
      <h2 className="text-xl font-semibold mt-8">Erbjuder</h2>
      <ul>
        {sortedBids.map((bid: any) => (
          <li key={bid.id} className="border-b py-2">
            <p>
              <strong>{bid.biduser?.Name || 'Unknown User'}:</strong> {bid.Amount} SEK
            </p>
            <p className="text-gray-500 text-sm">
              Datum: {new Date(bid.createdAt).toLocaleString()}
            </p>
          </li>
        ))}
      </ul>

      {/* Bid Submission Form */}
      <BidForm productId={productId} />
    </main>
  );
}
