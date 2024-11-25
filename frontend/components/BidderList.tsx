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
      <h2 className="text-xl font-semibold mt-8">Erbjuder</h2>
      <ul>
        {bids.map((bid) => (
          <li key={bid.id} className="border-b py-2">
            <p>
              <strong>{bid.biduser?.Name || 'Unknown User'}:</strong> {bid.Amount} SEK
            </p>
            <p className="text-gray-500 text-sm">
              Datum: {new Date(bid.createdAt).toLocaleString()}
            </p>
          </li>
        ))}
      </ul>
    </>
  );
};

export default BidderList;
