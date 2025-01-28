"use client";

import { useEffect, useState } from "react";
import { useAuth } from "@/contexts/AuthContext";
import { API_URL } from "@/lib/api";
import { ProductWithStatus, Product } from "@/types";
import WonProductCard from "@/components/WonProductCard";
import Link from "next/link";

type ProductType = 'all' | 'auction' | 'lottery';
type SortOption = 'createdAt:desc' | 'createdAt:asc';

const fetchWonBiddingProducts = async (email: string): Promise<ProductWithStatus[]> => {
  try {
    const response = await fetch(
      `${API_URL}/api/bids?filters[biduser][email][$eq]=${encodeURIComponent(
        email
      )}&populate=product.main_picture&populate=product.categories&populate=product.bids.biduser`
    );

    if (!response.ok) throw new Error("Failed to fetch won bidding products");

    const data = await response.json();
    
    return data.data
      .filter((bid: any) => {
        const product = bid.product;
        const allBids = product.bids || [];
        const highestBid = Math.max(...allBids.map((b: any) => b.Amount));
        return bid.Amount >= highestBid && new Date(product.ending_date) < new Date();
      })
      .map((bid: any) => ({
        ...bid.product,
        type: 'bidding' as const,
        lottery_product: false,
        total_bids: bid.product.bids?.length || 0,
        highest_bid: Math.max(...(bid.product.bids || []).map((b: any) => b.Amount)),
        userBid: bid.Amount,
        isHighestBidder: true
      }));
  } catch (error) {
    console.error("Error fetching won bidding products:", error);
    return [];
  }
};

const fetchWonLotteryProducts = async (email: string): Promise<ProductWithStatus[]> => {
  try {
    // Önce kullanıcının documentId'sini alalım
    const userResponse = await fetch(
      `${API_URL}/api/bidusers?filters[email][$eq]=${email}&fields=documentId`
    );
    const userData = await userResponse.json();
    
    if (!userData.data?.[0]?.documentId) {
      console.error('User documentId not found');
      return [];
    }

    const userDocumentId = userData.data[0].documentId;
    
    // Lottery ürünlerini getirelim - categories ekledik
    const apiUrl = `${API_URL}/api/products?populate[main_picture][fields]=url&populate[categories][fields]=category_name&populate[lottery_users][populate]=biduser&filters[lottery_product][$eq]=true&filters[lottery_winner][$eq]=${userDocumentId}&filters[ending_date][$lt]=${new Date().toISOString()}&fields=id,documentId,title,createdAt,ending_date,manual_lottery,lottery_winner,price,description`;
    
    const response = await fetch(apiUrl);

    if (!response.ok) {
      throw new Error("Failed to fetch won lottery products");
    }

    const data = await response.json();

    return data.data.map((product: Product) => ({
      ...product,
      type: 'lottery' as const,
      lottery_product: true, // Filtreleme için eklendi
      categories: product.categories || [] // Kategoriler için eklendi
    }));

  } catch (error) {
    console.error('Error fetching won lottery products:', error);
    return [];
  }
};

const WinnersPage = () => {
  const { userEmail, userName } = useAuth();
  const [wonProducts, setWonProducts] = useState<ProductWithStatus[]>([]);
  const [filteredProducts, setFilteredProducts] = useState<ProductWithStatus[]>([]);
  const [productType, setProductType] = useState<ProductType>('all');
  const [sortBy, setSortBy] = useState<SortOption>('createdAt:desc');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // Filtering and sorting
  useEffect(() => {
    let result = [...wonProducts];

    // Type filtering - lottery_product kontrolünü düzelttik
    if (productType !== 'all') {
      result = result.filter(product => 
        productType === 'lottery' ? product.type === 'lottery' : product.type === 'bidding'
      );
    }

    // Sorting
    result.sort((a, b) => {
      if (sortBy === 'createdAt:desc') {
        return new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime();
      } else {
        return new Date(a.createdAt).getTime() - new Date(b.createdAt).getTime();
      }
    });

    setFilteredProducts(result);
  }, [wonProducts, productType, sortBy]);

  useEffect(() => {
    const fetchWonProducts = async () => {
      if (!userEmail) return;
      
      try {
        setLoading(true);
        const [biddingProducts, lotteryProducts] = await Promise.all([
          fetchWonBiddingProducts(userEmail),
          fetchWonLotteryProducts(userEmail)
        ]);

        setWonProducts([...biddingProducts, ...lotteryProducts]);
      } catch (err) {
        setError('Failed to load won products');
        console.error('Fetch error:', err);
      } finally {
        setLoading(false);
      }
    };

    fetchWonProducts();
  }, [userEmail]);

  if (loading) return <div>Loading...</div>;
  if (error) return <div className="text-red-500">{error}</div>;

  return (
    <div className="py-4">
      <div className="mb-6">
        <h1 className="text-2xl font-bold mb-4">Min Sida | vunna produkter</h1>
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
          <span className="font-medium">Visa:</span>
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
          </select>
        </div>
      </div>

      {/* Products Grid */}
      <div className="space-y-4">
        {filteredProducts.length === 0 ? (
          <p>Du har inga vunna produkter.</p>
        ) : (
          filteredProducts.map((product) => (
            <WonProductCard key={product.id} product={product} />
          ))
        )}
      </div>
    </div>
  );
};

export default WinnersPage; 