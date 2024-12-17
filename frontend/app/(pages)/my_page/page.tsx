"use client";

import { useEffect, useState } from "react";
import { fetchAndProcessBids } from "@/utils/fetchAndProcessBids";
import { useAuth } from "@/contexts/AuthContext";
import { Bid } from "@/types";
import ProductCard from "../../../components/ProductCard";
import ProductCardLot from "@/components/ProductCardLot";
import BidForm from "../../../components/BidForm";
import SortDropdown from "../../../components/SortDropdown";
import { calculateRemainingTime } from "@/utils/calculateRemainingTime";
import Link from "next/link";

const MyPage: React.FC = () => {
  const { userEmail } = useAuth();
  const [bids, setBids] = useState<Bid[]>([]);
  const [sortedBids, setSortedBids] = useState<Bid[]>([]);
  const [categories, setCategories] = useState<string[]>([]);
  const [selectedCategory, setSelectedCategory] = useState<string>("");
  const [message, setMessage] = useState<string>("");

  useEffect(() => {
    const fetchBids = async () => {
      if (!userEmail) return;

      try {
        const processedBids = await fetchAndProcessBids(userEmail);

        // Extract unique categories
        const uniqueCategories = Array.from(
          new Set(
            processedBids.flatMap(
              (bid) =>
                bid.product.categories?.map((cat) => cat.category_name) || []
            )
          )
        );

        setBids(processedBids);
        setSortedBids(processedBids);
        setCategories(uniqueCategories);
      } catch (error) {
        console.error("Error fetching user bids:", error);
        setMessage("Failed to fetch your bids.");
      }
    };

    fetchBids();
  }, [userEmail]);

  const handleCategoryChange = (category: string) => {
    setSelectedCategory(category);

    if (!category) {
      setSortedBids(bids);
    } else {
      setSortedBids(
        bids.filter((bid) =>
          bid.product.categories?.some((cat) => cat.category_name === category)
        )
      );
    }
  };

  const refreshBids = async () => {
    try {
      const updatedBids = await fetchAndProcessBids(userEmail);
      setBids(updatedBids);
      setSortedBids(updatedBids);
    } catch (error) {
      console.error("Error refreshing bids:", error);
    }
  };

  return (
    <div className="container mx-auto p-4">
      <h1 className="text-2xl font-bold mb-4">Min Sida</h1>

      {/* Link to Mina Favoriter */}
      <div className="mb-4">
        <Link href="/favourites">
          <button className="text-blue-500 hover:underline">
            Mina Favoriter
          </button>
        </Link>
      </div>

      {bids.length > 0 && (
        <>
          {/* Sorting and Category Filtering */}
          <SortDropdown
            products={bids.map((bid) => ({
              ...bid.product,
              myBidAmount: bid.Amount,
            }))}
            setSortedProducts={(sortedProducts) => {
              const updatedBids = sortedProducts
                .map((product) =>
                  bids.find((bid) => bid.product.id === product.id)
                )
                .filter((bid): bid is Bid => bid !== undefined); // Remove undefined
              setSortedBids(updatedBids);
            }}
          />

          <div className="flex items-center gap-2 mb-4">
            <label
              htmlFor="category-filter"
              className="text-gray-700 font-semibold"
            >
              Filtrera efter kategori:
            </label>
            <select
              id="category-filter"
              value={selectedCategory}
              onChange={(e) => handleCategoryChange(e.target.value)}
              className="border border-gray-300 rounded p-2"
            >
              <option value="">Alla kategorier</option>
              {categories.map((category) => (
                <option key={category} value={category}>
                  {category}
                </option>
              ))}
            </select>
          </div>
        </>
      )}

      {sortedBids.length === 0 ? (
        <p>Du har inga bud just nu.</p>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {sortedBids.map((bid) => {
            const remainingTime = calculateRemainingTime(
              bid.product.ending_date
            );

            return (
              <div
                key={bid.id}
                className="border rounded-lg p-4 shadow-md bg-white flex flex-col"
              >
                {/* Product Card */}
                <ProductCard
                  product={bid.product}
                  showTotalBids={false}
                  userBid={bid.Amount}
                  borderless={true}
                />
                {/* Render BidForm only if the auction has not ended */}
                {remainingTime ? (
                  <div className="mt-4">
                    <BidForm
                      productId={bid.product.id}
                      refreshBids={refreshBids} // Use centralized refresh
                    />
                  </div>
                ) : (
                  <></>
                )}
                {/* Render ProductCardLot only if lottery_product is true */}
                {bid.product.lottery_product && (
                  <div className="mt-4">
                    <ProductCardLot product={bid.product} />
                  </div>
                )}
              </div>
            );
          })}
        </div>
      )}

      {message && <p className="text-red-500 mt-4">{message}</p>}
    </div>
  );
};

export default MyPage;
