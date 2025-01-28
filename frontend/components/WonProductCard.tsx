import Image from 'next/image';
import Link from 'next/link';
import { ProductWithStatus } from '@/types';
import { dateFormatWithouth } from "@/utils/dateFormat";
import { API_URL } from "@/lib/api";

interface WonProductCardProps {
  product: ProductWithStatus;
}

const WonProductCard = ({ product }: WonProductCardProps) => {
  const cardClassName = `bg-white rounded-lg shadow-md overflow-hidden ${
    product.type === 'lottery' ? 'lottery' : 'bidding'
  }`;

  const imageUrl = product.main_picture?.url 
    ? `${API_URL}${product.main_picture.url}`
    : '/placeholder.png';

  return (
    <div className={cardClassName}>
      {/* Ürün Başlığı */}
      <div className="p-4 border-b">
        <h2 className="text-xl font-semibold">{product.title}</h2>
      </div>
      <div className='grid grid-cols-3 gap-4 p-4'>
        {/* Ürün İmajı */}
        <div className="relative h-48">
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
        {/* Ürün Detayları */}
        <div className="space-y-2">
          <p>Kategori: {product.categories?.[0]?.category_name || 'N/A'}</p>
          <p>Utgångspris: {product.price || '0'} SEK</p>
          <p>Skapat datum: {dateFormatWithouth(product.createdAt)}</p>
          <p>
            {product.type === 'lottery' ? 'Lotteri avslutades' : 'Budgivningen avslutades'}: {' '}
            {dateFormatWithouth(product.ending_date)}
          </p>
          
          {product.type === 'lottery' && (
            <>
              <p>Antal deltagare: {product.lottery_users?.length || 0}</p>
              <p>Lotteri typ: {product.manual_lottery ? 'Manuell' : 'Automatisk'}</p>
            </>
          )}

          {product.type === 'bidding' && (
            <>
              <p>Antal bud: {product.total_bids || 0}</p>
              <p>Ledande bud: {product.highest_bid || 0} SEK</p>
              <p>Mitt högsta bud: {product.userBid || 0} SEK</p>
            </>
          )}
        </div>
        {/* Kazanma Durumu */}
        <div className='space-y-4'>
          {/* Kazanma Durumu */}
          <div className="mt-4">
            <span className="text-green-600 font-semibold">
              Du vinner
            </span>
          </div>

          {/* Ürün Linki */}
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