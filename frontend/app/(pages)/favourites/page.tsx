"use client";

import { useEffect, useState } from "react";
import { API_URL } from "../../../lib/api";
import { useFavorites } from "@/contexts/FavoritesContext";
import ProductCard from "../../../components/ProductCard";

const Favourites: React.FC = () => {
  const { favorites, userDocumentId } = useFavorites(); // Access userDocumentId
  const [favoriteProducts, setFavoriteProducts] = useState<any[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [message, setMessage] = useState<string>("");

  useEffect(() => {
    // If no favorites or no userDocumentId, set message and stop
    if (!userDocumentId || favorites.length === 0) {
      setFavoriteProducts([]);
      setMessage("Du har inga favoriter just nu.");
      setLoading(false);
      return;
    }

    const fetchFavoriteProducts = async () => {
      try {
        setLoading(true); // Start loading

        const response = await fetch(
          `${API_URL}/api/bidusers/${userDocumentId}?populate[favourites][populate][main_picture]=true&populate[favourites][populate][bids]=true&populate[favourites][populate][categories]=true`
        );

        if (!response.ok) throw new Error("Failed to fetch favorite products");

        const data = await response.json();
        console.log("Fetched Favorite Products:", data);

        // Access populated favourites and map user bids
        const enrichedProducts = data.data.favourites.map((product: any) => {
          const highestBid =
            product.bids?.reduce(
              (max: number, bid: any) => Math.max(max, bid.Amount),
              0
            ) || null;

          // Extract the user's bid amount if available
          const userBid =
            product.bids?.find((bid: any) => favorites.includes(product.id))
              ?.Amount || null;

          return {
            ...product,
            highestBid,
            userBid, // Include user's bid for each product
          };
        });

        setFavoriteProducts(enrichedProducts); // Update state
        setMessage(""); // Clear any error messages
      } catch (error) {
        console.error("Error fetching favorite products:", error);
        setMessage("Kunde inte hämta favoriterna.");
      } finally {
        setLoading(false); // Stop loading in all cases
      }
    };

    fetchFavoriteProducts();
  }, [favorites, userDocumentId]); // Refetch when `favorites` or `userDocumentId` changes

  return (
    <div className="container mx-auto p-4">
      <h1 className="text-2xl font-bold mb-4">Mina Favoriter</h1>

      {/* Loading Spinner */}
      {loading && <p className="text-gray-500">Laddar...</p>}

      {/* Display Message if No Products */}
      {!loading && favoriteProducts.length === 0 && (
        <p className="text-gray-700">{message || "Inga favoriter hittades."}</p>
      )}

      {/* Product Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        {favoriteProducts.map((product) => (
          <ProductCard
            key={product.id}
            product={product}
            showTotalBids={false}
            userBid={product.userBid} // Pass user's bid to ProductCard
          />
        ))}
      </div>
    </div>
  );
};

export default Favourites;
