// app/(pages)/lotteries/page.tsx

'use client';

import { useEffect, useState } from 'react';
import Link from "next/link";
import { useRouter } from 'next/navigation';

interface Product {
  id: number;
  documentId: string;
  title: string;
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
          `${process.env.NEXT_PUBLIC_API_URL}/api/products?populate=*`
        );
        const data = await res.json();
        const filteredProducts = data.data.filter((product: any) => {
          return (
            product.lottery_product &&
            product.manual_lottery &&
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
    <div className='w-full mx-auto pb-14'>
      <h1 className='text-4xl font-bold mb-4'>Lottery products</h1>
      <p>The following products are ready for manual lottery. Only products with manual_lottery=true are listed.</p>

      <div className='flex gap-4 mt-6 mb-4'>
        <label className='flex items-center gap-2'>
          <input
            type="checkbox"
            checked={showExpired}
            onChange={() => setShowExpired(!showExpired)}
          />
          Only expired products
        </label>
        <label className='flex items-center gap-2'>
          <input
            type="checkbox"
            checked={hideNoUsers}
            onChange={() => setHideNoUsers(!hideNoUsers)}
          />
          Hide no users product
        </label>
      </div>

      {filteredProducts.map((product) => (
        <div className='bg-gray-50 mb-2 py-4 px-6' key={product.id}>
          <h2 className='text-2xl font-bold mb-2'>{product.title}</h2>
          <div className='flex flex-col sm:flex-row gap-4'>
            <div className='imagearea relative w-full sm:w-3/12 rounded-lg overflow-hidden'>
              {product.main_picture ? (
                <img
                  className='w-full h-48 object-cover'
                  src={`${process.env.NEXT_PUBLIC_API_URL}${product.main_picture.url}`}
                  alt={product.title}
                />
              ) : (
                <img className='w-full h-48 object-cover' src="/placeholder.png" alt="Placeholder image" />
              )}
            </div>
            <div className='infoarea flex flex-col gap-2 w-full sm:w-6/12'>
              <p>Product ID:  <Link href={`/product/${product.documentId}`} target="_blank" className='hover:decoration-2 text-black underline decoration-pink-500'>{product.documentId}</Link></p>
              <p>Crated Date: {new Date(product.createdAt).toLocaleString()}</p>
              <p>Ending Date: {new Date(product.ending_date).toLocaleString()}</p>
              <p>Total Users: {product.lottery_users.length}</p>
            </div>
            <div className='buttonarea w-full sm:w-3/12'>
              <button
                className='bg-black text-white p-2'
                onClick={() => router.push(`/lotteries/${product.documentId}`)}>
                Start Lottery →
              </button>
            </div>
          </div>
        </div>
      ))}
    </div>
  );
}
