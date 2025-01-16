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
      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/products/${documentId}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          data: { lottery_winner: winner.documentId },
        }),
      });

      if (!response.ok) {
        const error = await response.json();
        console.error('Failed to save winner:', error);
        alert('Kazanan kaydedilemedi. Lütfen tekrar deneyin.');
      } else {
        // API'den kazanan bilgisini al ve güncelle
        setExistingWinner(winner);
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
    <div>
      <h1>{product.title}</h1>

      {existingWinner ? (
        <div className="existing-winner">
          <h2>Kazanan:</h2>
          <p>{existingWinner.Name}</p>
          <p>{existingWinner.email}</p>
        </div>
      ) : null}

      <div className="participants-list">
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

      <button onClick={startLottery} disabled={isRunning}>
        {isRunning
          ? 'Running...'
          : product.lottery_users.length === 1
          ? 'Save this user as winner'
          : 'Start Lottery'}
      </button>

      {winner && (
        <div className="winner-modal">
          <div className="modal-content">
            <h2>Kazanan: {winner.Name}</h2>
            <p>{winner.email}</p>
            <button onClick={resetState}>Kapat</button>
          </div>
        </div>
      )}
    </div>
  );
}
