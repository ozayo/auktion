// components/BidderList.tsx

import React from 'react';

// Eski biduser yapısı
interface BidUser {
  id: number;
  Name: string;
}

// Yeni user yapısı
interface User {
  id: number;
  username: string;
  email: string;
}

interface Bid {
  id: number;
  Amount: number;
  createdAt: string;
  biduser?: BidUser | null;
  user?: User | null; // Yeni user alanı
}

interface BidderListProps {
  bids: Bid[];
}

const BidderList: React.FC<BidderListProps> = ({ bids }) => {
  return (
    <>
      <h2 className="text-xl font-semibold mt-8 mb-4">Erbjuder</h2>
      <div className='overflow-y-auto max-h-44'>
      <table className="w-full border-collapse text-sm">
        <thead>
          <tr className="bg-gray-100">
            <th className="px-4 py-2 text-left">Bud</th>
            <th className="px-4 py-2 text-left">Datum</th>
            <th className="px-4 py-2 text-left">Budgivare</th>
          </tr>
        </thead>
        <tbody>
          {bids.map((bid) => {
            // Kullanıcı adını belirle: önce yeni user sonra eski biduser yapısını kontrol et
            const displayName = bid.user?.username || bid.biduser?.Name || 'Unknown User';
            
            return (
              <tr key={bid.id} className="border-b border-gray-200 py-2">
                <td className="px-4 py-1">
                  {bid.Amount} SEK
                </td>
                <td className="px-4 py-1">
                  {new Date(bid.createdAt).toLocaleString()}
                </td>
                <td className="px-4 py-1">{displayName}</td>
              </tr>
            );
          })}
        </tbody>
      </table>
      </div>
    </>
  );
};

export default BidderList;
