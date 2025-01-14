'use client';

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';

export default function LotteriesPage() {
  const [isLoading, setIsLoading] = useState<boolean>(true);
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

        const data: { isAdmin: boolean } = await response.json();

        if (data.isAdmin) {
          setIsLoading(false);
        } else {
          router.push('/login');
        }
      } catch {
        router.push('/login');
      }
    };

    checkAdmin();
  }, [router]);

  if (isLoading) {
    return <div>Loading...</div>;
  }

  return <div>Welcome to the Lotteries Page!</div>;
}
