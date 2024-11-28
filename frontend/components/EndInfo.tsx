import Link from 'next/link'
import { FaLongArrowAltRight } from "react-icons/fa";


interface EndInfoProps {
  username: string;
  highestBid: number;
}

const EndInfo: React.FC<EndInfoProps> = ({ username, highestBid }) => {
  return (
    <div className="bg-gray-100 p-4 rounded-lg mt-4">
      <h2 className="text-xl font-black">Budgivning avslutad</h2>
      <p className="mt-2">
        <strong>{username}</strong> vann den här auktionen genom att lägga det högsta budet med <strong>{highestBid} SEK</strong>.
      </p>
      <p className="mt-2">
        <Link className='flex items-center group hover: text-orange-400' href="/">Hitta en liknande <FaLongArrowAltRight className='ml-2 group-hover:ml-3' /></Link>
      </p>
    </div>
  );
};

export default EndInfo;
