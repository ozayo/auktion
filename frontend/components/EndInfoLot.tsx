// components/EndInfoLot.tsx

import Link from "next/link";
import { FaLongArrowAltRight } from "react-icons/fa";

// Winner object now includes both Name and Email
interface EndInfoLotProps {
  winner: {
    Name: string | null;
    Email: string | null;
  } | null;
}

const EndInfoLot: React.FC<EndInfoLotProps> = ({ winner }) => {
  return (
    <div className="bg-gray-100 p-4 rounded-lg mt-4">
      <h2 className="text-xl font-black">Lotteri avslutad</h2>
      {winner ? (
        <p className="mt-2">
          {/* Winner's name and email displayed here */}
          Vinnare: <strong>{winner.Name || "Okänd användare"}</strong>
          (<span>{winner.Email || "Okänd e-post"}</span>)
        </p>
      ) : (
        <p className="mt-2 text-gray-600">Det finns ingen vinnare</p>
      )}
      <p className="mt-2">
        <Link
          className="flex items-center group text-orange-400 hover:text-orange-400"
          href="/"
        >
          Hitta ett nytt lotteri <FaLongArrowAltRight className="ml-2 group-hover:ml-3" />
        </Link>
      </p>
    </div>
  );
};

export default EndInfoLot;
