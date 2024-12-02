"use client";

import { useEffect, useState } from "react";
import { API_URL } from "../../../lib/api";
import { useAuth } from "@/contexts/AuthContext";
import ProductCard from "../../../components/ProductCard";
import BidForm from "../../../components/BidForm";
import SortDropdown from "../../../components/SortDropdown";

interface Bid {
  id: string;
  Amount: number;
  product: {
    id: string;
    documentId: string;
    title: string;
    description: string;
    price: number;
    ending_date: string;
    main_picture: { url: string; alternativeText?: string } | null;
    highestBid: number | null;
    categories?: string[];
  };
}

const MyPage: React.FC = () => {
  const { userEmail } = useAuth();
  const [bids, setBids] = useState<Bid[]>([]);
  const [sortedBids, setSortedBids] = useState<Bid[]>([]);
  const [categories, setCategories] = useState<string[]>([]);
  const [selectedCategory, setSelectedCategory] = useState<string>("");
  const [message, setMessage] = useState<string>("");

  const fetchUserBids = async () => {
    if (!userEmail) return;

    try {
      const response = await fetch(
        `${API_URL}/api/bids?filters[biduser][email][$eq]=${encodeURIComponent(
          userEmail
        )}&populate=product.main_picture&populate=product.bids&populate=product.categories`
      );
      if (!response.ok) throw new Error("Failed to fetch bids");

      const data = await response.json();
      const groupedBids: Record<string, Bid> = {};
      const categorySet: Set<string> = new Set();

      data.data.forEach((bid: any) => {
        const productId = bid.product.id;
        const highestBid =
          bid.product.bids?.reduce((max: number, curr: any) => {
            return Math.max(max, curr.Amount);
          }, 0) || null;

        const categories =
          bid.product.categories?.map((cat: any) => cat.category_name) || [];
        categories.forEach((category: string) => categorySet.add(category));

        const bidData = {
          id: bid.id,
          Amount: bid.Amount,
          product: {
            ...bid.product,
            highestBid,
            categories,
          },
        };

        if (
          !groupedBids[productId] ||
          groupedBids[productId].Amount < bid.Amount
        ) {
          groupedBids[productId] = bidData;
        }
      });

      setBids(Object.values(groupedBids));
      setSortedBids(Object.values(groupedBids));
      setCategories(Array.from(categorySet));
    } catch (error) {
      console.error("Error fetching user bids:", error);
      setMessage("Failed to fetch your bids.");
    }
  };

  useEffect(() => {
    fetchUserBids();
  }, [userEmail]);

  const handleCategoryChange = (category: string) => {
    setSelectedCategory(category);
    const filteredBids =
      category === ""
        ? bids
        : bids.filter((bid) => bid.product.categories?.includes(category));
    setSortedBids(filteredBids);
  };

  return (
    <div className="container mx-auto p-4">
      <h1 className="text-2xl font-bold mb-4">Min Sida</h1>

      {bids.length > 0 && (
        <>
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
          {sortedBids.map((bid) => (
            <div key={bid.id} className="border p-4 rounded shadow">
              <ProductCard
                product={bid.product}
                showCategories={false}
                showTotalBids={false}
              />
              <p className="text-gray-700 mt-1">
                <strong>Högsta bud:</strong>{" "}
                {bid.product.highestBid
                  ? `${bid.product.highestBid} SEK`
                  : "Inga bud"}
              </p>
              <p className="text-gray-700 mt-2">
                <strong>Mitt högsta bud:</strong> {bid.Amount} SEK
              </p>
              <BidForm productId={bid.product.id} refreshBids={fetchUserBids} />
            </div>
          ))}
        </div>
      )}

      {message && <p className="text-red-500 mt-4">{message}</p>}
    </div>
  );
};

export default MyPage;
