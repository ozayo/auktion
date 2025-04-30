"use client";

import { useEffect, useState } from "react";
import { useAuth } from "@/contexts/AuthContext";
import Link from "next/link";
import { usePathname } from "next/navigation";
import FavoriteProductCard from "@/components/FavoriteProductCard";
import { getStrapiURL } from "@/lib/utils";

type ProductType = 'all' | 'auction' | 'lottery';
type SortOption = 'createdAt:desc' | 'createdAt:asc';

const MyFavorites: React.FC = () => {
  const { user, isAuthenticated, isLoading: isAuthLoading } = useAuth();
  const [favoriteProducts, setFavoriteProducts] = useState<any[]>([]);
  const [filteredProducts, setFilteredProducts] = useState<any[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [message, setMessage] = useState<string>("");
  const pathname = usePathname();
  const [productType, setProductType] = useState<ProductType>('all');
  const [sortBy, setSortBy] = useState<SortOption>('createdAt:desc');
  const [hideCompleted, setHideCompleted] = useState<boolean>(true);

  useEffect(() => {
    const fetchFavorites = async () => {
      if (!isAuthenticated || !user) {
        setMessage("Du måste logga in för att se dina favoriter.");
        setLoading(false);
        return;
      }

      try {
        setLoading(true);
        
        // Kullanıcı kimliği
        const userId = user.id;
        
        // Doğrudan Next.js API route'unu kullanarak token sorununu atlayalım
        const apiUrl = `/api/favorites`;
        
        const response = await fetch(apiUrl);
        
        if (!response.ok) {
          throw new Error(`Failed to fetch favorites: ${response.status}`);
        }
        
        const data = await response.json();
        
        if (!data.ok || !data.data || !Array.isArray(data.data)) {
          throw new Error(data.error || "Unexpected API response format");
        }
        
        // API'den gelen favori verilerini düzenle
        setFavoriteProducts(data.data);
        setFilteredProducts(data.data);
        setMessage(data.data.length === 0 ? "Du har inga favoriter just nu." : "");
      } catch (error) {
        console.error("Error fetching favorites:", error);
        setMessage("Kunde inte hämta favoriterna. " + (error instanceof Error ? error.message : ""));
      } finally {
        setLoading(false);
      }
    };
    
    if (!isAuthLoading) {
      fetchFavorites();
    }
  }, [isAuthenticated, user, isAuthLoading]);

  // Filtreleme ve sıralama
  useEffect(() => {
    if (!favoriteProducts.length) return;

    let filtered = [...favoriteProducts];

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
  }, [favoriteProducts, productType, sortBy, hideCompleted]);

  // Favori değişikliğini işle (kaldırıldığında)
  const handleFavoriteChange = (productDocumentId: string) => {
    // Geçici olarak ürünü kaldırıyoruz, ancak bunu hemen yapmak yerine
    // birkaç milisaniye gecikmeli olarak yapalım, böylece animasyon ile görünüm değişimini görebiliriz
    setTimeout(() => {
      setFilteredProducts(prevProducts => 
        prevProducts.filter(product => product.documentId !== productDocumentId)
      );
      // Favorilerden de çıkar
      setFavoriteProducts(prevProducts => 
        prevProducts.filter(product => product.documentId !== productDocumentId)
      );
      // Son favori de çıkarıldıysa mesajı güncelle
      if (filteredProducts.length <= 1) {
        setMessage("Du har inga favoriter just nu.");
      }
    }, 500);
  };

  return (
    <div className="py-4">
      <div className="mb-6">
        <h1 className="text-2xl font-bold mb-4">Min Sida | favoriter</h1>
        {user?.username && (
          <>
            <p className="text-lg pb-1">
              Hej {user.username}, välkomna! 
            </p>
            <p className="text-base">
              {user.email}    
            </p>
          </>
        )}
      </div>
      
      {/* Navigation Links */}
      <div className="pt-2 pb-8">
        <Link
          className={`text-blue-500 rounded-full bg-gray-100 py-1 px-5 mx-1 mb-1 inline-block hover:text-white hover:bg-blue-950 hover:text-white" [&.active]:bg-blue-950 [&.active]:text-white ${pathname === '/my-page' ? 'active' : ''}`}
          href="/my-page">
          Mina produkter
        </Link>
        <Link
          className={`text-blue-500 rounded-full bg-gray-100 py-1 px-5 mx-1 mb-1 inline-block hover:text-white hover:bg-blue-950 hover:text-white" [&.active]:bg-blue-950 [&.active]:text-white ${pathname === '/my-page/my-win' ? 'active' : ''}`}
          href="/my-page/my-win">
          Vunna produkter
        </Link>
        <Link
          className={`text-blue-500 rounded-full bg-gray-100 py-1 px-5 mx-1 mb-1 inline-block hover:text-white hover:bg-blue-950 hover:text-white" [&.active]:bg-blue-950 [&.active]:text-white ${pathname === '/my-page/my-favorites' ? 'active' : ''}`}
          href="/my-page/my-favorites">
          Mina Favoriter
        </Link>
      </div>
      
      {/* Filters */}
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
      
      {/* Loading & Messages */}
      {loading && <p className="py-4">Laddar dina favoriter...</p>}
      {!loading && filteredProducts.length === 0 && <p className="py-4">{message}</p>}
      
      {/* Product Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        {filteredProducts.map((product) => (
          <FavoriteProductCard
            key={product.documentId || product.id}
            product={product}
            onFavoriteChange={(docId) => docId && handleFavoriteChange(docId)}
          />
        ))}
      </div>
    </div>
  );
};

export default MyFavorites;
