"use client";

import React, { createContext, useContext, useEffect, useState } from "react";
import { useAuth } from "@/contexts/AuthContext";
import { getStrapiURL } from "@/lib/utils";

// Favori ürün tipini tanımla
interface FavoriteProduct {
  id: number;
  favoriteId?: number;
  documentId?: string;
  favoriteDocumentId?: string; // Favorinin kendisinin documentId'si
  attributes?: {
    product?: {
      data?: {
        id: number;
        attributes?: any;
      }
    };
    [key: string]: any;
  };
}

// FavoritesContext için gerekli tip tanımları
interface FavoritesContextProps {
  favorites: FavoriteProduct[];
  addFavorite: (productId: number, documentId?: string) => Promise<void>;
  removeFavorite: (productId: number, favoriteId?: number, favoriteDocumentId?: string) => Promise<void>;
  isFavorite: (productId: number, documentId?: string) => boolean;
  clearFavorites: () => void;
  isLoading: boolean;
}

const FavoritesContext = createContext<FavoritesContextProps>({
  favorites: [],
  addFavorite: async () => {},
  removeFavorite: async () => {},
  isFavorite: () => false,
  clearFavorites: () => {},
  isLoading: true
});

export const FavoritesProvider: React.FC<{
  children: React.ReactNode;
}> = ({ children }) => {
  const { user, isAuthenticated } = useAuth();
  const [favorites, setFavorites] = useState<FavoriteProduct[]>([]);
  const [isLoading, setIsLoading] = useState<boolean>(true);

  const clearFavorites = () => {
    setFavorites([]);
    console.log("Favorites cleared.");
  };

  // Kullanıcı favorilerini al
  const fetchFavorites = async () => {
    if (!isAuthenticated || !user) {
      clearFavorites();
      setIsLoading(false);
      return;
    }

    try {
      setIsLoading(true);
      console.log("Fetching favorites...");
      
      // API URL'miz düzgün çalışana kadar, direkt Next.js API Route'unu değil tam URL'yi kullan
      const apiUrl = `${window.location.origin}/api/favorites`;
      console.log("Using API URL:", apiUrl);
      
      // API'ye istek gönder
      const response = await fetch(apiUrl, {
        headers: {
          'Cache-Control': 'no-cache',
          'Pragma': 'no-cache'
        }
      });
      
      if (!response.ok) {
        const errorText = await response.text();
        throw new Error(`API responded with status ${response.status}: ${errorText}`);
      }
      
      const data = await response.json();
      console.log("API Response:", data);

      if (data.ok) {
        // API'den gelen favorileri ayarla
        setFavorites(data.data);
        console.log("Favorites fetched:", data.data);
      } else {
        console.error("Error fetching favorites:", data.error);
        clearFavorites();
      }
    } catch (error) {
      console.error("Error fetching favorites:", error);
      clearFavorites();
    } finally {
      setIsLoading(false);
    }
  };

  // Auth durumu değiştiğinde favorileri güncelle
  useEffect(() => {
    fetchFavorites();
  }, [isAuthenticated, user]);

  // Favori ekle
  const addFavorite = async (productId: number, documentId?: string): Promise<void> => {
    if (!isAuthenticated || !user) {
      console.log("User must be logged in to add favorites");
      return;
    }

    // Eğer zaten favori ise, ekleme
    if (isFavorite(productId, documentId)) {
      console.log("Product already in favorites");
      return;
    }

    try {
      // Tam URL'yi kullan
      const apiUrl = `${window.location.origin}/api/favorites`;
      
      const response = await fetch(apiUrl, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          productId,
          documentId, // Eğer documentId varsa, API'ye gönder
          action: 'add'
        }),
      });

      if (!response.ok) {
        const errorText = await response.text();
        throw new Error(`API responded with status ${response.status}: ${errorText}`);
      }

      const data = await response.json();

      if (data.ok) {
        console.log("Favorite added:", data.data);
        
        // Favoriler listesini güncelle
        await fetchFavorites();
      } else {
        console.error("Error adding favorite:", data.error);
      }
    } catch (error) {
      console.error("Error adding favorite:", error);
    }
  };

  // Favorileri kaldırma
  const removeFavorite = async (productId: number, favoriteId?: number, favoriteDocumentId?: string) => {
    console.log(`Attempting to remove favorite - Product ID: ${productId}, Favorite ID: ${favoriteId}, Favorite Document ID: ${favoriteDocumentId}`);
    
    if (!isAuthenticated || !user) {
      console.log("User must be logged in to remove favorites");
      return;
    }
    
    // Ürün favorilerde mi kontrol et
    const isFav = isFavorite(productId, favoriteDocumentId);
    if (!isFav) {
      console.log(`Product ${productId} is not in favorites, nothing to remove.`);
      return;
    }

    // favoriteId ve favoriteDocumentId yoksa, favoriler listesinden bul
    let favoriteIdToUse = favoriteId;
    let favoriteDocumentIdToUse = favoriteDocumentId;

    if (!favoriteIdToUse && !favoriteDocumentIdToUse) {
      console.log("No favoriteId/documentId provided, looking in favorites list");
      // İlgili favoriteProduct'ı bulma - farklı potansiyel ID ve documentId varyasyonlarını kontrol et
      const favoriteProduct = favorites.find(fav => 
        fav.id === productId || 
        fav.attributes?.product?.data?.id === productId ||
        (fav.documentId && fav.documentId === favoriteDocumentId)
      );

      if (favoriteProduct) {
        favoriteIdToUse = favoriteProduct.favoriteId;
        favoriteDocumentIdToUse = favoriteProduct.favoriteDocumentId;
        console.log(`Found IDs in favorites list: favoriteId=${favoriteIdToUse}, documentId=${favoriteDocumentIdToUse}`);
      } else {
        console.warn("Could not find matching favorite product in list.");
      }
    }

    // API isteği için body oluştur
    const requestBody = {
      productId,
      action: "remove",
      favoriteId: favoriteIdToUse,
      favoriteDocumentId: favoriteDocumentIdToUse
    };

    try {
      console.log(`Sending request to remove favorite:`, requestBody);
      const response = await fetch("/api/favorites", {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(requestBody),
      });

      let responseText = '';
      let data;

      try {
        // Önce response text al
        responseText = await response.text();
        
        // Eğer JSON ise parse et
        if (responseText && responseText.trim().startsWith('{')) {
          data = JSON.parse(responseText);
        } else {
          data = { error: responseText || "Unknown error" };
        }
      } catch (e) {
        console.warn("Could not parse response as JSON:", responseText);
        data = { error: responseText || "Unknown error" };
      }
      
      if (!response.ok) {
        console.error(`Failed to remove favorite. Status: ${response.status}`, data);
        throw new Error(data.error || "Failed to remove favorite");
      }

      console.log(`Successfully removed product ${productId} from favorites`, data);
      
      // Yerel state'i hemen güncelle
      setFavorites(currentFavorites => currentFavorites.filter(fav => {
        // ID ile filtreleme
        if (fav.id === productId) return false;
        
        // DocumentId ile filtreleme
        if (fav.documentId === favoriteDocumentId) return false;
        
        // Attributes içindeki product ID ile filtreleme
        if (fav.attributes?.product?.data?.id === productId) return false;
        
        return true;
      }));

      // API'den güncel favori listesini getir (silme işlemi doğrulanması için)
      setTimeout(async () => {
        console.log("Reloading favorites from API after delete...");
        await fetchFavorites();
      }, 500);
      
    } catch (error) {
      console.error(`Error removing favorite for product ${productId}:`, error);
      throw error;
    }
  };

  // Ürün favori mi kontrol et - tüm olası ID ve documentId varyasyonlarını kontrol et
  const isFavorite = (productId: number, documentId?: string) => {
    if (!favorites || favorites.length === 0) return false;
    
    return favorites.some(fav => {
      // Temel kontroller
      if (fav.id === productId) return true;
      
      // DocumentId kontrolü (eğer varsa)
      if (documentId && fav.documentId === documentId) return true;
      
      // Attributes içindeki product ID ile kontrol
      if (fav.attributes?.product?.data?.id === productId) return true;
      
      // Attributes içindeki documentId ile kontrol (eğer varsa)
      if (documentId && fav.attributes?.product?.data?.attributes?.documentId === documentId) return true;
      
      return false;
    });
  };

  return (
    <FavoritesContext.Provider
      value={{
        favorites,
        addFavorite,
        removeFavorite,
        isFavorite,
        clearFavorites,
        isLoading
      }}
    >
      {children}
    </FavoritesContext.Provider>
  );
};

export const useFavorites = () => {
  const context = useContext(FavoritesContext);
  if (!context) {
    throw new Error("useFavorites must be used within a FavoritesProvider");
  }
  return context;
};
