// app/(pages)/lotteries/page.tsx

'use client';

import { useEffect, useState } from 'react';
import Link from "next/link";
import { useRouter } from 'next/navigation';

interface Product {
  id: number;
  documentId: string;
  title: string;
  price: number | null;
  ending_date: string;
  lottery_users: Array<any>;
  createdAt: string;
  main_picture: {
    url: string;
  };
}

export default function LotteriesPage() {
  const [products, setProducts] = useState<Product[]>([]);
  const [showExpired, setShowExpired] = useState(true);
  const [hideNoUsers, setHideNoUsers] = useState(true);
  const [isLoading, setIsLoading] = useState(true);
  const router = useRouter();

  useEffect(() => {
    const token = localStorage.getItem('strapi-admin-token');

    if (!token) {
      router.push('/login');
      return;
    }

    const checkAdmin = async () => {
      try {
        const response = await fetch('/api/check-admin', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ token }),
        });

        const data = await response.json();

        if (!data.isAdmin) {
          router.push('/login');
          return;
        }

        fetchProducts();
      } catch {
        router.push('/login');
      }
    };

    const fetchProducts = async () => {
      try {
        const res = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/products?populate=*&filters[lottery_product][$eq]=true&filters[manual_lottery][$eq]=true&pagination[pageSize]=100`
        );
        const data = await res.json();
        const filteredProducts = data.data.filter((product: any) => {
          return (
            product.lottery_winner === null
          );
        });
        setProducts(filteredProducts);
        setIsLoading(false);
      } catch (err) {
        console.error('Failed to fetch products', err);
        setIsLoading(false);
      }
    };

    checkAdmin();
  }, [router]);

  const filteredProducts = products.filter((product) => {
    const isExpired = new Date(product.ending_date) < new Date();
    const hasUsers = product.lottery_users.length > 0;
    return (
      (showExpired ? isExpired : true) && (hideNoUsers ? hasUsers : true)
    );
  });

  if (isLoading) {
    return <div>Loading...</div>;
  }

  return (
    <div className='w-full mx-auto pt-8 pb-14'>
      <div className='w-full flex flex-row justify-between align-middle '>
        <h1 className='text-3xl font-bold mb-4 w-9/12'>Lotteriprodukter</h1>
        <div className='flex align-middle justify-end items-start w-3/12'>
          <a className='border border-gray-500 py-1 px-5 content-center rounded hover:bg-black hover:text-white' href='/login'>← gå tillbaka</a>
        </div>
      </div>
      
      <p>Följande produkter är redo för manuell lotteri. Endast produkter med <strong>manual_lottery=true</strong> listas..</p>

      {/* Filter area */}
      <div className='flex gap-4 mt-6 mb-8'>
        <label className='flex items-center gap-2'>
          <input
            type="checkbox"
            checked={showExpired}
            onChange={() => setShowExpired(!showExpired)}
          />
          Endast utgångna produkter
        </label>
        <label className='flex items-center gap-2'>
          <input
            type="checkbox"
            checked={hideNoUsers}
            onChange={() => setHideNoUsers(!hideNoUsers)}
          />
          Dölja produkter utan användare
        </label>
      </div>

      {/* product list */}
      {filteredProducts.map((product) => (
        <div className='border bg-white py-4 px-6 hover:bg-zinc-50 overflow-hidden mb-6' key={product.id}>
          <h2 className='text-2xl font-bold mb-4'>{product.title}</h2>

          <div className='flex flex-col sm:flex-row gap-4'>
            <div className='product-images relative w-full sm:w-3/12 min-h-48'>
              {product.main_picture ? (
                <img
                  className='w-full h-48 object-cover rounded-lg'
                  src={`${process.env.NEXT_PUBLIC_API_URL}${product.main_picture.url}`}
                  alt={product.title}
                />
              ) : (
                <img className='w-full h-48 object-cover rounded-lg' src="/placeholder.png" alt="Placeholder image" />
              )}
            </div>
            <div className='infoarea flex flex-col w-full sm:w-5/12 px-4'>
              <div className='flex flex-col gap-1 justify-between'>
                <p className='text-gray-700 text-sm'><strong>Product ID:</strong> {product.documentId}</p>
                <p className='text-gray-700 text-sm'><strong>Skapat datum:</strong> {new Date(product.createdAt).toLocaleString()}</p>
                <p className='text-gray-700 text-sm'><strong>Slutdatum:</strong> {new Date(product.ending_date).toLocaleString()}</p>
                <p className='text-gray-700 text-sm'><strong>Utgångspris:</strong> {product.price || 0} SEK</p>
                <p className='text-gray-700 text-sm'><strong>Antal deltagare:</strong> {product.lottery_users.length}</p>
                <div className='w-48 border-t pb-2 my-2'></div>
                <Link href={`/product/${product.documentId}`} target="_blank" className='text-black inline-block'>Gå till produkt ↗</Link>
              </div>
            </div>
            <div className='buttonarea w-full sm:w-4/12 justify-end items-end'>
              <button
                className='bg-black text-white p-2 rounded w-full'
                onClick={() => router.push(`/lotteries/${product.documentId}`)}>
                🎲 Starta lotteri  →
              </button>
            </div>
          </div>
        </div>
      ))}
    </div>
  );
}
