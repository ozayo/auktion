import React from "react";

// Yeni sistemde eğer user alanı varsa bu tipte olabilir:
interface User {
  id: number;
  username?: string;
  email?: string;
}

// Eskiden biduser alanı kullanılıyordu:
interface BidUser {
  Name: string;
}

interface LotteryUser {
  id: number;
  createdAt: string;
  biduser?: BidUser | null;
  user?: User | null;  // Yeni kayıtlarda dolu olabilir
}

interface BidderListLotProps {
  lotteryUsers: LotteryUser[];
}

const BidderListLot: React.FC<BidderListLotProps> = ({ lotteryUsers }) => {
  // Kayıtları en yeni tarih en üstte olacak şekilde sıralıyoruz
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
            {sortedUsers.map((lotUser) => {
              // Yeni kayıtlarda lotUser.user -> username veya email
              // Eski kayıtlarda lotUser.biduser -> Name
              const displayName =
                lotUser.user?.username ||
                lotUser.user?.email ||
                lotUser.biduser?.Name ||
                "Okänd användare";

              return (
                <tr key={lotUser.id} className="border-b border-gray-200 py-2">
                  <td className="px-4 py-1">{displayName}</td>
                  <td className="px-4 py-1">
                    {new Date(lotUser.createdAt).toLocaleString()}
                  </td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>
    </>
  );
};

export default BidderListLot;
