// frontend/app/(pages)/winners/bidding-winners/page.tsx

import { fetchAPI } from '@/lib/api';
import Link from 'next/link';
import BackButton from '@/components/BackButton';
import ProductListWithLoadMore from './ProductListWithLoadMore';

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

export default async function BiddingWinnersPage() {
  let products: Product[] = [];
  let error: string | null = null;

  try {
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

      <div className='w-full flex flex-row justify-between align-middle '>
        <h1 className='text-3xl font-bold mb-4 w-9/12'>Budvinnare arkiv</h1>
        <div className='flex align-middle justify-end items-start w-3/12'>
          <BackButton />
        </div>
      </div>

      <p>Detta är arkivet för budvinnare; du kan se alla vinnare av auktionsprodukter här.</p>

      {error ? (
        <p className="text-red-500">{error}</p>
      ) : (
        <ProductListWithLoadMore products={products} />
      )}
    </div>
  );
}
