"use client";

import Image from 'next/image';
import Link from 'next/link';
import { ProductWithStatus } from '@/types';
import { calculateRemainingTime } from "@/utils/calculateRemainingTime"
import { useEffect } from 'react';

interface ActiveProductCardProps {
  product: ProductWithStatus;
}

const formatDate = (dateString: string) => {
  return new Date(dateString).toLocaleString('sv-SE', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit'
  });
};

const ActiveProductCard = ({ product }: ActiveProductCardProps) => {
  const remainingTime = calculateRemainingTime(product.ending_date);
  
  // Debug bilgisini useEffect içinde yapalım
  useEffect(() => {
    if (product.type === 'bidding') {
      console.log('Card Product:', product.title, {
        isHighestBidder: product.isHighestBidder,
        userBid: product.userBid,
        highestBid: product.highest_bid
      });
    }
  }, [product]);

  return (
    <div className="bg-white rounded-lg shadow-md overflow-hidden">
      {/* Ürün Başlığı */}
      <div className="p-4 border-b">
        <h2 className="text-xl font-semibold">{product.title}</h2>
      </div>

      {/* Ana İçerik - 3 Kolonlu Grid */}
      <div className="grid grid-cols-3 gap-4 p-4">
        {/* Ürün İmajı */}
        <div className="relative h-48">
          <Image
            src={product.main_picture?.url || '/placeholder.png'}
            alt={product.title}
            fill
            className="object-cover rounded"
          />
        </div>

        {/* Ürün Bilgileri */}
        <div className="space-y-2">
          <p>Product ID: {product.documentId}</p>
          <p>Kategori: {product.categories?.[0]?.category_name}</p>
          <p>Skapat datum: {formatDate(product.createdAt)}</p>
          <p>Utgångspris: {product.price} SEK</p>
          
          {product.type === 'bidding' && (
            <p>Antal bud: {product.total_bids || 0}</p>
          )}
          
          {product.type === 'lottery' && (
            <>
              <p>Antal deltagare: {product.lottery_users?.length || 0}</p>
              <p>Manual Lottery: {product.manual_lottery ? 'Yes' : 'No'}</p>
            </>
          )}
          
          <div className="mt-4">
            <h3 className="font-semibold">
              {product.type === 'lottery' ? 'Lotteri avslutas' : 'Budgivning avslutas'}
            </h3>
            <p>{remainingTime}</p>
          </div>
        </div>

        {/* User Durum Bilgisi */}
        <div className="space-y-4">
          {product.type === 'bidding' ? (
            <>
              <div className="bg-gray-100 p-2 rounded">
                {product.userBid && product.highest_bid && product.userBid >= product.highest_bid ? (
                  <span className="text-green-600 font-semibold">
                    Du leder budgivningen!
                  </span>
                ) : (
                  <span className="text-yellow-600 font-semibold">
                    Du är inte högsta budgivare
                  </span>
                )}
              </div>
              <p>Antal bud: {product.total_bids || 0}</p>
              <p>Ledande bud: {product.highest_bid || 0} SEK</p>
              <p>Mitt högsta bud: {product.userBid || 0} SEK</p>
            </>
          ) : (
            <div>
              <p className="text-green-600 font-semibold">Du har registrerats!</p>
              <p className="text-sm text-gray-600 mt-2">
                För att ta bort dig själv från produkten, besök produktsidan
              </p>
            </div>
          )}
          
          <Link 
            href={`/product/${product.documentId}`}
            className="block w-full mt-4 px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600 text-center"
          >
            Gå till produkt
          </Link>
        </div>
      </div>
    </div>
  );
};

export default ActiveProductCard; 