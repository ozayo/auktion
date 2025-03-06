import Image from 'next/image';
import Link from 'next/link';
import { ProductWithStatus } from '@/types';
import { dateFormatWithouth } from "@/utils/dateFormat";
import { API_URL } from "@/lib/api";
import SaveToFavoritesButton from './SaveToFavoritesButton';

interface WonProductCardProps {
  product: ProductWithStatus;
  onFavoriteChange?: () => void;
}

const WonProductCard = ({ product, onFavoriteChange, }: WonProductCardProps) => {
  const cardClassName = `border border-zinc-200 bg-white sm:py-5 p-3 sm:px-6 hover:bg-zinc-50 overflow-hidden group ${
    product.type === 'lottery' ? 'lottery' : 'bidding'
  }`;
  
  const totalPrice = () => {
   const totalPrice = (product.price || 0) + (product.userBid || 0);
   return totalPrice;
  }

  const imageUrl = product.main_picture?.url 
    ? `${API_URL}${product.main_picture.url}`
    : '/placeholder.png';

  return (
    <div className={cardClassName}>
      {/* Product title*/}
      <div className="pb-4">
        <h2 className="text-2xl font-semibold">{product.title}</h2>
      </div>

      {/* Product card - 3 col Grid */}
      <div className="flex flex-col sm:flex-row gap-4">
        {/* Product image */}
        <div className="product-images relative w-full sm:w-3/12 min-h-48 overflow-hidden">
          <Image
            src={imageUrl}
            alt={product.title}
            width={800}
            height={800}
            className="object-cover rounded-lg h-48"
          />
          {/* Categories */}
          <div className="absolute top-2 left-1 flex gap-2">
            {product.categories && product.categories.length > 0 ? (
              product.categories.map((category) => (
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
          {/* Favorites Button */}
          <div className="absolute top-1 right-1 z-10 hover:scale-110">
            <SaveToFavoritesButton
              productId={product.id}
              onFavoriteChange={onFavoriteChange}
            />
          </div>
        </div>

        {/* Product details */}
        <div className="infoarea flex flex-col w-full sm:w-5/12 sm:px-4">
          <div className='flex flex-col gap-1 justify-between'>
            <p className='text-gray-700 text-sm'><strong>Kategori:</strong> {product.categories?.[0]?.category_name || 'N/A'}</p>
            <p className='text-gray-700 text-sm'><strong>Utgångspris:</strong> {product.price || '0'} SEK</p>
            <p className='text-gray-700 text-sm'><strong>Skapat datum:</strong> {dateFormatWithouth(product.createdAt)}</p>
            
            {product.type === 'lottery' && (
              <>
                <p className='text-gray-700 text-sm'><strong>Antal deltagare:</strong> {product.lottery_users?.length || 0}</p>
                <p className='text-gray-700 text-sm'><strong>Lotteri typ:</strong> {product.manual_lottery ? 'Manuell' : 'Automatisk'}</p>
              </>
            )}

            {product.type === 'bidding' && (
              <>
                <p className='text-gray-700 text-sm'><strong>Antal bud:</strong> {product.total_bids || 0}</p>
                <p className='text-gray-700 text-sm'><strong>Ledande bud:</strong> {product.highest_bid || 0} SEK</p>
                <p className='text-gray-700 text-sm'><strong>Mitt högsta bud:</strong> {product.userBid || 0} SEK</p>
              </>
            )}
          </div>
          <div className="flex flex-col mt-3">
            <div className='w-48 border-t pb-2'> </div>
            <p className="text-gray-600 text-xs">
              {product.type === 'lottery' ? 'Lotteri avslutades:' : 'Budgivning avslutades:'}
            </p>
            <p className='text-gray-800 font-bold text-lg'>{dateFormatWithouth(product.ending_date)}</p>
          </div>
        </div>
        
        {/* User status info */}
        <div className="winnerarea w-full sm:w-4/12">
          <div className='flex flex-col gap-1 h-full'>
            {/* Winning status area */}
            <div className='group-hover:bg-white border border-zinc-200 0 p-5 rounded-lg'>

              {product.type === 'bidding' ? (
                <div className="mt-4 flex flex-col items-center">
                  <span className='text-4xl '>🥇</span>
                  <span className="text-xl font-bold text-amber-400">Du vinner</span>
                  <span className="text-gray-800 text-sm">Totalt pris du betalar: <span className='font-bold'>{totalPrice()} SEK</span></span>
                  <span className="text-gray-600 text-xs">(dit bud:{product.userBid || 0} + Utgångspris:{product.price || 0})</span>
                </div>
              ) : (
                <div className="mt-4 flex flex-col items-center">
                  <span className='text-4xl '>🏆</span>
                  <span className="text-xl font-bold text-amber-400">Du vinner</span>
                  <span className="text-gray-800 text-sm">Totalt pris du betalar: <span className='font-bold'>{product.price || 0} SEK</span></span>
                  <span className="text-gray-600 text-xs">(Utgångspris:{product.price || 0})</span>
                </div>
              )}
            </div>

            {/* Product link */}
            <Link 
              href={`/product/${product.documentId}`}
              className="hover:text-white rounded-lg bg-white py-2 px-5 my-3 inline-block hover:bg-blue-950 text-black border-zinc-200 hover:border-blue-950 border text-sm font-bold transition-colors">
              Gå till produkt →
            </Link>
          </div>
        </div>
        
      </div>
    </div>
  );
};

export default WonProductCard; 