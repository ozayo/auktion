import { fetchAPI } from '@/lib/api';
import { Metadata } from 'next';

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

        // Get user (bids) details
        const bidResponse = await fetchAPI(`/bids/${highestBid.documentId}?populate=*`);
        const biduser = bidResponse.data?.biduser;

        return {
          ...product,
          highestBid: {
            Amount: highestBid.Amount,
            biduser: biduser ? biduser : { Name: 'Unknown', email: 'Unknown' },
          },
        };
      })
    );

    products = productsWithWinners.filter((product) => product !== null);
  } catch (err) {
    error = 'Failed to fetch bidding winners.';
    console.error(err);
  }

  return (
    <main className="w-full mx-auto pb-14">
      <h1 className='text-4xl font-bold mb-4'>Bidding Winners</h1>
      {error ? (
        <p className="text-red-500">{error}</p>
      ) : (
        <div className="mt-4 grid gap-6">
          {products.map((product) => (
          <div key={product.documentId} className="bg-gray-50 mb-2 py-4 px-6">
            <h2 className="text-2xl font-bold mb-2">{product.title}</h2>
            <div className='flex flex-col sm:flex-row gap-4'>
                <div className='imagearea relative w-full sm:w-3/12 rounded-lg overflow-hidden'>
                  {product.main_picture && product.main_picture.url ? (
                    <img
                      className="w-full h-48 object-cover"
                      src={`${process.env.NEXT_PUBLIC_API_URL}${product.main_picture.url}`}
                      alt={product.title}
                    />
                  ) : (
                    <img
                      className="w-full h-48 object-cover"
                      src="/placeholder.png"
                      alt="Placeholder image"
                    />
                  )}                  
                </div>
                <div className='infoarea flex flex-col gap-2 w-full sm:w-5/12'>
                  <p>
                    <strong>Product ID:</strong> {product.documentId}
                  </p>
                  <p>
                    <strong>Product Link:</strong>{' '}
                    <a href={`http://localhost:3000/product/${product.documentId}`}
                      className="text-blue-600 underline">View Product
                    </a>
                  </p>
                  <p>
                    <strong>Created Date:</strong> {new Date(product.createdAt).toLocaleString()}
                  </p>
                  <p>
                    <strong>Ending Date:</strong> {new Date(product.ending_date).toLocaleString()}
                  </p>                  
                </div>
                <div className='winnerarea w-full sm:w-4/12'>
                  {product.highestBid ? (
                    <div>
                      <h3 className='font-bold text-xl pb-2'>Winner:</h3>
                      <p>
                        <strong>Highest Bid:</strong> {product.highestBid.Amount}
                      </p>
                      <p>
                        <strong>Bidder:</strong> {product.highestBid.biduser.Name} (
                        {product.highestBid.biduser.email})
                      </p>
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
    </main>
  );
}
