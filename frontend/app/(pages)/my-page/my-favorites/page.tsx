"use client";

import { useEffect, useState } from "react";
import { API_URL } from "@/lib/api";
import { useFavorites } from "@/contexts/FavoritesContext";
import ProductCard from "@/components/ProductCard";
import Link from "next/link";
import { usePathname } from "next/navigation";

const Favourites: React.FC = () => {
  const { userDocumentId, userEmail, userName } = useFavorites();
  const [favoriteProducts, setFavoriteProducts] = useState<any[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [message, setMessage] = useState<string>("");
  const pathname = usePathname()

  useEffect(() => {
    const fetchFavoritesAndUserBids = async () => {
      if (!userDocumentId || !userEmail) {
        setFavoriteProducts([]);
        setMessage("Du har inga favoriter just nu.");
        setLoading(false);
        return;
      }

      try {
        setLoading(true);

        // Hämta favoriter
        const favouritesResponse = await fetch(
          `${API_URL}/api/bidusers/${userDocumentId}?populate[favourites][populate][main_picture]=true&populate[favourites][populate][bids]=true&populate[favourites][populate][categories]=true`
        );
        const favouritesData = await favouritesResponse.json();
        const favourites = favouritesData.data.favourites;

        // Hämta alla bud för användaren
        const bidsResponse = await fetch(
          `${API_URL}/api/bids?filters[biduser][email][$eq]=${encodeURIComponent(
            userEmail
          )}&populate=product`
        );
        const bidsData = await bidsResponse.json();
        const userBids = bidsData.data;

        // Matcha userBids med favourites
        const enrichedProducts = favourites.map((product: any) => {
          // Hitta det högsta budet på produkten
          const highestBid =
            product.bids?.reduce(
              (max: number, bid: any) => Math.max(max, bid.Amount),
              0
            ) || null;

          // Hitta användarens högsta bud på produkten
          const userBidsForProduct = userBids
            .filter((bid: any) => bid.product.id === product.id)
            .map((bid: any) => bid.Amount);

          const userBid =
            userBidsForProduct.length > 0
              ? Math.max(...userBidsForProduct)
              : null;

          return {
            ...product,
            highestBid,
            userBid,
          };
        });

        setFavoriteProducts(enrichedProducts);
        setMessage(
          enrichedProducts.length === 0 ? "Du har inga favoriter just nu." : ""
        ); // Ställ in meddelandet om inga favoriter finns
      } catch (error) {
        console.error("Error fetching data:", error);
        setMessage("Kunde inte hämta favoriterna.");
      } finally {
        setLoading(false);
      }
    };

    fetchFavoritesAndUserBids();
  }, [userDocumentId, userEmail]);

  const handleFavoriteChange = (productId: number) => {
    setFavoriteProducts((prevFavorites) =>
      prevFavorites.filter((product) => product.id !== productId)
    );
    if (favoriteProducts.length === 1) {
      setMessage("Du har inga favoriter just nu."); // Uppdatera meddelandet om det var den sista favoriten
    }
  };

  return (
    <div className="py-4">
            <div className="mb-6">
        <h1 className="text-2xl font-bold mb-4">Min Sida | favoriter</h1>
        {userName && (
          <>
          <p className="text-lg pb-1">
            Hej {userName}, välkomna! 
          </p>
          <p className=" text-base ">
            {userEmail}    
          </p>
          </>
        )}
      </div>
      <div className="pt-2 pb-8 flex gap-2">
        <Link
          className={`text-blue-500 rounded-full bg-gray-100 py-1 px-5 hover:text-white hover:bg-blue-950 hover:text-white" [&.active]:bg-blue-950 [&.active]:text-white ${pathname === '/my-page' ? 'active' : ''}`}
          href="/my-page">
          Mina produkter
        </Link>
        <Link
          className={`text-blue-500 rounded-full bg-gray-100 py-1 px-5 hover:text-white hover:bg-blue-950 hover:text-white" [&.active]:bg-blue-950 [&.active]:text-white ${pathname === '/my-page/my-win' ? 'active' : ''}`}
          href="/my-page/my-win">
          Vunna produkter
        </Link>
        <Link
          className={`text-blue-500 rounded-full bg-gray-100 py-1 px-5 hover:text-white hover:bg-blue-950 hover:text-white" [&.active]:bg-blue-950 [&.active]:text-white ${pathname === '/my-page/my-favorites' ? 'active' : ''}`}
          href="/my-page/my-favorites">
          Mina Favoriter
        </Link>
      </div>
      <div>
        {loading && <p>Laddar...</p>}
        {!loading && favoriteProducts.length === 0 && <p>{message}</p>}

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {favoriteProducts.map((product) => (
            <ProductCard
              key={product.id}
              product={product}
              userBid={product.userBid}
              showTotalBids={false}
              onFavoriteChange={() => handleFavoriteChange(product.id)}
            />
          ))}
        </div>
      </div>
    </div>
  );
};

export default Favourites;
