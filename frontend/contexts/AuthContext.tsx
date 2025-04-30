"use client";

import { createContext, useContext, useState, useEffect, ReactNode } from "react";

// Strapi kullanıcı tipi
interface User {
  id: number;
  documentId: string;
  username: string;
  email: string;
  // ve diğer Strapi user alanları
}

interface AuthContextProps {
  user: User | null;
  isLoading: boolean;
  isAuthenticated: boolean;
}

// Server-side'da veri gelene kadar varsayılan değerler
const defaultAuthContext: AuthContextProps = {
  user: null,
  isLoading: true,
  isAuthenticated: false
};

const AuthContext = createContext<AuthContextProps>(defaultAuthContext);

interface AuthProviderProps {
  children: ReactNode;
  initialUser?: {
    ok: boolean;
    data: User | null;
    error: any;
  };
}

export const AuthProvider = ({ children, initialUser }: AuthProviderProps) => {
  // Eğer Server Component'ten initialUser geldiyse, bu değeri kullan
  const [user, setUser] = useState<User | null>(initialUser?.data || null);
  const [isLoading, setIsLoading] = useState(!initialUser);
  const [isAuthenticated, setIsAuthenticated] = useState(initialUser?.ok || false);

  useEffect(() => {
    // Eğer initialUser zaten server-side'dan geldiyse, tekrar istek atma
    if (initialUser) {
      setUser(initialUser.data);
      setIsAuthenticated(initialUser.ok);
      setIsLoading(false);
      return;
    }

    // Server-side'dan initialUser gelmezse client-side'da bir istek at
    const fetchUser = async () => {
      try {
        const response = await fetch('/api/auth/me');
        const data = await response.json();

        if (data.ok && data.data) {
          setUser(data.data);
          setIsAuthenticated(true);
        } else {
          setUser(null);
          setIsAuthenticated(false);
        }
      } catch (error) {
        console.error("Kullanıcı bilgileri alınırken hata:", error);
        setUser(null);
        setIsAuthenticated(false);
      } finally {
        setIsLoading(false);
      }
    };

    fetchUser();
  }, [initialUser]);

  // Debug için
  useEffect(() => {
    console.log("AuthContext state:", { isAuthenticated, isLoading, user });
  }, [isAuthenticated, isLoading, user]);

  return (
    <AuthContext.Provider value={{ user, isLoading, isAuthenticated }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error("useAuth must be used within an AuthProvider");
  }
  return context;
};