
// app/pages/lotteries/[documentId]/page.tsx
"use client";

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { useParams } from 'next/navigation';

interface BidUser {
  id: number;
  Name: string;
  email: string;
  documentId: string;
}

interface LotteryUser {
  id: number;
  biduser: BidUser;
}

interface Product {
  id: number;
  title: string;
  lottery_users: LotteryUser[];
  lottery_winner: string | null;
  ending_date: string;
}

export default function LotteryDetailPage() {
  const { documentId } = useParams();
  const [product, setProduct] = useState<Product | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [isRunning, setIsRunning] = useState(false);
  const [activeIndex, setActiveIndex] = useState<number | null>(null);
  const [winner, setWinner] = useState<BidUser | null>(null);
  const [existingWinner, setExistingWinner] = useState<BidUser | null>(null);
  const router = useRouter();
  let intervalId: NodeJS.Timeout | null = null;

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

        fetchProduct();
      } catch {
        router.push('/login');
      }
    };

    const fetchProduct = async () => {
      try {
        const res = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/api/products/${documentId}?populate=lottery_users.biduser`
        );
        const data = await res.json();
        setProduct(data.data);

        if (data.data.lottery_winner) {
          const winnerUser = data.data.lottery_users.find(
            (user: LotteryUser) => user.biduser.documentId === data.data.lottery_winner
          );
          setExistingWinner(winnerUser?.biduser || null);
        }

        setIsLoading(false);
      } catch (err) {
        console.error('Failed to fetch product', err);
        setIsLoading(false);
      }
    };

    checkAdmin();
  }, [documentId, router]);

  const startLottery = () => {
    if (!product || isRunning || !product.lottery_users || product.lottery_users.length === 0) {
      alert('Kullanıcılar listesi boş veya çekiliş başlatılamıyor!');
      return;
    }

    if (product.lottery_users.length === 1) {
      saveSingleWinner(product.lottery_users[0].biduser);
      return;
    }

    setIsRunning(true);
    setWinner(null); // Kazananı sıfırla
    setActiveIndex(null); // Aktif kullanıcıyı sıfırla

    const duration = 5000; // Çekiliş süresi (ms)
    let lastIndex: number | null = null; // Son kullanılan indeks
    intervalId = setInterval(() => {
      let randomIndex;
      do {
        randomIndex = Math.floor(Math.random() * product.lottery_users.length);
      } while (randomIndex === lastIndex);

      lastIndex = randomIndex;
      setActiveIndex(randomIndex);
    }, 150); // Rastgele kullanıcı seçimi

    setTimeout(() => {
      stopLottery(lastIndex);
    }, duration);
  };

  const stopLottery = (finalIndex: number | null) => {
    if (!product || intervalId === null) return;

    clearInterval(intervalId); // Interval'i temizle
    intervalId = null;

    if (
      finalIndex === null ||
      finalIndex < 0 ||
      finalIndex >= product.lottery_users.length
    ) {
      console.error('Invalid activeIndex:', finalIndex);
      alert('Hata: Geçerli bir kazanan belirlenemedi!');
      setIsRunning(false);
      return;
    }

    const selectedUser = product.lottery_users[finalIndex];
    if (!selectedUser || !selectedUser.biduser) {
      console.error('Invalid user data:', selectedUser);
      alert('Hata: Kullanıcı verisi eksik!');
      setIsRunning(false);
      return;
    }

    const selectedWinner = selectedUser.biduser;
    setWinner(selectedWinner);
    saveWinner(selectedWinner);

    setIsRunning(false);
  };

  const saveSingleWinner = (winner: BidUser) => {
    setWinner(winner);
    saveWinner(winner);
  };

const saveWinner = async (winner: BidUser) => {
  try {
    if (!product) return;

    // Çekilişin yapıldığı tarih ve saat
    const currentDate = new Date();
    const endingDate = new Date(product.ending_date);

    // Eğer ending_date gelecekteyse, çekilişin yapıldığı tarih olarak güncellenecek
    const shouldUpdateEndingDate = endingDate > currentDate;

    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/products/${documentId}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        data: {
          lottery_winner: winner.documentId,
          ...(shouldUpdateEndingDate && { ending_date: currentDate.toISOString() }),
        },
      }),
    });

    if (!response.ok) {
      const error = await response.json();
      console.error('Failed to save winner:', error);
      alert('Kazanan kaydedilemedi. Lütfen tekrar deneyin.');
    } else {
      // API'den kazanan bilgisini al ve güncelle
      setExistingWinner(winner);

      if (shouldUpdateEndingDate) {
        // ending_date'i güncelle
        setProduct((prev) => {
          if (!prev) return prev;
          return { ...prev, ending_date: currentDate.toISOString() };
        });
      }
    }
  } catch (err) {
    console.error('Failed to save winner', err);
    alert('Kazanan kaydedilemedi. Lütfen tekrar deneyin.');
  }
};

  const resetState = () => {
    setWinner(null);
    setActiveIndex(null);
    setIsRunning(false);
  };

  if (isLoading) {
    return <div>Loading...</div>;
  }

  if (!product) {
    return <div>Product not found</div>;
  }

  return (
    <div className='pt-8 pb-14'>

      <div className='w-full flex flex-row justify-between align-middle '>
        <h1 className='text-3xl font-bold mb-4 w-9/12'>{product.title}</h1>
        <div className='flex align-middle justify-end items-start w-3/12'>
          <a className='border border-gray-500 py-1 px-5 content-center rounded hover:bg-black hover:text-white' href='/lotteries'>← gå tillbaka</a>
        </div>
      </div>

      {existingWinner ? (
        <div className="existing-winner bg-gray-100 p-4 my-4">
          <h2 className='text-2xl font-bold my-2'>Winner:</h2>
          <p>{existingWinner.Name}</p>
          <p>{existingWinner.email}</p>
        </div>
      ) : null}

      <div className="participants-list grid grid-cols-3 gap-2">
        {product.lottery_users.map((user, index) => (
          <div
            key={user.id}
            className={`participant ${activeIndex === index ? 'active' : ''}`}
          >
            <p>{user.biduser.Name}</p>
            <p>{user.biduser.email}</p>
          </div>
        ))}
      </div>

      <button onClick={startLottery} disabled={isRunning} className='bg-black text-white mt-8 py-4 px-6 w-72 hover:bg-gray-800'>
        {isRunning
          ? 'Running...'
          : product.lottery_users.length === 1
          ? 'Save this user as winner 💾'
          : 'Start Lottery 🎲'}
      </button>

      {winner && (
        <div className="winner-modal">
          <div className="modal-content">
            <div className=" text-6xl">👑</div>
            <h2 className='text-4xl font-bold text-amber-400'>WINNER</h2>
            <p className='font-bold text-3xl'>{winner.Name}</p>
            <p>{winner.email}</p>
            <button onClick={resetState}>Save & Close 💾</button>
          </div>
        </div>
      )}
    </div>
  );
}
