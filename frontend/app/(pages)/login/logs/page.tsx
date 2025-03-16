"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";

interface User {
  documentId: string;
  email: string;
  Name: string;
  createdAt: string;
  updatedAt: string;
  active: boolean;
  bids: Bid[];
  lottery_users: LotteryUser[];
}

interface Bid {
  documentId: string;
  Amount: number;
  createdAt: string;
  updatedAt: string;
  publishedAt: string;
  product?: Product | null;
}

interface Product {
  documentId: string;
  title: string;
}

interface LotteryUser {
  documentId: string;
  createdAt: string;
  updatedAt: string;
  publishedAt: string;
  products: Product[];
}

export default function UserDetails() {
  const [email, setEmail] = useState<string>("");
  const [user, setUser] = useState<User | null>(null);
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [activeTab, setActiveTab] = useState<string>("session");
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

        setIsLoading(false);
      } catch {
        router.push('/login');
      }
    };

    checkAdmin();
  }, [router]);

  const fetchUser = () => {
    if (email) {
      fetch(`http://localhost:1337/api/bidusers?filters[email][$eq]=${email}&populate[bids][populate]=product&populate[lottery_users][populate]=products`)
        .then(res => res.json())
        .then(({ data }) => {
          if (data.length) setUser(data[0]);
          else setUser(null);
        });
    }
  };

  if (isLoading) {
    return <div>Loading...</div>;
  }

  return (
    <div className="p-6">
      <div className="mb-4 flex justify-between items-center">
        <div>
          <input
            type="text"
            placeholder="Kullanıcı email adresini giriniz"
            className="border rounded px-3 py-2"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
          />
          <button onClick={fetchUser} className="ml-2 px-4 py-2 bg-blue-500 text-white rounded">
            Göster
          </button>
        </div>
        <a href="/login" className="px-4 py-2 border border-gray-300 rounded hover:bg-gray-100">
          ← Geri Dön
        </a>
      </div>

      {!user && <div>Kullanıcı bulunamadı veya henüz arama yapılmadı.</div>}

      {user && (
        <>
          <h1 className="text-2xl font-bold">Kullanıcı Bilgileri</h1>
          <div className="mt-4">
            <p><strong>Document ID:</strong> {user.documentId}</p>
            <p>Email: {user.email}</p>
            <p>İsim: {user.Name}</p>
            <p>Oluşturulma: {new Date(user.createdAt).toLocaleString()}</p>
            <p>Güncellenme: {new Date(user.updatedAt).toLocaleString()}</p>
            <p>Aktif: {user.active ? "Evet" : "Hayır"}</p>

            <div className="mt-8 flex gap-4">
              <button 
                onClick={() => setActiveTab("session")} 
                className={`text-blue-500 ${activeTab === "session" ? "font-bold" : ""}`}
              >
                User session logs
              </button>
              <span>|</span>
              <button 
                onClick={() => setActiveTab("bids")} 
                className={`text-blue-500 ${activeTab === "bids" ? "font-bold" : ""}`}
              >
                User bidding logs
              </button>
              <span>|</span>
              <button 
                onClick={() => setActiveTab("lottery")} 
                className={`text-blue-500 ${activeTab === "lottery" ? "font-bold" : ""}`}
              >
                User lottery logs
              </button>
            </div>

            {activeTab === "session" && (
              <div id="session-logs" className="mt-10">
                <h2 className="text-xl font-semibold">User session logs</h2>
                <p className="my-2">Session logs are not available at the moment.</p>
              </div>
            )}

            {activeTab === "bids" && (
              <div id="bids" className="mt-10">
                <h2 className="text-xl font-semibold">User bidding logs</h2>
                {user.bids.sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime()).map((bid) => (
                  <div key={bid.documentId} className="my-2 p-2 border rounded">
                    <h2 className="text-lg font-medium">
                      {bid.product ? `${bid.product.title} (ID: ${bid.product.documentId})` : "Ürün bilgisi bulunamadı"}
                    </h2>
                    <p>Bid ID: {bid.documentId}</p>
                    <p>Teklif Tutarı: {bid.Amount}</p>
                    <p>Oluşturulma: {new Date(bid.createdAt).toLocaleString()}</p>
                    <p>Güncellenme: {new Date(bid.updatedAt).toLocaleString()}</p>
                    <p>Yayınlanma: {new Date(bid.publishedAt).toLocaleString()}</p>
                  </div>
                ))}
                {user.bids.length === 0 && <p className="my-2">Kullanıcının teklifi bulunmamaktadır.</p>}
              </div>
            )}

            {activeTab === "lottery" && (
              <div id="lottery" className="mt-10">
                <h2 className="text-xl font-semibold">Kullanıcının Katıldığı Piyangolar</h2>
                {user.lottery_users.map((lotteryUser) => (
                  <div key={lotteryUser.documentId} className="my-2 p-2 border rounded">
                    {lotteryUser.products.map((product) => (
                      <div key={product.documentId}>
                        <h2 className="text-lg font-medium">{product.title} (ID: {product.documentId})</h2>
                        <p>Kayıt Tarihi: {new Date(lotteryUser.createdAt).toLocaleString()}</p>
                      </div>
                    ))}
                  </div>
                ))}
                {user.lottery_users.length === 0 && <p className="my-2">Kullanıcının katıldığı piyango bulunmamaktadır.</p>}
              </div>
            )}
          </div>
        </>
      )}
    </div>
  );
}