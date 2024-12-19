//components/CategoryList.tsx

import Link from "next/link";
import { usePathname } from 'next/navigation'

interface Category {
  id: number;
  documentId: string;
  slug: string; // for slug use
  category_name: string;
}

interface CategoryListProps {
  categories: Category[];
}

export default function CategoryList({ categories }: CategoryListProps) {
  if (!categories || categories.length === 0) {
    return <p className="text-gray-600">No categories available</p>;
  }
  const pathname = usePathname()

  return (
    <div className="flex space-x-3 my-6">
      <Link
        className={`text-blue-500 rounded-full bg-gray-100 py-1 px-5 hover:text-white hover:bg-blue-950 hover:text-white" [&.active]:bg-blue-950 [&.active]:text-white ${pathname === '/produkter' ? 'active' : ''}`}
        href="/produkter">
        Alla produkter
      </Link>
      {categories.map((category) => (
        <Link
          key={category.id}
          // href={`/category/${category.documentId}`}
          href={`/category/${category.slug}`} // slug link
          className={`text-blue-500 rounded-full bg-gray-100 py-1 px-5 hover:text-white hover:bg-blue-950 hover:text-white" [&.active]:bg-blue-950 [&.active]:text-white ${pathname === `/category/${category.slug}` ? 'active' : ''}`}
        >
          {category.category_name}
        </Link>
      ))}
    </div>
  );
}
