// components/BidderList.tsx

import React from 'react';

interface BidUser {
  id: number;
  Name: string;
}

interface Bid {
  id: number;
  Amount: number;
  createdAt: string;
  biduser?: BidUser;
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
            <th className="px-4 py-2 text-left">Bid</th>
            <th className="px-4 py-2 text-left">Datum</th>
            <th className="px-4 py-2 text-left">User</th>
          </tr>
        </thead>
        <tbody>
          {bids.map((bid) => (
          <tr key={bid.id} className="border-b py-2">
            <td className="px-4 py-1">
              {bid.Amount} SEK
            </td>
            <td className="px-4 py-1">
              {new Date(bid.createdAt).toLocaleString()}
            </td>
            <td className="px-4 py-1">{bid.biduser?.Name || 'Unknown User'}</td>
          </tr>
        ))}
        </tbody>
      </table>
      </div>
    </>
  );
};

export default BidderList;
