// components/ProductCard.tsx
import Link from 'next/link';
import { API_URL } from '../lib/api';

interface ProductCardProps {
  product: any;
}

export default function ProductCard({ product }: ProductCardProps) {
  if (!product) {
    console.error('Product is undefined:', product);
    return null; // eller visa ett lämpligt felmeddelande
  }

  const { id, title, price, main_picture } = product;

  const imageUrl = main_picture?.url
    ? `${API_URL}${main_picture.url}`
    : '/placeholder.png';

  return (
    <div className="border p-4 rounded">
      <img src={imageUrl} alt={title} className="w-full h-48 object-cover mb-2" />
      <h2 className="text-xl font-semibold">{title}</h2>
      <p className="text-gray-700">Utgångspris: {price} SEK</p>
      <Link href={`/product/${product.documentId}`} className="text-blue-500 mt-2 inline-block">
        Se Detaljer
      </Link>
    </div>
  );
}
