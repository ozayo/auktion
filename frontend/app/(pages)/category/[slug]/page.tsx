"use client";

import { useState, useEffect } from "react";
import { useParams, useRouter, useSearchParams } from "next/navigation";
import { fetchAPI } from "@/lib/api";
import ProductCard from "@/components/ProductCard";
import CategoryList from "@/components/CategoryList";
import SortDropdownNew from "@/components/SortDropdownNew";

type FilterType = "all" | "bidding" | "lottery";

export default function CategoryPage() {
  const params = useParams();
  const router = useRouter();
  const searchParams = useSearchParams();

  const [categoryName, setCategoryName] = useState<string>("");
  const [categories, setCategories] = useState<any[]>([]);
  const [allProducts, setAllProducts] = useState<any[]>([]);
  
  const [filteredProducts, setFilteredProducts] = useState<any[]>([]);
  const [sortedProducts, setSortedProducts] = useState<any[]>([]);
  
  const [loading, setLoading] = useState<boolean>(true);
  const [currentPage, setCurrentPage] = useState<number>(1);
  const [totalPages, setTotalPages] = useState<number>(1);

  const [filter, setFilter] = useState<FilterType>("all");
  const [hideEnded, setHideEnded] = useState<boolean>(true);

  // Varsayılan sıralama
  const [sortOption, setSortOption] = useState<string>("createdAt:desc");

  // Sayfa başı ürün sayısı
  const pageSize = 9;

  const fetchCategoryAllProducts = async () => {
    setLoading(true);
    try {
      // Kategorileri çek
      const categoriesData = await fetchAPI("/categories");
      setCategories(categoriesData.data);

      // İlgili kategoriyi slug'a göre çek
      const categoryData = await fetchAPI(
        `/categories?filters[slug][$eq]=${params.slug}`
      );
      const category = categoryData.data[0];

      if (!category) {
        setCategoryName("Kategori hittades inte");
        setAllProducts([]);
        setFilteredProducts([]);
        setSortedProducts([]);
        setLoading(false);
        return;
      }
      setCategoryName(category.category_name);

      // Kategoriye ait TÜM ürünleri çek (client-side pagination için)
      // Burada pagination[pageSize]=9999 ile büyük bir sayı veriyoruz.
      const productsData = await fetchAPI(
        `/products?filters[categories][slug][$eq]=${
          params.slug
        }&pagination[pageSize]=9999&populate[0]=bids&populate[1]=bids.biduser&populate[2]=main_picture&populate[3]=gallery&populate[4]=categories`
      );
      const products = productsData.data;
      setAllProducts(products);
    } catch (error) {
      console.error("Error fetching category data:", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchCategoryAllProducts();
  }, [params.slug]);

  // URL'den page parametresini oku
  useEffect(() => {
    const pageFromUrl = searchParams.get("page");
    const pageNumber = pageFromUrl ? parseInt(pageFromUrl, 10) : 1;
    setCurrentPage(pageNumber);
  }, [searchParams]);

  // Filtre uygula (All / Bidding / Lottery + Hide ended)
  useEffect(() => {
    const now = new Date();
    const newFiltered = allProducts.filter((product) => {
      if (filter === "lottery" && !product.lottery_product) return false;
      if (filter === "bidding" && product.lottery_product) return false;

      if (hideEnded) {
        const endDate = new Date(product.ending_date);
        if (endDate < now) return false;
      }

      return true;
    });

    setFilteredProducts(newFiltered);
  }, [allProducts, filter, hideEnded]);

  // filteredProducts değişince totalPages ve sayfa kontrolü
  useEffect(() => {
    const computedTotalPages = Math.ceil(filteredProducts.length / pageSize);
    setTotalPages(computedTotalPages);

    // Eğer mevcut sayfa yeni totalPages'ten büyükse ilk sayfaya git
    if (currentPage > computedTotalPages && computedTotalPages > 0) {
      router.push(`/category/${params.slug}?page=1`);
      setCurrentPage(1);
    }
  }, [filteredProducts, currentPage, router, pageSize, params.slug]);

  // Sıralama
  useEffect(() => {
    const sorted = [...filteredProducts];

    const [field, order] = sortOption.split(":");

    const compareDates = (a: any, b: any, field: string, order: string) => {
      const dateA = new Date(a[field]).getTime();
      const dateB = new Date(b[field]).getTime();
      return order === "asc" ? dateA - dateB : dateB - dateA;
    };

    const getHighestBid = (product: any) => {
      return product.bids?.length > 0 ? Math.max(...product.bids.map((bid: any) => bid.Amount)) : 0;
    };

    switch (field) {
      case "createdAt":
        sorted.sort((a, b) => compareDates(a, b, "createdAt", order));
        break;

      case "ending_date":
        sorted.sort((a, b) => compareDates(a, b, "ending_date", order));
        break;

      case "highestBid":
        sorted.sort((a, b) => {
          const highestBidA = getHighestBid(a);
          const highestBidB = getHighestBid(b);
          return order === "asc" ? highestBidA - highestBidB : highestBidB - highestBidA;
        });
        break;

      default:
        // Varsayılan: createdAt:desc
        sorted.sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime());
        break;
    }

    setSortedProducts(sorted);
  }, [filteredProducts, sortOption]);

  const currentPageProducts = sortedProducts.slice(
    (currentPage - 1) * pageSize,
    currentPage * pageSize
  );

  const handlePageChange = (page: number) => {
    router.push(`/category/${params.slug}?page=${page}`);
  };

  const isLotteryOnly = filter === "lottery";

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

      {/* Filtre Seçenekleri */}
      <div className="mb-4 flex flex-col gap-2">
        <div className="flex gap-4">
          <label className="flex items-center gap-2">
            <input
              type="radio"
              name="productType"
              value="all"
              checked={filter === "all"}
              onChange={() => setFilter("all")}
            />
            All products
          </label>
          <label className="flex items-center gap-2">
            <input
              type="radio"
              name="productType"
              value="bidding"
              checked={filter === "bidding"}
              onChange={() => setFilter("bidding")}
            />
            Just bidding products
          </label>
          <label className="flex items-center gap-2">
            <input
              type="radio"
              name="productType"
              value="lottery"
              checked={filter === "lottery"}
              onChange={() => setFilter("lottery")}
            />
            Just lottery products
          </label>
        </div>

        <label className="flex items-center gap-2">
          <input
            type="checkbox"
            checked={hideEnded}
            onChange={() => setHideEnded((prev) => !prev)}
          />
          Hide ended product
        </label>
      </div>

      {/* Sort Dropdown */}
      {filteredProducts.length > 0 && (
        <SortDropdownNew
          selectedOption={sortOption}
          onSortChange={(value) => setSortOption(value)}
          isLotteryOnly={isLotteryOnly}
        />
      )}

      {currentPageProducts.length > 0 ? (
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          {currentPageProducts.map((product: any) => (
            <ProductCard key={product.id} product={product} />
          ))}
        </div>
      ) : (
        <p className="text-gray-600">Inga produkter hittades i denna kategori.</p>
      )}

      {/* Pagination */}
      {totalPages > 1 && (
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
      )}
    </div>
  );
}
