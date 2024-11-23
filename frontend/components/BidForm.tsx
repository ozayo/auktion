// components/BidForm.tsx
'use client';

import { useState } from 'react';
import { fetchAPI, API_URL } from '../lib/api';

interface BidFormProps {
  productId: string;
}

export default function BidForm({ productId }: BidFormProps) {
  const [amount, setAmount] = useState('');
  const [userEmail, setUserEmail] = useState('');
  const [userName, setUserName] = useState('');
  const [message, setMessage] = useState('');

  const handleBid = async () => {
    try {
      // Kullanıcı doğrulaması veya oluşturulması
      let biduserId;

      // Kullanıcı email kontrolü
      const bidusersData = await fetchAPI(
        `/bidusers?filters[email][$eq]=${userEmail}`
      );
      if (bidusersData.data.length > 0) {
        // Kullanıcı mevcut
        biduserId = bidusersData.data[0].id;
      } else {
        // Yeni kullanıcı oluştur
        const newUser = await fetchAPI('/bidusers', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            data: {
              email: userEmail,
              Name: userName,
            },
          }),
        });
        biduserId = newUser.data.id;
      }

      // Teklif oluşturma
      await fetchAPI('/bids', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          data: {
            Amount: parseFloat(amount),
            biduser: biduserId,
            product: parseInt(productId),
          },
        }),
      });

      setMessage('Teklifiniz başarıyla kaydedildi!');
      setAmount('');
    } catch (error) {
      console.error(error);
      setMessage('Bir hata oluştu.');
    }
  };

  return (
    <div className="mt-8">
      <h2 className="text-xl font-semibold">Teklif Ver</h2>
      {!userEmail ? (
        <div>
          <p>Teklif vermek için email adresinizi girin:</p>
          <input
            type="email"
            placeholder="Email"
            value={userEmail}
            onChange={(e) => setUserEmail(e.target.value)}
            className="border p-2 mr-2"
          />
          <input
            type="text"
            placeholder="İsim"
            value={userName}
            onChange={(e) => setUserName(e.target.value)}
            className="border p-2 mr-2"
          />
          <button onClick={() => {}} className="bg-blue-500 text-white px-4 py-2">
            Başla
          </button>
        </div>
      ) : (
        <div>
          <p>Teklif Tutarı:</p>
          <input
            type="number"
            placeholder="Teklif Tutarı"
            value={amount}
            onChange={(e) => setAmount(e.target.value)}
            className="border p-2 mr-2"
          />
          <button onClick={handleBid} className="bg-green-500 text-white px-4 py-2">
            Teklif Ver
          </button>
        </div>
      )}
      {message && <p className="mt-2">{message}</p>}
    </div>
  );
}
