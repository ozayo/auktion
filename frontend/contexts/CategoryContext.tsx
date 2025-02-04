"use client";

import { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { API_URL } from "@/lib/api";

interface Category {
  id: number;
  documentId: string;
  slug: string;
  category_name: string;
}

interface CategoryContextType {
  categories: Category[];
  loading: boolean;
}

const CategoryContext = createContext<CategoryContextType>({
  categories: [],
  loading: true
});

export function CategoryProvider({ children }: { children: ReactNode }) {
  const [categories, setCategories] = useState<Category[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchCategories = async () => {
      try {
        const response = await fetch(`${API_URL}/api/categories`);
        const data = await response.json();
        setCategories(data.data);
      } catch (error) {
        console.error("Error fetching categories:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchCategories();
  }, []);

  return (
    <CategoryContext.Provider value={{ categories, loading }}>
      {children}
    </CategoryContext.Provider>
  );
}

export const useCategories = () => useContext(CategoryContext); 