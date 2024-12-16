import React, { createContext, useContext, useEffect, useState } from "react";
import { fetchAPI } from "@/lib/api";
import { useAuth } from "@/contexts/AuthContext";
import { FavoritesContextProps } from "@/types";

const FavoritesContext = createContext<FavoritesContextProps | undefined>(
  undefined
);

export const FavoritesProvider: React.FC<{
  children: React.ReactNode;
  openLoginModal: () => void;
}> = ({ children, openLoginModal }) => {
  const { isLoggedIn, userEmail } = useAuth();
  const [favorites, setFavorites] = useState<number[]>([]);
  const [userDocumentId, setUserDocumentId] = useState<string | null>(null);

  const clearFavorites = () => {
    setFavorites([]);
    setUserDocumentId(null);
    console.log("Favorites cleared.");
  };

  useEffect(() => {
    if (!isLoggedIn || !userEmail) {
      clearFavorites();
      return;
    }

    (async () => {
      try {
        console.log("Fetching user by email:", userEmail);

        const userResponse = await fetchAPI(
          `/bidusers?filters[email][$eq]=${encodeURIComponent(userEmail)}`
        );

        if (userResponse.data.length > 0) {
          const user = userResponse.data[0];
          setUserDocumentId(user.documentId);

          const userDetailsResponse = await fetchAPI(
            `/bidusers/${user.documentId}?populate=favourites`
          );

          const userFavorites =
            userDetailsResponse.data?.favourites?.map(
              (product: any) => product.id
            ) || [];
          setFavorites(userFavorites);
        } else {
          console.error("User not found in database");
          clearFavorites();
        }
      } catch (error) {
        console.error("Error fetching user data:", error);
        clearFavorites();
      }
    })();
  }, [isLoggedIn, userEmail]);

  const addFavorite = (productId: number) => {
    if (!isLoggedIn) {
      openLoginModal();
      return;
    }

    if (!userDocumentId) {
      console.error("User documentId not found.");
      return;
    }

    const updatedFavorites = [...favorites, productId];
    setFavorites(updatedFavorites);

    fetchAPI(`/bidusers/${userDocumentId}`, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        data: { favourites: updatedFavorites },
      }),
    }).catch((error) => {
      console.error("Error adding favorite:", error);
      setFavorites(favorites);
    });
  };

  const removeFavorite = (productId: number) => {
    if (!isLoggedIn) {
      openLoginModal();
      return;
    }

    if (!userDocumentId) {
      console.error("User documentId not found.");
      return;
    }

    const updatedFavorites = favorites.filter((id) => id !== productId);
    setFavorites(updatedFavorites);

    fetchAPI(`/bidusers/${userDocumentId}`, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        data: { favourites: updatedFavorites },
      }),
    }).catch((error) => {
      console.error("Error removing favorite:", error);
      setFavorites(favorites);
    });
  };

  const isFavorite = (productId: number) => favorites.includes(productId);

  return (
    <FavoritesContext.Provider
      value={{
        favorites,
        addFavorite,
        removeFavorite,
        isFavorite,
        clearFavorites,
        userDocumentId,
        userEmail,
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
