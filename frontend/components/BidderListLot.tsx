// components/BidderListLot.tsx

import React from "react";

interface LotteryUser {
  id: number;
  createdAt: string;
  biduser?: {
    Name: string;
  };
}

interface BidderListLotProps {
  lotteryUsers: LotteryUser[];
}

const BidderListLot: React.FC<BidderListLotProps> = ({ lotteryUsers }) => {
  // Sort the users by createdAt in descending order so the newest one appears first.
  const sortedUsers = [...lotteryUsers].sort(
    (a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime()
  );

  if (!sortedUsers || sortedUsers.length === 0) {
    return (
      <div className="bg-gray-100 p-4 rounded-lg mt-4">
        <p className="text-gray-600">Ingen har gått med i vårt lotteri än.</p>
      </div>
    );
  }

  return (
    <>
      <h2 className="text-xl font-semibold mt-8 mb-4">Deltagare</h2>
      <div className="overflow-y-auto max-h-44">
        <table className="w-full border-collapse text-sm">
          <thead>
            <tr className="bg-gray-100">
              <th className="px-4 py-2 text-left">User</th>
              <th className="px-4 py-2 text-left">Datum</th>
            </tr>
          </thead>
          <tbody>
            {sortedUsers.map((user) => (
              <tr key={user.id} className="border-b border-gray-200 py-2">
                <td className="px-4 py-1">
                  {user.biduser?.Name || "Okänd användare"}
                </td>
                <td className="px-4 py-1">
                  {new Date(user.createdAt).toLocaleString()}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </>
  );
};

export default BidderListLot;
