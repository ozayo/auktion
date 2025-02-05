"use client";

import { useState, useEffect } from 'react';
import { fetchAPI } from "@/lib/api";
import { ProductListProps, Product, ProductWithStatus } from '@/types';
import ProductCard from './ProductCard';
import ProductCardLot from './ProductCardLot';
import SortDropdownNew from './SortDropdownNew';

export default function ProductList({
  productType = 'all',
  showItems = 3,
  sorting = true,
  customSorting,
  showImage = true,
  title,
  showOld = false,
  category
}: ProductListProps) {
  const [products, setProducts] = useState<ProductWithStatus[]>([]);
  const [sortedProducts, setSortedProducts] = useState<ProductWithStatus[]>([]);
  const [sortOption, setSortOption] = useState<string>("createdAt:desc");
  const [loading, setLoading] = useState(true);

  // Fetch products
  useEffect(() => {
    const fetchProducts = async () => {
      try {
        const query = [
          'pagination[pageSize]=100',
          'populate[0]=bids.biduser',
          'populate[1]=main_picture',
          'populate[2]=gallery',
          'populate[3]=categories',
          'populate[4]=lottery_users.biduser'
        ];

        // update product type filter
        switch (productType) {
          case 'lotteryManual':
            query.push('filters[lottery_product][$eq]=true');
            query.push('filters[manual_lottery][$eq]=true');
            break;
          case 'lotteryAuto':
            query.push('filters[lottery_product][$eq]=true');
            query.push('filters[manual_lottery][$eq]=false');
            break;
          case 'lottery':
            query.push('filters[lottery_product][$eq]=true');
            break;
          case 'bidding':
            query.push('filters[lottery_product][$eq]=false');
            break;
        }

        // Filter by category use: category="dator" 
        if (category) {
          query.push(`filters[categories][slug][$eq]=${category}`);
        }

        // Show hide old products (ending date pass)
        if (!showOld) {
          const now = new Date().toISOString();
          query.push(`filters[ending_date][$gt]=${now}`);
        }

        const response = await fetchAPI(`/products?${query.join('&')}`);
        const fetchedProducts = response.data;

        // Process products
        const processedProducts = fetchedProducts.map((product: Product) => ({
          ...product,
          type: product.lottery_product ? 'lottery' : 'bidding',
          total_bids: product.bids?.length || 0,
          highest_bid: product.bids?.length 
            ? Math.max(...product.bids.map(bid => bid.Amount))
            : null
        }));

        setProducts(processedProducts);
      } catch (error) {
        console.error('Error fetching products:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchProducts();
  }, [productType, showOld, category]);

  // Sort products
  useEffect(() => {
    const sorted = [...products];
    const [field, order] = sortOption.split(':');

    const compareDates = (a: any, b: any, field: string) => {
      const dateA = new Date(a[field]).getTime();
      const dateB = new Date(b[field]).getTime();
      return order === 'asc' ? dateA - dateB : dateB - dateA;
    };

    switch (field) {
      case 'createdAt':
        sorted.sort((a, b) => compareDates(a, b, 'createdAt'));
        break;
      case 'ending_date':
        sorted.sort((a, b) => compareDates(a, b, 'ending_date'));
        break;
      case 'highestBid':
        sorted.sort((a, b) => {
          const bidA = a.highest_bid || 0;
          const bidB = b.highest_bid || 0;
          return order === 'asc' ? bidA - bidB : bidB - bidA;
        });
        break;
    }

    setSortedProducts(sorted.slice(0, showItems));
  }, [products, sortOption, showItems]);

  if (loading) {
    return <div>Loading...</div>;
  }

  return (
    <div className="mb-8">
      <div className="flex justify-between items-center mb-4">
        {title && <h2 className="text-2xl font-bold">{title}</h2>}
        
        {sorting && sortedProducts.length > 0 && (
          <SortDropdownNew
            selectedOption={sortOption}
            onSortChange={(value) => setSortOption(value)}
            isLotteryOnly={productType === 'lottery'}
            customOptions={customSorting}
          />
        )}
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        {sortedProducts.map((product) => (
          product.type === 'lottery' ? (
            <ProductCardLot
              key={product.id}
              product={product}
              showCategories={true}
              colorless={false}
            />
          ) : (
            <ProductCard
              key={product.id}
              product={product}
              showTotalBids={true}
            />
          )
        ))}
      </div>
    </div>
  );
} 