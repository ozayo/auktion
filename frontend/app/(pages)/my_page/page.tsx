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
import { API_URL } from "@/lib/api";
import LotForm from "@/components/LotForm";

const MyPage: React.FC = () => {
  const { userEmail, userName } = useAuth();
  const [bids, setBids] = useState<Bid[]>([]);
  const [lotteryProducts, setLotteryProducts] = useState<any[]>([]);
  const [message, setMessage] = useState<string>("");

  const BidCard: React.FC<{ bid: Bid }> = ({ bid }) => {
    const remainingTime = calculateRemainingTime(bid.product.ending_date);

    return (
      <div className="border rounded-lg p-4 shadow-md bg-white flex flex-col">
        <ProductCard
          key={bid.product.id}
          product={bid.product}
          showTotalBids={false}
          userBid={bid.Amount}
          borderless={true}
        />
        {remainingTime && (
          <div className="mt-4">
            <BidForm productId={bid.product.id} refreshBids={() => {}} />
          </div>
        )}
      </div>
    );
  };

  const LotteryProductCard: React.FC<{
    product: any;
    onUnregister: () => void;
  }> = ({ product, onUnregister }) => (
    <div className="border rounded-lg p-4 shadow-md bg-white flex flex-col">
      <ProductCardLot key={product.id} product={product} borderless={true} colorless={true}/>
      <div className="flex justify-center items-center mt-8">
        <LotForm
          productId={product.documentId}
          onUpdate={onUnregister} // Trigger removal on unregister
          showHeader={false}
        />
      </div>
    </div>
  );

  useEffect(() => {
    const fetchData = async () => {
      if (!userEmail) return;

      try {
        const processedBids = await fetchAndProcessBids(userEmail);
        const lotteryData = await fetchProductsWithLotteryUsers(userEmail);

        setBids(processedBids); // Update bids after fetching
        setLotteryProducts(lotteryData); // Update lottery products
      } catch (error) {
        console.error("Error fetching data:", error);
        setMessage("Failed to fetch your data.");
      }
    };

    fetchData();
  }, [userEmail]);

  return (
    <div className="container mx-auto p-4">
      <div className="mb-8">
        <h1 className="text-2xl font-bold mb-2">Min Sida</h1>
        {userName && (
          <p className="text-lg text-gray-600">
            Hej {userName}!
          </p>
        )}
      </div>

      <div className="mb-4">
        <Link href="/favourites">
          <button className="text-blue-500 hover:underline">
            Mina Favoriter
          </button>
        </Link>
      </div>

      {message && <p className="text-red-500 mt-4">{message}</p>}

      {bids.length === 0 && lotteryProducts.length === 0 ? (
        <p>Du har inga produkter just nu.</p>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {bids.map((bid) => (
            <BidCard key={bid.id} bid={bid} />
          ))}
          {lotteryProducts.map((product) => (
            <LotteryProductCard
              key={product.id}
              product={product}
              onUnregister={() => {
                // Remove product from lotteryProducts
                setLotteryProducts((prevProducts) =>
                  prevProducts.filter((p) => p.id !== product.id)
                );
              }}
            />
          ))}
        </div>
      )}
    </div>
  );
};



export default MyPage;


const fetchProductsWithLotteryUsers = async (email: string) => {

  try {
    const response = await fetch(
      `${API_URL}/api/lottery-users?filters[biduser][email][$eq]=${encodeURIComponent(
        email
      )}&populate=products.main_picture&populate=products.categories&populate=products.lottery_users.biduser`
    );

    if (!response.ok) throw new Error("Failed to fetch lottery users");

    const data = await response.json();

    const products = data.data.flatMap((lotteryUser: any) =>
      lotteryUser.products.map((product: any) => ({
        id: product.id,
        documentId: product.documentId,
        title: product.title,
        description: product.description,
        price: product.price,
        ending_date: product.ending_date,
        main_picture: product.main_picture
          ? { url: product.main_picture.url }
          : null,
        categories: product.categories.map((category: any) => ({
          id: category.id,
          category_name: category.category_name,
        })),
        lottery_users: product.lottery_users || [], // Include lottery_users
      }))
    );

    return products;
  } catch (error) {
    console.error("Error fetching lottery products:", error);
    return [];
  }
};
