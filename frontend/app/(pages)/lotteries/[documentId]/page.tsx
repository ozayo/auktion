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
    if (existingWinner) {
      const confirmMessage = "Det finns redan en vinnare för denna produkt. Om du fortsätter kommer den nuvarande vinnande användaren att tas bort och en ny användare kommer att väljas som vinnare. Är du säker på att du vill fortsätta?";
      if (!confirm(confirmMessage)) {
        return; // If the user does not want to continue, stop the process.
      }
    }

    if (!product || isRunning || !product.lottery_users || product.lottery_users.length === 0) {
      alert('The user list is empty or the lottery cannot be started!');
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
      alert('Error: User data is missing!');
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

    // The date and time when the lottery is held
    const currentDate = new Date();
    const endingDate = new Date(product.ending_date);

    // If the ending_date is in the future, it will be updated as the date when the lottery is held
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
      alert('The winner could not be recorded. Please try again.');
    } else {
      // Get the winner information from the API and update it.
      setExistingWinner(winner);

      if (shouldUpdateEndingDate) {
        // update to ending_date
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
        <div className="existing-winner bg-black text-white py-8 my-4 items-center text-center mb-12">
          <p className='text-6xl'>🏆</p>
          <h2 className='text-3xl font-bold my-2'>Vinnare:</h2>
          <p className='text-2xl'>{existingWinner.Name}</p>
          <p>{existingWinner.email}</p>
        </div>
      ) : null}

      <div className="participants-list grid grid-cols-3 gap-2 mt-5 mb-20">
        {product.lottery_users.map((user, index) => (
          <div
            key={user.id}
            className={`participant ${activeIndex === index ? 'active' : ''}`}
          >
            <p className='username'>{user.biduser.Name}</p>
            <p className='useremail'>{user.biduser.email}</p>
          </div>
        ))}
      </div>

      <button onClick={startLottery} disabled={isRunning} className='bg-black text-white mt-8 py-4 px-6 w-72 hover:bg-gray-800'>
        {isRunning
          ? 'Running...'
          : product.lottery_users.length === 1
          ? 'Spara denna användare som vinnare 💾'
          : 'Starta Lotteri 🎲'}
      </button>

      {winner && (
        <div className="winner-modal">
          <div className="modal-content">
              <div className=" text-6xl">🏆</div>
              <h2 className='text-4xl font-bold text-amber-400'>VINNARE</h2>
              <p className='font-bold text-3xl'>{winner.Name}</p>
              <p>{winner.email}</p>
              <button onClick={resetState}>Spara & Stäng 💾</button>
          </div>
        </div>
      )}
    </div>
  );
}
