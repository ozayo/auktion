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
      // User authentication or creation
      let biduserId;

      // User email control
      const bidusersData = await fetchAPI(
        `/bidusers?filters[email][$eq]=${userEmail}`
      );
      if (bidusersData.data.length > 0) {
        // If the user exists
        biduserId = bidusersData.data[0].id;
      } else {
        // Create new user
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

     // Creating an offer
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

      setMessage('Ditt bud har registrerats!');
      setAmount('');
    } catch (error) {
      console.error(error);
      setMessage('Ett fel har uppstått.');
    }
  };

  return (
    <div className="mt-8">
      <h2 className="text-xl font-semibold">Lägg ett bud</h2>
      {!userEmail ? (
        <div>
          <p>Ange din e-postadress för att bjuda:</p>
          <input
            type="email"
            placeholder="Email"
            value={userEmail}
            onChange={(e) => setUserEmail(e.target.value)}
            className="border p-2 mr-2"
          />
          <input
            type="text"
            placeholder="Namn"
            value={userName}
            onChange={(e) => setUserName(e.target.value)}
            className="border p-2 mr-2"
          />
          <button onClick={() => {}} className="bg-blue-500 text-white px-4 py-2">
            Börja
          </button>
        </div>
      ) : (
        <div>
          <p>Budbelopp:</p>
          <input
            type="number"
            placeholder="Budbelopp:"
            value={amount}
            onChange={(e) => setAmount(e.target.value)}
            className="border p-2 mr-2"
          />
          <button onClick={handleBid} className="bg-green-500 text-white px-4 py-2">
            Lägg ett bud
          </button>
        </div>
      )}
      {message && <p className="mt-2">{message}</p>}
    </div>
  );
}
