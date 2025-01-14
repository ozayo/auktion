// app/(pages)/lotteries/page.tsx

'use client';

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';

interface Product {
  id: number;
  documentId: string;
  title: string;
  ending_date: string;
  lottery_users: Array<any>;
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
    <div>
      <h1>Lotteries</h1>

      <div>
        <label>
          <input
            type="checkbox"
            checked={showExpired}
            onChange={() => setShowExpired(!showExpired)}
          />
          Only expired products
        </label>
        <label>
          <input
            type="checkbox"
            checked={hideNoUsers}
            onChange={() => setHideNoUsers(!hideNoUsers)}
          />
          Hide no users product
        </label>
      </div>

      {filteredProducts.map((product) => (
        <div key={product.id}>
          <h2>{product.title}</h2>
          <p>Document ID: {product.documentId}</p>
          <p>Ending Date: {new Date(product.ending_date).toLocaleString()}</p>
          <p>Total Users: {product.lottery_users.length}</p>
          <button onClick={() => router.push(`/lotteries/${product.documentId}`)}>
            Start Lottery
          </button>
        </div>
      ))}
    </div>
  );
}
