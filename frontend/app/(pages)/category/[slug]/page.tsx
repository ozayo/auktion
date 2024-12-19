// /app/(pages)/category/[slug]/page.tsx

"use client";

import { useState, useEffect } from "react";
import { useParams, useRouter, useSearchParams } from "next/navigation";
import { fetchAPI } from "@/lib/api";
import ProductCard from "@/components/ProductCard";
import SortDropdown from "@/components/SortDropdown";
import CategoryList from "@/components/CategoryList";

export default function CategoryPage() {
  const params = useParams();
  const router = useRouter();
  const searchParams = useSearchParams();

  const [categoryName, setCategoryName] = useState<string>("");
  const [categories, setCategories] = useState<any[]>([]);
  const [products, setProducts] = useState<any[]>([]);
  const [sortedProducts, setSortedProducts] = useState<any[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [currentPage, setCurrentPage] = useState<number>(1);
  const [totalPages, setTotalPages] = useState<number>(1);

  const fetchCategoryData = async (page: number) => {
    setLoading(true);
    try {
      // fetch categories
      const categoriesData = await fetchAPI("/categories");
      setCategories(categoriesData.data);

      // specific category (slug) fetch
      const categoryData = await fetchAPI(
        `/categories?filters[slug][$eq]=${params.slug}`
      );
      const category = categoryData.data[0];

      if (!category) {
        setCategoryName("Kategori hittades inte");
        setProducts([]);
        setSortedProducts([]);
        setLoading(false);
        return;
      }

      setCategoryName(category.category_name);

      // Filter products by category
      const productsData = await fetchAPI(
        `/products?filters[categories][slug][$eq]=${
          params.slug
        }&pagination[page]=${page}&pagination[pageSize]=9&populate[0]=bids&populate[1]=bids.biduser&populate[2]=main_picture&populate[3]=gallery&populate[4]=categories`
      );
      const products = productsData.data;
      const meta = productsData.meta.pagination;

      setProducts(products);
      const sorted = [...products].sort(
        (a, b) =>
          new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime()
      );
      setSortedProducts(sorted);
      setTotalPages(meta.pageCount);
    } catch (error) {
      console.error("Error fetching category data:", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    // take the page parameter from the URL
    const pageFromUrl = searchParams.get("page");
    const pageNumber = pageFromUrl ? parseInt(pageFromUrl, 10) : 1;
    setCurrentPage(pageNumber);
    fetchCategoryData(pageNumber);
  }, [params.slug, searchParams]);

  const handlePageChange = (page: number) => {
    // Update the URL with the new page number
    router.push(`/category/${params.slug}?page=${page}`);
  };

  if (loading) {
    return <p className="text-gray-600">Loading...</p>;
  }

  return (
    <div className="container mx-auto">
      <h1 className="text-2xl font-bold mb-4">
        {categoryName ? (
          <>
            Produkter i <span className="text-blue-600">{categoryName}</span> kategori
          </>
        ) : (
          "Kategori hittades inte"
        )}
      </h1>

      {/* Category List */}
      <div>
        <CategoryList categories={categories} />
      </div>

      {products.length > 0 && (
        <SortDropdown products={products} setSortedProducts={setSortedProducts} />
      )}

      {sortedProducts.length > 0 ? (
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          {sortedProducts.map((product: any) => (
            <ProductCard key={product.id} product={product} />
          ))}
        </div>
      ) : (
        <p className="text-gray-600">Inga produkter hittades i denna kategori.</p>
      )}

      {/* Pagination */}
      <div className="flex justify-center items-center mt-6">
        {Array.from({ length: totalPages }, (_, index) => (
          <button
            key={index}
            onClick={() => handlePageChange(index + 1)}
            className={`px-4 py-2 mx-1 ${
              currentPage === index + 1 ? "bg-blue-500 text-white" : "bg-gray-200 text-gray-700"
            } rounded`}
          >
            {index + 1}
          </button>
        ))}
      </div>
    </div>
  );
}
