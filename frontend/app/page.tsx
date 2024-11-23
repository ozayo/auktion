// app/page.tsx
import { fetchAPI } from '../lib/api';
import ProductCard from '../components/ProductCard';

export default async function HomePage() {
  const productsData = await fetchAPI('/products?populate=main_picture');

  const products = productsData.data;

  return (
    <main className="container mx-auto p-4">
      <h1 className="text-2xl font-bold mb-4">Ürünler</h1>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        {products.map((product: any) => (
          <ProductCard key={product.id} product={product} />
        ))}
      </div>
    </main>
  );
}
