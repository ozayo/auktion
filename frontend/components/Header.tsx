import Link from "next/link";
import Image from "next/image";
import logoWhite from "../public/Bouvet_Logo_white.svg";
import logo from "../public/Bouvet_Logo_Colossus.svg";
import { getUserMeLoader } from "@/app/data/services/get-user-me-loader";
import ClientHeader from "./ClientHeader";

const Header = async () => {
  // Server-side'da kullanıcı bilgilerini al
  const user = await getUserMeLoader();
  
  return (
    <ClientHeader user={user} />
  );
};

export default Header;
