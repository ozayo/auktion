"use client";

import { useEffect, useState } from "react";
import { API_URL } from "@/lib/api";
import { useFavorites } from "@/contexts/FavoritesContext";
import ProductCard from "@/components/ProductCard";
import Link from "next/link";
import { usePathname } from "next/navigation";
import FavoriteProductCard from "@/components/FavoriteProductCard";

type ProductType = 'all' | 'auction' | 'lottery';
type SortOption = 'createdAt:desc' | 'createdAt:asc';

const Favourites: React.FC = () => {
  const { userDocumentId, userEmail, userName } = useFavorites();
  const [allFavoriteProducts, setAllFavoriteProducts] = useState<any[]>([]);
  const [filteredProducts, setFilteredProducts] = useState<any[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [message, setMessage] = useState<string>("");
  const pathname = usePathname()
  const [productType, setProductType] = useState<ProductType>('all');
  const [sortBy, setSortBy] = useState<SortOption>('createdAt:desc');
  const [hideCompleted, setHideCompleted] = useState<boolean>(true);

  useEffect(() => {
    const fetchFavoritesAndUserBids = async () => {
      if (!userDocumentId || !userEmail) {
        setAllFavoriteProducts([]);
        setFilteredProducts([]);
        setMessage("Du har inga favoriter just nu.");
        setLoading(false);
        return;
      }

      try {
        setLoading(true);

        // Hämta favoriter
        const favouritesResponse = await fetch(
          `${API_URL}/api/bidusers/${userDocumentId}?populate[favourites][populate][main_picture]=true&populate[favourites][populate][bids]=true&populate[favourites][populate][categories]=true&populate[favourites][populate][lottery_users][populate][biduser]=true`
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
          if (product.lottery_product) {
            const isUserRegistered = product.lottery_users?.some(
              (user: any) => user.biduser?.email === userEmail
            );

            return {
              ...product,
              isRegistered: isUserRegistered
            };
          } else {
            // Bidding ürünü için mevcut mantık
            const highestBid = product.bids?.reduce(
              (max: number, bid: any) => Math.max(max, bid.Amount),
              0
            ) || null;

            const userBidsForProduct = userBids
              .filter((bid: any) => bid.product.id === product.id)
              .map((bid: any) => bid.Amount);

            const userBid = userBidsForProduct.length > 0
              ? Math.max(...userBidsForProduct)
              : null;

            return {
              ...product,
              highestBid,
              userBid,
            };
          }
        });

        setAllFavoriteProducts(enrichedProducts);
        setFilteredProducts(enrichedProducts);
        setMessage(
          enrichedProducts.length === 0 ? "Du har inga favoriter just nu." : ""
        );
      } catch (error) {
        console.error("Error fetching data:", error);
        setMessage("Kunde inte hämta favoriterna.");
      } finally {
        setLoading(false);
      }
    };

    fetchFavoritesAndUserBids();
  }, [userDocumentId, userEmail]);

  useEffect(() => {
    if (!allFavoriteProducts.length) return;

    let filtered = [...allFavoriteProducts];

    // Ürün tipine göre filtrele
    if (productType !== 'all') {
      filtered = filtered.filter(product => 
        productType === 'lottery' ? product.lottery_product : !product.lottery_product
      );
    }

    // Biten ürünleri filtrele
    if (hideCompleted) {
      const now = new Date();
      filtered = filtered.filter(product => 
        new Date(product.ending_date) > now
      );
    }

    // Tarihe göre sırala
    filtered.sort((a, b) => {
      if (sortBy === 'createdAt:desc') {
        return new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime();
      }
      return new Date(a.createdAt).getTime() - new Date(b.createdAt).getTime();
    });

    setFilteredProducts(filtered);
  }, [allFavoriteProducts, productType, sortBy, hideCompleted]);

  const handleFavoriteChange = (productId: number) => {
    setFilteredProducts((prevFavorites) =>
      prevFavorites.filter((product) => product.id !== productId)
    );
    if (filteredProducts.length === 1) {
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
      <div className="flex flex-col sm:flex-row justify-between gap-4 mb-6 items-start">
        <div className="flex flex-col">
          <div className="flex flex-row space-x-4">
            <label className="inline-flex items-center">
              <input
                type="radio"
                className="form-radio"
                name="productType"
                value="all"
                checked={productType === 'all'}
                onChange={(e) => setProductType(e.target.value as ProductType)}
              />
              <span className="ml-2">Alla objekt</span>
            </label>
            <br />
            <label className="inline-flex items-center">
              <input
                type="radio"
                className="form-radio"
                name="productType"
                value="auction"
                checked={productType === 'auction'}
                onChange={(e) => setProductType(e.target.value as ProductType)}
              />
              <span className="ml-2">Auktion</span>
            </label>
            <br />
            <label className="inline-flex items-center">
              <input
                type="radio"
                className="form-radio"
                name="productType"
                value="lottery"
                checked={productType === 'lottery'}
                onChange={(e) => setProductType(e.target.value as ProductType)}
              />
              <span className="ml-2">Lotteri</span>
            </label>
          </div>

          <div className="mt-4">
            <label className="inline-flex items-center">
              <input
                type="checkbox"
                className="form-checkbox"
                checked={hideCompleted}
                onChange={(e) => setHideCompleted(e.target.checked)}
              />
              <span className="ml-2">Dölj avslutad</span>
            </label>
          </div>
        </div>

        <div className="flex items-center gap-2">
          <span className="font-medium">Sortera:</span>
          <select
            value={sortBy}
            onChange={(e) => setSortBy(e.target.value as SortOption)}
            className="border border-gray-300 rounded p-2"
          >
            <option value="createdAt:desc">Nyaste först</option>
            <option value="createdAt:asc">Äldsta först</option>
          </select>
        </div>
      </div>
      <div>
        {loading && <p>Laddar...</p>}
        {!loading && filteredProducts.length === 0 && <p>{message}</p>}

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {filteredProducts.map((product) => (
            <FavoriteProductCard
              key={product.id}
              product={product}
              onFavoriteChange={() => handleFavoriteChange(product.id)}
            />
          ))}
        </div>
      </div>
    </div>
  );
};

export default Favourites;
