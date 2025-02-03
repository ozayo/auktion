import Image from 'next/image';
import Link from 'next/link';
import { ProductWithStatus } from '@/types';
import { dateFormatWithouth } from "@/utils/dateFormat";
import { API_URL } from "@/lib/api";

interface WonProductCardProps {
  product: ProductWithStatus;
}

const WonProductCard = ({ product }: WonProductCardProps) => {
  const cardClassName = `border bg-white py-4 px-6 hover:bg-zinc-50 overflow-hidden ${
    product.type === 'lottery' ? 'lottery' : 'bidding'
  }`;

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
        <div className="relative w-full sm:w-3/12 min-h-48 rounded-lg overflow-hidden">
          <Image
            src={imageUrl}
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
        <div className="infoarea flex flex-col w-full sm:w-5/12 px-4">
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
          {/* Winning status */}
          <div className="mt-4">
            <span className="text-green-600 font-semibold">
              Du vinner
            </span>
          </div>

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

export default WonProductCard; 