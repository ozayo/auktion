import { fetchAPI } from '@/lib/api';
import BackButton from '@/components/BackButton';
import ProductListWithLoadMore from './ProductListWithLoadMore';

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
        <ProductListWithLoadMore products={products} />
      )}
    </div>
  );
}
