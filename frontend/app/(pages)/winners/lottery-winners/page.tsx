import { fetchAPI } from '@/lib/api';
import { Metadata } from 'next';

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
  title: 'Lottery Winners',
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
    <main className="w-full mx-auto pb-14">
      <h1 className="text-4xl font-bold mb-4">Lottery Winners</h1>
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
              <div key={product.documentId} className="bg-gray-50 mb-2 py-4 px-6">
                <h2 className="text-2xl font-bold mb-2">{product.title}</h2>
                <div className="flex flex-col sm:flex-row gap-4">
                  {/* Product Image */}
                  <div className="imagearea relative w-full sm:w-3/12 rounded-lg overflow-hidden">
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

                  {/* Product Info */}
                  <div className="infoarea flex flex-col gap-2 w-full sm:w-5/12">
                    <p>
                      <strong>Product ID:</strong> {product.documentId}
                    </p>
                    <p>
                      <strong>Product Link:</strong>{' '}
                      <a
                        href={`http://localhost:3000/product/${product.documentId}`}
                        className="text-blue-600 underline"
                      >
                        View Product
                      </a>
                    </p>
                    <p>
                      <strong>Created Date:</strong> {new Date(product.createdAt).toLocaleString()}
                    </p>
                    <p>
                      <strong>Ending Date:</strong> {new Date(product.ending_date).toLocaleString()}
                    </p>
                    <p>
                      <strong>Manual Lottery:</strong>{' '}
                      {product.manual_lottery ? 'Yes' : 'No'}
                    </p>
                  </div>

                  {/* Winner Info */}
                  <div className="winnerarea w-full sm:w-4/12">
                    {winner ? (
                      <div>
                        <h3 className="font-bold text-xl pb-2">Winner:</h3>
                        <p>
                          <strong>Name:</strong> {winner.Name}
                        </p>
                        <p>
                          <strong>Email:</strong> {winner.email}
                        </p>
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
    </main>
  );
}
