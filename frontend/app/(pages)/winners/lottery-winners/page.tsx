import { fetchAPI } from '@/lib/api';
import { Metadata } from 'next';
import Link from 'next/link';
import BackButton from '@/components/BackButton';

type BidUser = {
  Name: string;
  email: string;
  documentId: string;
};

type Product = {
  id: number;
  title: string;
  documentId: string;
  ending_date: string;
  price: number | null;
  createdAt: string;
  manual_lottery: boolean | null;
  lottery_winner: string | null;
  main_picture: {
    url: string;
  };
  lottery_users: {
    biduser: BidUser;
  }[];
};

export const metadata: Metadata = {
  title: 'Lotteri vinnare arkiv',
  description: 'List of all lottery winners.',
};

export default async function LotteryWinnersPage() {
  let products: Product[] = [];
  let error: string | null = null;

  try {
    // Fetch products with necessary filters
    const response = await fetchAPI(
      '/products?populate[main_picture][fields]=url&populate[lottery_users][populate]=biduser&filters[lottery_product][$eq]=true&fields=id,documentId,title,createdAt,ending_date,manual_lottery,lottery_winner'
    );

    const now = new Date();

    // Filter products by ending date
    products = response.data.filter((product: Product) => {
      return new Date(product.ending_date) < now;
    });
  } catch (err) {
    error = 'Failed to fetch lottery winners.';
    console.error(err);
  }

  return (
    <div className='w-full mx-auto pt-8 pb-14'>

      <div className='w-full flex flex-row justify-between align-middle '>
        <h1 className='text-3xl font-bold mb-4 w-9/12'>Lotteri vinnare arkiv</h1>
        <div className='flex align-middle justify-end items-start w-3/12'>
          <BackButton />
        </div>
      </div>

      <p>Detta är arkivet för lotterivinnare; du kan se alla lotterivinnare från både automatiska och manuella lotterier</p>
      

      {/* product list */}
      {error ? (
        <p className="text-red-500">{error}</p>
      ) : (
        <div className="mt-4 grid gap-6">
          {products.map((product) => {
            // Determine the winner
            const winner = product.lottery_winner
              ? product.lottery_users.find(
                  (user) => user.biduser.documentId === product.lottery_winner
                )?.biduser
              : null;

            return (
              <div key={product.documentId} className="border border-zinc-200 bg-white py-5 px-6 hover:bg-zinc-50 overflow-hidden group">
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
                      <p className='text-gray-700 text-sm'><strong>Lotteri typ:</strong>{' '}{product.manual_lottery ? 'Manuell' : 'Automatisk'}</p>
                      <p className='text-gray-700 text-sm'><strong>Antal deltagare:</strong> {product.lottery_users.length}</p>
                      <div className='w-48 border-t pb-2 my-2'></div>
                        <Link href={`/product/${product.documentId}`} target="_blank" className='text-black inline-block text-sm hover:text-blue-600 font-black'>Gå till produkt ↗</Link>
                    </div>
                  </div>

                  {/* Winner Info */}
                  <div className="winnerarea w-full sm:w-4/12 group-hover:bg-white border border-zinc-200 0 p-4 rounded-lg">
                    {winner ? (
                      <div className='h-full flex flex-col items-center justify-center gap'>
                        <div className=" text-4xl">🏆</div>
                        <h2 className="text-xl font-bold text-amber-400">VINNARE</h2>
                        <p className='font-bold'>{winner.Name}</p>
                        <p className='text-sm'>{winner.email}</p>
                      </div>
                    ) : (
                      <p className="text-gray-500">There is no winner yet.</p>
                    )}
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}
