"use client";

import { useState, useEffect } from "react";
import { fetchAPI } from "../lib/api";
import ProductCard from "../components/ProductCard";
import Link from "next/link";
import SortDropdown from "../components/SortDropdown";

export default function HomePage() {
  const [products, setProducts] = useState<any[]>([]);
  const [sortedProducts, setSortedProducts] = useState<any[]>([]);
  const [categories, setCategories] = useState<any[]>([]);
  const [loading, setLoading] = useState<boolean>(true);

  useEffect(() => {
    const fetchData = async () => {
      try {
        // Fetch products
        const productsData = await fetchAPI(
          "/products?populate[0]=bids&populate[1]=bids.biduser&populate[2]=main_picture&populate[3]=gallery&populate[4]=categories"
        );
        const products = productsData.data;
        setProducts(products);
        setSortedProducts(products);

        // Fetch categories
        const categoriesData = await fetchAPI("/categories");
        setCategories(categoriesData.data);
      } catch (error) {
        console.error("Error fetching data:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  if (loading) {
    return <p className="text-gray-600">Loading...</p>;
  }

  return (
    <div className="container mx-auto">
      <h1 className="text-2xl font-bold mb-4">Produkter</h1>

      {/* Categories */}
      <div className="flex space-x-4 mb-6">
        {categories.map((category: any) => (
          <Link
            key={category.id}
            href={`/category/${category.documentId}`}
            className="text-blue-500 hover:underline"
          >
            {category.category_name}
          </Link>
        ))}
      </div>

      {/* Sort Dropdown */}
      {products.length > 0 && (
        <SortDropdown products={products} setSortedProducts={setSortedProducts} />
      )}

      {/* Product List */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        {sortedProducts.map((product: any) => (
          <ProductCard key={product.id} product={product} />
        ))}
      </div>
    </div>
  );
}
