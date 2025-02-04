// app/(pages)/produkter/page.tsx

"use client";

import { useState, useEffect } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import { fetchAPI } from "@/lib/api";
import CategoryList from "@/components/CategoryList";
import ProductCard from "@/components/ProductCard";
import ProductCardLot from "@/components/ProductCardLot";
import SortDropdownNew from "@/components/SortDropdownNew";

type FilterType = "all" | "bidding" | "lottery";

export default function ProdukterPage() {
  const router = useRouter();
  const searchParams = useSearchParams();

  const [allProducts, setAllProducts] = useState<any[]>([]);
  const [categories, setCategories] = useState<any[]>([]);
  const [loading, setLoading] = useState<boolean>(true);

  const [filter, setFilter] = useState<FilterType>("all");
  const [hideEnded, setHideEnded] = useState<boolean>(true);

  const [filteredProducts, setFilteredProducts] = useState<any[]>([]);
  const [sortedProducts, setSortedProducts] = useState<any[]>([]);

  const [currentPage, setCurrentPage] = useState<number>(1);
  const [totalPages, setTotalPages] = useState<number>(1);

  // Default sorting (Nyaste först)
  const [sortOption, setSortOption] = useState<string>("createdAt:desc");

  const pageSize = 9;

  const fetchAllProducts = async () => {
    setLoading(true);
    try {
      const productsData = await fetchAPI(
        `/products?populate=bids.biduser&populate=main_picture&populate=gallery&populate=categories&populate=lottery_users.biduser&pagination[pageSize]=9999`
      );
      const products = productsData.data;
      setAllProducts(products);
    } catch (error) {
      console.error("Error fetching products:", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    const fetchData = async () => {
      try {
        const categoriesData = await fetchAPI("/categories");
        setCategories(categoriesData.data);
        await fetchAllProducts();
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    };
    fetchData();
  }, []);

  // Filters
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

  // URL page parameters
  useEffect(() => {
    const pageFromUrl = searchParams.get("page");
    const pageNumber = pageFromUrl ? parseInt(pageFromUrl, 10) : 1;
    setCurrentPage(pageNumber);
  }, [searchParams]);

  // when filteredProducts changes, calculate the total pages
  useEffect(() => {
    const computedTotalPages = Math.ceil(filteredProducts.length / pageSize);
    setTotalPages(computedTotalPages);
    // if current page is greater than total pages, go to first page
    if (currentPage > computedTotalPages && computedTotalPages > 0) {
      router.push(`/produkter?page=1`);
      setCurrentPage(1);
    }
  }, [filteredProducts, currentPage, router, pageSize]);

  // sorted logic
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
        // default: createdAt:desc
        sorted.sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime());
        break;
    }

    setSortedProducts(sorted);
  }, [filteredProducts, sortOption]);

  const currentPageProducts = sortedProducts.slice((currentPage - 1) * pageSize, currentPage * pageSize);

  const handlePageChange = (page: number) => {
    router.push(`/produkter?page=${page}`);
  };

  const isLotteryOnly = filter === "lottery";

  if (loading) {
    return <p className="text-gray-600">Loading...</p>;
  }

  return (
    <div className="w-full mx-auto pb-14">
      <h1 className="text-4xl font-bold mb-4">Produkter</h1>

      {/* Categories */}
      <CategoryList categories={categories} />

      {/* Filter Options */}
      <div className="flex flex-col sm:flex-row justify-between gap-4 my-6 items-start">
        <div className="flex flex-col">
        <div className="flex flex-row space-x-4">
          <label className="flex items-center gap-2">
            <input
              type="radio"
              name="productType"
              value="all"
              checked={filter === "all"}
              onChange={() => setFilter("all")}
            />
            Alla objekt
          </label>
          <label className="flex items-center gap-2">
            <input
              type="radio"
              name="productType"
              value="bidding"
              checked={filter === "bidding"}
              onChange={() => setFilter("bidding")}
            />
            Auktion
          </label>
          <label className="flex items-center gap-2">
            <input
              type="radio"
              name="productType"
              value="lottery"
              checked={filter === "lottery"}
              onChange={() => setFilter("lottery")}
            />
            Lotteri
          </label>
        </div>

        <label className="mt-4 flex items-center gap-2">
          <input
            type="checkbox"
            checked={hideEnded}
            onChange={() => setHideEnded((prev) => !prev)}
          />
          Dölj avslutad auktion/lotteri
        </label>
        </div>

        <div className="flex items-center gap-2">
        {/* Sort Dropdown new component for testing */}
        {filteredProducts.length > 0 && (
          <SortDropdownNew
            selectedOption={sortOption}
            onSortChange={(value) => setSortOption(value)}
            isLotteryOnly={isLotteryOnly}
          />
        )}
        </div>
      </div>

      {/* Product List */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-5">
        {currentPageProducts.map((product: any) =>
          product.lottery_product === true ? (
            <ProductCardLot key={product.id} product={product} />
          ) : (
            <ProductCard key={product.id} product={product} />
          )
        )}
      </div>

      {/* Pagination */}
      {totalPages > 1 && (
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
      )}
    </div>
  );
}
