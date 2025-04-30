"use client";

import React, { useState, useEffect } from "react";
import { FaRegHeart, FaHeart } from "react-icons/fa";
import { useFavorites } from "@/contexts/FavoritesContext";
import { useAuth } from "@/contexts/AuthContext";
import { useRouter } from "next/navigation";

interface SaveToFavoritesButtonProps {
  productId: number;
  favoriteId?: number | null;
  documentId?: string;
  favoriteDocumentId?: string;
  isFavorite?: boolean;
  onFavoriteChange?: () => void;
}

const SaveToFavoritesButton: React.FC<SaveToFavoritesButtonProps> = ({
  productId,
  favoriteId: initialFavoriteId,
  documentId: initialDocumentId,
  favoriteDocumentId: initialFavoriteDocumentId,
  isFavorite: initialIsFavorite,
  onFavoriteChange,
}) => {
  const { addFavorite, removeFavorite, isFavorite: checkIsFavorite, favorites } = useFavorites();
  const { isAuthenticated } = useAuth();
  const router = useRouter();
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [isFav, setIsFav] = useState<boolean>(
    initialIsFavorite !== undefined 
      ? initialIsFavorite 
      : checkIsFavorite(productId, initialDocumentId)
  );
  const [error, setError] = useState<string | null>(null);

  // İlgili FavoriteProduct nesnesini bul - hem ID hem de documentId'yi kontrol et
  const favoriteProduct = favorites.find(
    fav => 
      fav.id === productId || 
      fav.attributes?.product?.data?.id === productId ||
      (initialDocumentId && fav.documentId === initialDocumentId)
  );
  
  // FavoriteId ve favoriteDocumentId'yi favoriteProduct'dan al veya props'tan gelen değerleri kullan
  const favoriteIdFromProduct = initialFavoriteId || favoriteProduct?.favoriteId;
  const favoriteDocumentIdFromProduct = initialFavoriteDocumentId || favoriteProduct?.favoriteDocumentId;
  const documentIdFromProduct = initialDocumentId || favoriteProduct?.documentId;

  // Favoriler değiştiğinde isFav state'ini güncelle
  useEffect(() => {
    const newIsFavState = initialIsFavorite !== undefined 
      ? initialIsFavorite 
      : checkIsFavorite(productId, initialDocumentId);
    
    if (isFav !== newIsFavState) {
      setIsFav(newIsFavState);
    }
  }, [favorites, productId, initialDocumentId, initialIsFavorite, checkIsFavorite, isFav]);

  // Debug için IDs'leri logla
  useEffect(() => {
    if (favoriteProduct) {
      console.log(`SaveToFavoritesButton - Found product in favorites:`, {
        productId,
        favoriteId: favoriteIdFromProduct,
        favoriteDocumentId: favoriteDocumentIdFromProduct,
        documentId: documentIdFromProduct,
        isFavorite: isFav
      });
    }
  }, [favoriteProduct, productId, favoriteIdFromProduct, favoriteDocumentIdFromProduct, documentIdFromProduct, isFav]);

  const toggleFavorite = async (e: React.MouseEvent) => {
    e.preventDefault();
    e.stopPropagation();

    // Kullanıcı giriş yapmadıysa giriş sayfasına yönlendir
    if (!isAuthenticated) {
      router.push("/signin");
      return;
    }

    if (isLoading) return;

    setIsLoading(true);
    setError(null);
    
    try {
      console.log(`Toggling favorite for product: ${productId}, current status: ${isFav ? 'favorited' : 'not favorited'}`);
      
      if (isFav) {
        console.log(`Removing product ${productId} from favorites with favoriteId: ${favoriteIdFromProduct}, favoriteDocumentId: ${favoriteDocumentIdFromProduct}`);
        await removeFavorite(productId, favoriteIdFromProduct, favoriteDocumentIdFromProduct);
        console.log("Removal successful");
      } else {
        console.log(`Adding product ${productId} to favorites, documentId: ${documentIdFromProduct}`);
        await addFavorite(productId, documentIdFromProduct);
        console.log("Addition successful");
      }
      
      // İkonun doğru görüntülenmesi için önce durumu değiştir
      const newState = !isFav;
      setIsFav(newState);
      console.log(`Updated favorite state to: ${newState ? 'favorited' : 'not favorited'}`);
      
      // Callback fonksiyonu varsa çağır (örn. listelerin yenilenmesi için)
      if (onFavoriteChange) {
        onFavoriteChange();
      }
    } catch (error) {
      console.error("Error toggling favorite:", error);
      setError(error instanceof Error ? error.message : "Unknown error occurred");
    } finally {
      setIsLoading(false);
    }
  };

  // Kullanıcı girişi yoksa buton için özel stil ve tooltip bilgisi
  const buttonClass = `p-2 rounded-full shadow-md hover:shadow-lg transition-all duration-200 focus:outline-none ${
    !isAuthenticated ? 'bg-gray-100 cursor-not-allowed opacity-60' : 'bg-white'
  }`;

  return (
    <div className="relative">
      <button
        onClick={toggleFavorite}
        className={buttonClass}
        disabled={isLoading || !isAuthenticated}
        aria-label={!isAuthenticated ? "Giriş yapmalısınız" : isFav ? "Ta bort från favoriter" : "Lägg till i favoriter"}
        title={!isAuthenticated ? "Favorilere eklemek için giriş yapmalısınız" : ""}
        data-product-id={productId}
        data-document-id={documentIdFromProduct}
      >
        {isLoading ? (
          <div className="w-6 h-6 border-t-2 border-b-2 border-blue-500 rounded-full animate-spin"></div>
        ) : isFav ? (
          <FaHeart className="w-6 h-6 text-red-500" />
        ) : (
          <FaRegHeart className="w-6 h-6 text-gray-500 hover:text-red-500" />
        )}
      </button>
      
      {error && (
        <div className="absolute top-full left-0 mt-2 p-2 bg-red-100 text-red-800 text-xs rounded shadow-md z-50 w-48">
          {error}
        </div>
      )}
    </div>
  );
};

export default SaveToFavoritesButton; 