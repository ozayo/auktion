'use client';

import { useState, useEffect } from 'react';
import Link from 'next/link';
import { useSearchParams } from 'next/navigation';
import { GoDownload } from "react-icons/go";

type BidUser = {
  Name: string;
  email: string;
};

type Product = {
  id: number;
  title: string;
  documentId: string;
  ending_date: string;
  createdAt: string;
  lottery_product: boolean | null;
  bids: any[];
  price: number | null;
  totalBids?: number;
  uniqueBidders?: number;
  highestBid?: {
    Amount: number;
    biduser: BidUser;
  };
  main_picture: {
    url: string;
  };
};

// Helper function to format date consistently
function formatDate(dateString: string) {
  const date = new Date(dateString);
  return date.toISOString().split('T')[0]; // Returns YYYY-MM-DD format
}

export default function ProductListWithLoadMore({ products }: { products: Product[] }) {
  const [visibleProducts, setVisibleProducts] = useState(10);
  const [sortedProducts, setSortedProducts] = useState<Product[]>([]);
  const searchParams = useSearchParams();
  const sortParam = searchParams.get('sort');
  const sortOrder = sortParam === 'oldest' ? 'oldest' : 'newest';
  
  useEffect(() => {
    // Sort products based on ending_date
    const sorted = [...products].sort((a, b) => {
      const dateA = new Date(a.ending_date).getTime();
      const dateB = new Date(b.ending_date).getTime();
      return sortOrder === 'newest' ? dateB - dateA : dateA - dateB;
    });
    
    setSortedProducts(sorted);
  }, [products, sortOrder]);
  
  const loadMore = () => {
    setVisibleProducts(prev => prev + 10);
  };
  
  return (
    <>
      {/* Add sorting dropdown with links */}
      <div className="mt-4 mb-4 flex justify-end">
        <div className="flex items-center">
          <span className="mr-2 text-sm font-medium">Sortera:</span>
          <div className="border border-gray-200 rounded-md overflow-hidden flex">
            <Link 
              href="?sort=newest" 
              className={`px-3 py-1 text-sm ${sortOrder === 'newest' ? 'bg-blue-100 font-medium' : 'bg-white'}`}
            >
              Nyaste först
            </Link>
            <Link 
              href="?sort=oldest" 
              className={`px-3 py-1 text-sm ${sortOrder === 'oldest' ? 'bg-blue-100 font-medium' : 'bg-white'}`}
            >
              Äldsta först
            </Link>
          </div>
        </div>
      </div>
      
      <div className="mt-4 grid gap-6">
        {sortedProducts.slice(0, visibleProducts).map((product) => (
          <div key={product.documentId} className="border border-gray-200 bg-white py-4 px-6 hover:bg-zinc-50 overflow-hidden group">
            <h2 className="text-2xl font-bold mb-4">{product.title}</h2>
            <div className="flex flex-col sm:flex-row gap-4">
                {/* Product Image */}
                <div className="product-images relative w-full sm:w-3/12 min-h-48">
                  {product.main_picture && product.main_picture.url ? (
                    <img
                      className="w-full h-48 object-cover rounded-lg"
                      src={`${process.env.NEXT_PUBLIC_API_URL}${product.main_picture.url}`}
                      alt={product.title}
                    />
                  ) : (
                    <img
                      className="w-full h-48 object-cover rounded-lg"
                      src="/placeholder.png"
                      alt="Placeholder image"
                    />
                  )}                  
                </div>

                {/* Product Info */}
                <div className="infoarea flex flex-col w-full sm:w-5/12 px-4">
                  <div className='flex flex-col gap-1 justify-between'>
                    <p className='text-gray-700 text-sm'><strong>Product ID:</strong> {product.documentId}</p>
                    <p className='text-gray-700 text-sm'><strong>Skapat datum:</strong> {formatDate(product.createdAt)}</p>
                    <p className='text-gray-700 text-sm'><strong>Slutdatum:</strong> {formatDate(product.ending_date)}</p>                  
                    <p className='text-gray-700 text-sm'><strong>Utgångspris:</strong> {product.price || 0} SEK</p>
                    <p className='text-gray-700 text-sm'><strong>Antal bud:</strong> {product.totalBids || 0}</p>
                    <p className='text-gray-700 text-sm'><strong>Antal budgivare:</strong> {product.uniqueBidders || 0}</p>
                    <div className='w-48 border-t border-gray-200 pb-2 my-2'></div>
                        <Link href={`/product/${product.documentId}`} target="_blank" className='text-black inline-block text-sm hover:text-blue-600 font-black'>Gå till produkt ↗</Link>
                  </div>
                </div>
                <div className='winnerarea w-full sm:w-4/12 group-hover:bg-white border border-zinc-200 0 p-4 rounded-lg'>
                  {product.highestBid ? (
                    <div className='h-full flex flex-col items-center justify-center gap'>
                        <div className=" text-4xl">🥇</div>
                        <h2 className="text-xl font-bold text-amber-400">VINNARE</h2>
                        <p className='font-bold'>{product.highestBid.biduser.Name}</p>
                        <p className='text-sm'>{product.highestBid.biduser.email}</p>
                        <p className='text-sm'>Högsta budet: {product.highestBid.Amount} SEK</p>
                      </div>
                  ) : (
                    <p>No bids available for this product.</p>
                  )}                  
                </div>
            </div>
          </div>
        ))}
        
        {visibleProducts < sortedProducts.length && (
          <div className="flex justify-center mt-6">
            <button 
              onClick={loadMore}
              className="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600 transition-colors"
            >
              Ladda mer
            </button>
          </div>
        )}
      </div>
    </>
  );
} 