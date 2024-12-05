"use client";

import React, { createContext, useContext, useEffect, useState } from "react";
import { fetchAPI } from "@/lib/api";
import { useAuth } from "@/contexts/AuthContext";

interface FavoritesContextProps {
  favorites: number[]; // Array of product IDs
  addFavorite: (productId: number) => Promise<void>;
  removeFavorite: (productId: number) => Promise<void>;
  isFavorite: (productId: number) => boolean;
  userDocumentId: string | null;
  clearFavorites: () => void; // Clears favorites on logout or user switch
}

const FavoritesContext = createContext<FavoritesContextProps | undefined>(
  undefined
);

export const FavoritesProvider: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  const { isLoggedIn, userEmail } = useAuth();
  const [favorites, setFavorites] = useState<number[]>([]);
  const [userDocumentId, setUserDocumentId] = useState<string | null>(null);

  // Clears favorites and document ID
  const clearFavorites = () => {
    setFavorites([]);
    setUserDocumentId(null);
    console.log("Favorites cleared.");
  };

  // Fetch user's documentId and favorites
  useEffect(() => {
    if (!isLoggedIn || !userEmail) {
      clearFavorites();
      return;
    }

    (async () => {
      try {
        console.log("Fetching user by email:", userEmail);

        // Fetch the user by email
        const userResponse = await fetchAPI(
          `/bidusers?filters[email][$eq]=${encodeURIComponent(userEmail)}`
        );
        console.log("User fetch response:", userResponse);

        if (userResponse.data.length > 0) {
          const user = userResponse.data[0];
          setUserDocumentId(user.documentId);

          console.log(
            "Fetching user details with documentId:",
            user.documentId
          );

          // Fetch user details including favorites
          const userDetailsResponse = await fetchAPI(
            `/bidusers/${user.documentId}?populate=favourites`
          );
          console.log("User details fetch response:", userDetailsResponse);

          const userFavorites =
            userDetailsResponse.data?.favourites?.map(
              (product: any) => product.id
            ) || [];
          console.log("Extracted favorites from API:", userFavorites);

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

  // Add a product to favorites
  const addFavorite = async (productId: number) => {
    if (!userDocumentId) {
      console.error("User documentId not found.");
      return;
    }

    const updatedFavorites = [...favorites, productId];
    setFavorites(updatedFavorites); // Optimistic update

    try {
      console.log("Adding favorite with payload:", {
        data: {
          favourites: updatedFavorites,
        },
      });

      await fetchAPI(`/bidusers/${userDocumentId}`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          data: {
            favourites: updatedFavorites,
          },
        }),
      });

      console.log("Favorite added successfully");
    } catch (error) {
      console.error("Error adding favorite:", error);
      setFavorites(favorites); // Revert optimistic update on failure
    }
  };

  // Remove a product from favorites
  const removeFavorite = async (productId: number) => {
    if (!userDocumentId) {
      console.error("User documentId not found.");
      return;
    }

    const updatedFavorites = favorites.filter((id) => id !== productId);
    setFavorites(updatedFavorites); // Optimistic update

    try {
      console.log("Removing favorite with payload:", {
        data: {
          favourites: updatedFavorites,
        },
      });

      await fetchAPI(`/bidusers/${userDocumentId}`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          data: {
            favourites: updatedFavorites,
          },
        }),
      });

      console.log("Favorite removed successfully");
    } catch (error) {
      console.error("Error removing favorite:", error);
      setFavorites(favorites); // Revert optimistic update on failure
    }
  };

  // Check if a product is in the user's favorites
  const isFavorite = (productId: number) => favorites.includes(productId);

  return (
    <FavoritesContext.Provider
      value={{
        favorites,
        addFavorite,
        removeFavorite,
        isFavorite,
        clearFavorites,
        userDocumentId
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
