"use client";

import { useEffect, useState } from "react";
import { fetchAndProcessBids } from "@/utils/fetchAndProcessBids";
import { useAuth } from "@/contexts/AuthContext";
import { Bid } from "@/types";
import ProductCard from "../../../components/ProductCard";
import ProductCardLot from "@/components/ProductCardLot";
import BidForm from "../../../components/BidForm";
import { calculateRemainingTime } from "@/utils/calculateRemainingTime";
import Link from "next/link";

const MyPage: React.FC = () => {
  const { userEmail } = useAuth();
  const [bids, setBids] = useState<Bid[]>([]);
  const [lotteryProducts, setLotteryProducts] = useState<any[]>([]);
  const [message, setMessage] = useState<string>("");

  useEffect(() => {
    const fetchData = async () => {
      if (!userEmail) return;

      try {
        // Fetch bids
        const processedBids = await fetchAndProcessBids(userEmail);
        setBids(processedBids);

        // Fetch products with lottery_users
        const lotteryData = await fetchProductsWithLotteryUsers();
        setLotteryProducts(lotteryData);

        console.log("Bids:", processedBids);
        console.log("Lottery Products:", lotteryData);
      } catch (error) {
        console.error("Error fetching data:", error);
        setMessage("Failed to fetch your data.");
      }
    };

    fetchData();
  }, [userEmail]);

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

      {/* User Bids Section */}
     
      {bids.length === 0 ? (
        <p>Du har inga produkter just nu.</p>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {bids.map((bid) => {
            const remainingTime = calculateRemainingTime(
              bid.product.ending_date
            );

            return (
              <div
                key={bid.id}
                className="border rounded-lg p-4 shadow-md bg-white flex flex-col"
              >
                <ProductCard
                  product={bid.product}
                  showTotalBids={false}
                  userBid={bid.Amount}
                  borderless={true}
                />
                {remainingTime && (
                  <div className="mt-4">
                    <BidForm
                      productId={bid.product.id}
                      refreshBids={() => {}}
                    />
                  </div>
                )}
              </div>
            );
          })}
        </div>
      )}

      {/* Products with Lottery Users */}
      
      {lotteryProducts.length === 0 ? (
        <p>Inga lotteriprodukter hittades.</p>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {lotteryProducts.map((product) => (
            <div
              key={product.id}
              className="border rounded-lg p-4 shadow-md bg-white flex flex-col"
            >
              <ProductCardLot product={product} />
            </div>
          ))}
        </div>
      )}

      {message && <p className="text-red-500 mt-4">{message}</p>}
    </div>
  );
};

export default MyPage;

// Fetch products with lottery_users
const fetchProductsWithLotteryUsers = async () => {
  const API_URL = process.env.NEXT_PUBLIC_API_URL || "http://localhost:1337";

  try {
    const response = await fetch(
      `${API_URL}/api/products?populate=main_picture&populate=categories&populate=lottery_users`
    );

    if (!response.ok) throw new Error("Failed to fetch products");

    const data = await response.json();

    // Filter products with non-empty lottery_users relation
    const productsWithLotteryUsers = data.data.filter(
      (product: any) =>
        product.lottery_users && product.lottery_users.length > 0
    );

    return productsWithLotteryUsers.map((product: any) => ({
      id: product.id,
      title: product.title,
      main_picture: product.main_picture || null,
      categories: product.categories || [],
      ending_date: product.ending_date || null,
      lottery_users: product.lottery_users || [],
    }));
  } catch (error) {
    console.error("Error fetching lottery products:", error);
    return [];
  }
};
