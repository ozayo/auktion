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
      const productData = response.data; // İlk (ve tek) ürünü alıyoruz

      if (productData) {
        setProduct(productData);

        const bids = productData.bids || [];
        const sorted = [...bids].sort((a: any, b: any) => b.Amount - a.Amount);
        setSortedBids(sorted);
      } else {
        setProduct(null);
      }
    } catch (error) {
      console.error('Ürün verileri alınırken hata oluştu:', error);
      setProduct(null);
    }
  };

  useEffect(() => {
    fetchProductData();

    const interval = setInterval(() => {
      fetchProductData();
    }, 3000); // 3 saniyede bir güncelle

    return () => clearInterval(interval);
  }, [documentId]);

  if (!product) {
    return <div>Ürün bulunamadı veya yükleniyor...</div>;
  }

  const { id: productId, title, description, price, main_picture } = product;

  return (
    <main className="container mx-auto p-4">
      <h1 className="text-2xl font-bold mb-4">{title}</h1>
      {/* Ürün Bilgileri */}
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
      <p className="text-gray-700 mt-2">Başlangıç Fiyatı: {price} TL</p>

      {/* Teklif Verenlerin Listesi */}
      <h2 className="text-xl font-semibold mt-8">Teklifler</h2>
      <ul>
        {sortedBids.map((bid: any) => (
          <li key={bid.id} className="border-b py-2">
            <p>
              <strong>{bid.biduser?.Name || 'Bilinmeyen Kullanıcı'}:</strong> {bid.Amount} TL
            </p>
            <p className="text-gray-500 text-sm">
              Tarih: {new Date(bid.createdAt).toLocaleString()}
            </p>
          </li>
        ))}
      </ul>

      {/* Teklif Verme Formu */}
      <BidForm productId={productId} />
    </main>
  );
}
