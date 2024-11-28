// /app/page.tsx

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
  const [currentPage, setCurrentPage] = useState<number>(1);
  const [totalPages, setTotalPages] = useState<number>(1);

  const fetchProducts = async (page: number) => {
    setLoading(true);
    try {
      // Fetch paginated products
      const productsData = await fetchAPI(
        `/products?pagination[page]=${page}&pagination[pageSize]=9&populate[0]=bids&populate[1]=bids.biduser&populate[2]=main_picture&populate[3]=gallery&populate[4]=categories`
      );
      const products = productsData.data;
      const meta = productsData.meta.pagination;

      setProducts(products);
      setTotalPages(meta.pageCount);

      // Default sorting: Newest first
      const sorted = [...products].sort(
        (a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime()
      );
      setSortedProducts(sorted);
    } catch (error) {
      console.error("Error fetching products:", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    const fetchData = async () => {
      try {
        // Fetch categories
        const categoriesData = await fetchAPI("/categories");
        setCategories(categoriesData.data);

        // Fetch initial products
        await fetchProducts(1);
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    };

    fetchData();
  }, []);

  const handlePageChange = (page: number) => {
    setCurrentPage(page);
    fetchProducts(page);
  };

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

      {/* Pagination */}
      <div className="flex justify-center items-center mt-6">
        {Array.from({ length: totalPages }, (_, index) => (
          <button
            key={index}
            onClick={() => handlePageChange(index + 1)}
            className={`px-4 py-2 mx-1 ${
              currentPage === index + 1
                ? "bg-blue-500 text-white"
                : "bg-gray-200 text-gray-700"
            } rounded`}
          >
            {index + 1}
          </button>
        ))}
      </div>
    </div>
  );
}
