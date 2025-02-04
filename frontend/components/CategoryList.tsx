//components/CategoryList.tsx

"use client";

import Link from "next/link";
import { usePathname } from 'next/navigation';
import { useCategories } from '@/contexts/CategoryContext';

export default function CategoryList() {
  const { categories, loading } = useCategories();
  const pathname = usePathname();

  if (loading) return null;
  if (!categories || categories.length === 0) {
    return <p className="text-gray-600">No categories available</p>;
  }

  return (
    <div className="pt-4 pb-8 flex gap-2">
      <Link
        className={`text-blue-500 rounded-full bg-gray-100 py-1 px-5 hover:text-white hover:bg-blue-950 hover:text-white" [&.active]:bg-blue-950 [&.active]:text-white ${pathname === '/produkter' ? 'active' : ''}`}
        href="/produkter">
        Alla produkter
      </Link>
      {categories.map((category) => (
        <Link
          key={category.id}
          href={`/category/${category.slug}`}
          className={`text-blue-500 rounded-full bg-gray-100 py-1 px-5 hover:text-white hover:bg-blue-950 hover:text-white" [&.active]:bg-blue-950 [&.active]:text-white ${pathname === `/category/${category.slug}` ? 'active' : ''}`}
        >
          {category.category_name}
        </Link>
      ))}
    </div>
  );
}
