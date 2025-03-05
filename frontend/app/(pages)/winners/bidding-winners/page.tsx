// frontend/app/(pages)/winners/bidding-winners/page.tsx

import { fetchAPI } from '@/lib/api';
import { Metadata } from 'next';
import Link from 'next/link';
import BackButton from '@/components/BackButton';

type BidUser = {
  Name: string;
  email: string;
};

type Bid = {
  Amount: number;
  documentId: string;
  biduser: BidUser;
};

type Product = {
  id: number;
  title: string;
  documentId: string;
  ending_date: string;
  createdAt: string;
  lottery_product: boolean | null;
  bids: Bid[];
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

export const metadata: Metadata = {
  title: 'Bidding Winners',
  description: 'List of all bidding winners.',
};

export default async function BiddingWinnersPage() {
  let products: Product[] = [];
  let error: string | null = null;

  try {
    // filter products that are not lottery products and have ended
    const productResponse = await fetchAPI('/products?populate=*');
    const now = new Date();

    const filteredProducts = productResponse.data.filter((product: any) => {
      return (
        (product.lottery_product === false || product.lottery_product === null) &&
        new Date(product.ending_date) < now
      );
    });

    // Find the highest bid for each product and get user details
    const productsWithWinners = await Promise.all(
      filteredProducts.map(async (product: any) => {
        const bids = product.bids || [];
        if (bids.length === 0) return null;

        // Find the highest bid
        const highestBid = bids.reduce((max: any, bid: any) =>
          bid.Amount > max.Amount ? bid : max
        );

        // Fetch detailed bid information for each bid in the product
        const detailedBids = await Promise.all(
          bids.map(async (bid: any) => {
            try {
              const bidResponse = await fetchAPI(`/bids/${bid.documentId}?populate=*`);
              return bidResponse.data;
            } catch (error) {
              console.error(`Error fetching bid ${bid.documentId}:`, error);
              return null;
            }
          })
        );

        // Filter out any null responses
        const validBids = detailedBids.filter(bid => bid !== null);

        // Calculate unique bidders using the detailed bid information
        const uniqueBidderIds = new Set();
        validBids.forEach((bid: any) => {
          if (bid && bid.biduser && bid.biduser.email) {
            uniqueBidderIds.add(bid.biduser.email);
          }
        });

        const uniqueBidders = uniqueBidderIds.size;

        // Get user details for the highest bid
        const highestBidDetailed = validBids.find(
          (bid: any) => bid && bid.documentId === highestBid.documentId
        );

        return {
          ...product,
          totalBids: bids.length,
          uniqueBidders,
          highestBid: highestBidDetailed ? {
            Amount: highestBidDetailed.Amount,
            biduser: highestBidDetailed.biduser || { Name: 'Unknown', email: 'Unknown' },
          } : null,
        };
      })
    );

    products = productsWithWinners.filter((product) => product !== null);
  } catch (err) {
    error = 'Failed to fetch bidding winners.';
    console.error(err);
  }

  return (
    <div className='w-full mx-auto pt-8 pb-14'>

      <div className='w-full flex sm:flex-row flex-col justify-between align-middle '>
        <h1 className='text-3xl font-bold order-2 sm:order-1 mb-4 w-9/12'>Budvinnare arkiv</h1>
        <div className='flex align-middle order-1 sm:order-2 justify-end items-start w-full sm:w-3/12'>
          <BackButton />
        </div>
      </div>

      <p>Detta är arkivet för budvinnare; du kan se alla vinnare av auktionsprodukter här.</p>

      {error ? (
        <p className="text-red-500">{error}</p>
      ) : (
        <div className="mt-4 grid gap-6">
          {products.map((product) => (
          
          <div key={product.documentId} className="border bg-white py-5 px-6 hover:bg-zinc-50 overflow-hidden group">
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
                    <p className='text-gray-700 text-sm'><strong>Skapat datum:</strong> {new Date(product.createdAt).toLocaleString()}</p>
                    <p className='text-gray-700 text-sm'><strong>Slutdatum:</strong> {new Date(product.ending_date).toLocaleString()}</p>                  
                    <p className='text-gray-700 text-sm'><strong>Utgångspris:</strong> {product.price || 0} SEK</p>
                    <p className='text-gray-700 text-sm'><strong>Antal bud:</strong> {product.totalBids || 0}</p>
                    <p className='text-gray-700 text-sm'><strong>Antal budgivare:</strong> {product.uniqueBidders || 0}</p>
                    <div className='w-48 border-t pb-2 my-2'></div>
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
        </div>
      )}
    </div>
  );
}
