"use client";

import Image from 'next/image';
import Link from 'next/link';
import { ProductWithStatus } from '@/types';
import { calculateRemainingTime } from "@/utils/calculateRemainingTime"


interface ActiveProductCardProps {
  product: ProductWithStatus;
}

const ActiveProductCard = ({ product }: ActiveProductCardProps) => {
  const remainingTime = calculateRemainingTime(product.ending_date);
  const cardClassName = `bg-white rounded-lg shadow-md overflow-hidden ${
    product.type === 'lottery' ? 'lottery' : 'bidding'
  }`;
  

  return (
    <div className={cardClassName}>
      {/* Product title*/}
      <div className="p-4 border-b">
        <h2 className="text-xl font-semibold">{product.title}</h2>
      </div>

      {/* Product card - 3 col Grid */}
      <div className="grid grid-cols-3 gap-4 p-4">
        {/* Product image */}
        <div className="relative h-48">
          <Image
            src={product.main_picture?.url || '/placeholder.png'}
            alt={product.title}
            fill
            className="object-cover rounded"
          />
          {/* Categories */}
          <div className="absolute top-0 left-0">
            {product.categories && product.categories.length > 0 ? (
              <span className="text-white rounded-full bg-blue-950 py-1 px-4 text-sm mr-2">
                {product.categories[0].category_name}
              </span>
            ) : (
              <span className="text-gray-500 text-sm">No categories</span>
            )}
          </div>     
        </div>

        {/* Product details */}
        <div className="space-y-2">
          <p>Product ID: {product.documentId}</p>
          <p>Kategori: {product.categories?.[0]?.category_name}</p>
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

        {/* User status info */}
        <div className="space-y-4">
          {product.type === 'bidding' ? (
            <>
              <div className="bg-gray-100 p-2 rounded">
                {product.userBid && product.highest_bid && product.userBid >= product.highest_bid ? (
                  <span className="text-green-600 font-semibold">
                    Du är högsta budgivare 🤘
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