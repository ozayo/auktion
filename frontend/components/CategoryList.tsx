//components/CategoryList.tsx

import Link from "next/link";

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

  return (
    <div className="flex space-x-4 mb-6">
      {categories.map((category) => (
        <Link
          key={category.id}
          // href={`/category/${category.documentId}`}
          href={`/category/${category.slug}`} // slug link
          className="text-blue-500 hover:underline"
        >
          {category.category_name}
        </Link>
      ))}
    </div>
  );
}
