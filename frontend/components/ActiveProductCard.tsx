"use client";

import Image from 'next/image';
import Link from 'next/link';
import { ProductWithStatus } from '@/types';
import { calculateRemainingTime } from "@/utils/calculateRemainingTime";
import SaveToFavoritesButton from './SaveToFavoritesButton';


interface ActiveProductCardProps {
  product: ProductWithStatus;
  onFavoriteChange?: () => void;
}

const ActiveProductCard = ({ product, onFavoriteChange, }: ActiveProductCardProps) => {
  const remainingTime = calculateRemainingTime(product.ending_date);
  const cardClassName = `border bg-white py-4 px-6 hover:bg-zinc-50 overflow-hidden ${
    product.type === 'lottery' ? 'lottery' : 'bidding'
  }`;
  

  return (
    <div className={cardClassName}>
      {/* Product title*/}
      <div className="pb-4">
        <h2 className="text-2xl font-semibold">{product.title}</h2>
      </div>

      {/* Product card - 3 col Grid */}
      <div className="flex flex-col sm:flex-row gap-4">
        {/* Product image */}
        <div className="relative w-full sm:w-3/12 min-h-48 rounded-lg overflow-hidden">
          <Image
            src={product.main_picture?.url || '/placeholder.png'}
            alt={product.title}
            width={800}
            height={800}
            className="object-cover rounded h-48"
          />
          {/* Categories */}
          <div className="absolute top-2 left-1">
            {product.categories && product.categories.length > 0 ? (
              <span className="text-white rounded-full bg-blue-950 py-1 px-4 text-sm mr-2">
                {product.categories[0].category_name}
              </span>
            ) : (
              <span className="text-gray-500 text-sm">No categories</span>
            )}
          </div>
          {/* Favorites Button */}
          <div
            className="absolute top-0 right-0 z-10 hover:scale-110">
            <SaveToFavoritesButton
              productId={product.id}
              onFavoriteChange={onFavoriteChange}
            />
          </div>
        </div>

        {/* Product details */}
        <div className="infoarea flex flex-col w-full sm:w-5/12 px-4">
          <div className='flex flex-col gap-1 justify-between'>
            <p className='text-gray-700 text-sm'><strong>Product ID:</strong> {product.documentId}</p>
            <p className='text-gray-700 text-sm'><strong>Kategori:</strong> {product.categories?.[0]?.category_name}</p>
            <p className='text-gray-700 text-sm'><strong>Utgångspris:</strong> {product.price} SEK</p>
            
            {product.type === 'bidding' && (
              <p className='text-gray-700 text-sm'><strong>Antal bud:</strong> {product.total_bids || 0}</p>
            )}
            
            {product.type === 'lottery' && (
              <>
                <p className='text-gray-700 text-sm'><strong>Antal deltagare:</strong> {product.lottery_users?.length || 0}</p>
                <p className='text-gray-700 text-sm'><strong>Lotteri typ:</strong> {product.manual_lottery ? 'Manuell' : 'Automatisk'}</p>
              </>
          )}
          </div>
          <div className="flex flex-col mt-3">
            <div className='w-48 border-t pb-2'> </div>
            <p className="text-gray-600 text-xs">
              {product.type === 'lottery' ? 'Lotteri avslutas:' : 'Budgivning avslutas:'}
            </p>
            <p className='text-gray-800 font-bold text-lg'>{remainingTime}</p>
          </div>
        </div>

        {/* User status info */}
        <div className="winnerarea w-full sm:w-4/12">
          {product.type === 'bidding' ? (
            <>
              <div className="bg-gray-100 p-2 mb-2 rounded">
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
              <p className='text-gray-700 text-sm'>Ledande bud: <strong>{product.highest_bid || 0} SEK </strong></p>
              <p className='text-gray-700 text-sm'>Mitt högsta bud: <strong>{product.userBid || 0} SEK </strong></p>
            </>
          ) : (
            <div>
              <div className='bg-gray-100 p-2 mb-2 rounded'>
                  <p className="text-green-600 font-semibold">Du har registrerats! 👍</p>
              </div>
              <p className="text-sm text-gray-600 mt-2">
                För att ta bort dig själv från produkten, besök produktsidan
              </p>
            </div>
          )}
          
          {/* Product link */}
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