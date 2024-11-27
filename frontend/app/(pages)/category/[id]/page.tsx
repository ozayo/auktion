"use client";

import { useState, useEffect } from "react";
import { useParams } from "next/navigation";
import { fetchAPI } from "@/lib/api";
import ProductCard from "@/components/ProductCard";
import SortDropdown from "@/components/SortDropdown";

export default function CategoryPage() {
  const params = useParams();
  const [categoryName, setCategoryName] = useState<string>("");
  const [products, setProducts] = useState<any[]>([]);
  const [sortedProducts, setSortedProducts] = useState<any[]>([]);
  const [loading, setLoading] = useState<boolean>(true);

  useEffect(() => {
    const fetchCategoryData = async () => {
      try {
        // Fetch category details
        const categoryData = await fetchAPI(`/categories?filters[documentId][$eq]=${params.id}`);
        const category = categoryData.data[0];

        if (!category) {
          setCategoryName("Kategori Bulunamadı");
          setProducts([]);
          setSortedProducts([]);
          setLoading(false);
          return;
        }

        setCategoryName(category.category_name);

        // Fetch products
        const productsData = await fetchAPI(
          `/products?filters[categories][documentId][$eq]=${params.id}&populate[0]=bids&populate[1]=bids.biduser&populate[2]=main_picture&populate[3]=gallery&populate[4]=categories`
        );
        const products = productsData.data;
        setProducts(products);
        setSortedProducts(products);
        setLoading(false);
      } catch (error) {
        console.error("Error fetching category data:", error);
        setLoading(false);
      }
    };

    fetchCategoryData();
  }, [params.id]);

  if (loading) {
    return <p className="text-gray-600">Loading...</p>;
  }

  return (
    <main className="container mx-auto p-4">
      <h1 className="text-2xl font-bold mb-4">
        {categoryName ? (
          <>
            Produkter i <span className="text-blue-600">{categoryName}</span> kategori
          </>
        ) : (
          "Kategori hittades inte"
        )}
      </h1>

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
    </main>
  );
}
