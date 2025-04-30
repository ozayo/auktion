"use client";

import React from "react";
import { AuthProvider } from "@/contexts/AuthContext";
import { FavoritesProvider } from "@/contexts/FavoritesContext";
import { CategoryProvider } from '@/contexts/CategoryContext';

interface ClientProvidersProps {
  children: React.ReactNode;
  initialUser?: any; // Server-side'dan gelen kullanıcı verileri
}

export default function ClientProviders({
  children,
  initialUser
}: ClientProvidersProps) {
  return (
    <AuthProvider initialUser={initialUser}>
      <FavoritesProvider>
        <CategoryProvider>
          {children}
        </CategoryProvider>
      </FavoritesProvider>
    </AuthProvider>
  );
} 