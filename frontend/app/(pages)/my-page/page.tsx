"use client";

import { useEffect, useState } from "react";
import { useAuth } from "@/contexts/AuthContext";
import { fetchAndProcessBids } from "@/utils/fetchAndProcessBids";
import { API_URL } from "@/lib/api";
import { ProductWithStatus, Product } from "@/types";
import ActiveProductCard from "@/components/ActiveProductCard";
import Link from "next/link";

type ProductType = 'all' | 'auction' | 'lottery';
type SortOption = 'createdAt:desc' | 'createdAt:asc' | 'ending_date:asc' | 
                  'ending_date:desc' | 'highestBid:desc' | 'highestBid:asc';

const fetchProductsWithLotteryUsers = async (email: string) => {
  try {
    const response = await fetch(
      `${API_URL}/api/lottery-users?filters[biduser][email][$eq]=${encodeURIComponent(
        email
      )}&populate=products.main_picture&populate=products.categories&populate=products.lottery_users.biduser`
    );

    if (!response.ok) throw new Error("Failed to fetch lottery users");

    const data = await response.json();

    const products = data.data.flatMap((lotteryUser: {products: Product[]}) =>
      lotteryUser.products.map((product: Product) => ({
        id: product.id,
        documentId: product.documentId,
        title: product.title,
        description: product.description,
        price: product.price,
        ending_date: product.ending_date,
        createdAt: product.createdAt,
        main_picture: product.main_picture
          ? { url: product.main_picture.url }
          : undefined,
        categories: product.categories?.map((category: { id: number; category_name: string }) => ({
          id: category.id,
          category_name: category.category_name,
        })),
        lottery_users: product.lottery_users || [],
        lottery_product: true,
        lottery_winner: product.lottery_winner,
        manual_lottery: product.manual_lottery
      }))
    );

    return products;
  } catch (error) {
    console.error("Error fetching lottery products:", error);
    return [];
  }
};

const MyNewPage = () => {
  const { userEmail, userName } = useAuth();
  const [activeProducts, setActiveProducts] = useState<ProductWithStatus[]>([]);
  const [filteredProducts, setFilteredProducts] = useState<ProductWithStatus[]>([]);
  const [productType, setProductType] = useState<ProductType>('all');
  const [sortBy, setSortBy] = useState<SortOption>('createdAt:desc');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // Filtering and sorting
  useEffect(() => {
    let result = [...activeProducts];

    // Type filtering
    if (productType !== 'all') {
      result = result.filter(product => {
        if (productType === 'lottery') {
          return product.lottery_product === true;
        } else {
          return product.lottery_product === false;
        }
      });
    }

    // Sorting
    result.sort((a, b) => {
      switch (sortBy) {
        case 'createdAt:desc':
          return new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime();
        case 'createdAt:asc':
          return new Date(a.createdAt).getTime() - new Date(b.createdAt).getTime();
        case 'ending_date:asc':
          return new Date(a.ending_date).getTime() - new Date(b.ending_date).getTime();
        case 'ending_date:desc':
          return new Date(b.ending_date).getTime() - new Date(a.ending_date).getTime();
        case 'highestBid:desc':
          return (b.highest_bid || 0) - (a.highest_bid || 0);
        case 'highestBid:asc':
          return (a.highest_bid || 0) - (b.highest_bid || 0);
        default:
          return 0;
      }
    });

    setFilteredProducts(result);
  }, [activeProducts, productType, sortBy]);

  useEffect(() => {
    const fetchActiveProducts = async () => {
      if (!userEmail) return;
      
      try {
        setLoading(true);
        const activeBids = await fetchAndProcessBids(userEmail);
        const activeLotteryProducts = await fetchProductsWithLotteryUsers(userEmail);

        const now = new Date();
        const productMap = new Map<string, ProductWithStatus>();
        
        // Add bidding products
        activeBids.forEach(bid => {
          productMap.set(bid.product.documentId, {
            ...bid.product,
            type: 'bidding' as const,
            userBid: bid.Amount
          });
        });

        // Add lottery products
        activeLotteryProducts.forEach((product: Product) => {
          if (!productMap.has(product.documentId)) {
            productMap.set(product.documentId, {
              ...product,
              type: 'lottery' as const
            });
          }
        });

        const activeFilteredProducts = Array.from(productMap.values())
          .filter(product => new Date(product.ending_date) > now);

        setActiveProducts(activeFilteredProducts);
      } catch (err) {
        setError('Failed to load products');
        console.error('Fetch error:', err);
      } finally {
        setLoading(false);
      }
    };

    fetchActiveProducts();
  }, [userEmail]);

  if (loading) return <div>Loading...</div>;
  if (error) return <div className="text-red-500">{error}</div>;

  return (
    <div className="py-4">
      <div className="mb-6">
        <h1 className="text-2xl font-bold mb-4">Min Sida | mina produkter</h1>
        {userName && (
          <>
          <p className="text-lg pb-1">
            Hej {userName}, välkomna! 
          </p>
          <p className=" text-base ">
            {userEmail}    
          </p>
          </>
        )}
      </div>
      <div className="pt-2 pb-8 flex gap-2">
        <Link href="/my-page">Mina produkter</Link> |
        <Link href="/my-page/my-win">Vunna produkter</Link> |
        <Link href="#">Mina Favoriter</Link>
      </div>
      
      {/* Filters */}
      <div className="flex flex-col sm:flex-row justify-between gap-4 mb-6">
        <div className="space-x-4">
          <label className="inline-flex items-center">
            <input
              type="radio"
              className="form-radio"
              name="productType"
              value="all"
              checked={productType === 'all'}
              onChange={(e) => setProductType(e.target.value as ProductType)}
            />
            <span className="ml-2">Alla objekt</span>
          </label>
          <label className="inline-flex items-center">
            <input
              type="radio"
              className="form-radio"
              name="productType"
              value="auction"
              checked={productType === 'auction'}
              onChange={(e) => setProductType(e.target.value as ProductType)}
            />
            <span className="ml-2">Auktion</span>
          </label>
          <label className="inline-flex items-center">
            <input
              type="radio"
              className="form-radio"
              name="productType"
              value="lottery"
              checked={productType === 'lottery'}
              onChange={(e) => setProductType(e.target.value as ProductType)}
            />
            <span className="ml-2">Lotteri</span>
          </label>
        </div>

        <div className="flex items-center gap-2">
          <span className="font-medium">Sortera:</span>
          <select
            value={sortBy}
            onChange={(e) => setSortBy(e.target.value as SortOption)}
            className="border border-gray-300 rounded p-2"
          >
            <option value="createdAt:desc">Nyaste först</option>
            <option value="createdAt:asc">Äldsta först</option>
            <option value="ending_date:asc">Kortast tid kvar</option>
            <option value="ending_date:desc">Längst tid kvar</option>
            <option value="highestBid:desc">Högsta bud först</option>
            <option value="highestBid:asc">Lägsta bud först</option>
          </select>
        </div>
      </div>
      
      {/* Product List */}
      <div className="space-y-4">
        {filteredProducts.length === 0 ? (
          <p>Du har inga produkter på gång.</p>
        ) : (
          filteredProducts.map((product: ProductWithStatus) => {
            const imageUrl = product.main_picture?.url 
              ? `${API_URL}${product.main_picture.url}`
              : '/placeholder.png';

            return (
              <ActiveProductCard 
                key={product.documentId} 
                product={{
                  ...product,
                  main_picture: product.main_picture 
                    ? { url: imageUrl }
                    : undefined
                }}
              />
            );
          })
        )}
      </div>
    </div>
  );
};

export default MyNewPage; 