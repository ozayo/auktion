"use client";

import Link from "next/link";
import Image from "next/image";
import { FaBars, FaTimes } from "react-icons/fa";
import logoWhite from "../public/Bouvet_Logo_white.svg";
import logo from "../public/Bouvet_Logo_Colossus.svg";
import { useState } from "react";
import { LogoutButton } from "./custom/logout-button";
import { useAuth } from "@/contexts/AuthContext";

// Strapi kullanıcı tipi
interface User {
  id: number;
  username: string;
  email: string;
  // Diğer Strapi user alanları da eklenebilir
}

interface UserResponse {
  ok: boolean;
  data: User | null;
  error: any;
}

interface ClientHeaderProps {
  user: UserResponse;
}

const ClientHeader = ({ user: initialUser }: ClientHeaderProps) => {
  // initialUser bilgilerini AuthProvider'a aktarıyoruz, ancak artık doğrudan useAuth'dan alıyoruz
  const { user, isAuthenticated, isLoading } = useAuth();
  const [isMobileNavOpen, setIsMobileNavOpen] = useState(false);

  const toggleMobileNav = () => setIsMobileNavOpen(!isMobileNavOpen);

  return (
    <header className="py-4 md:py-6 px-4 md:px-0">
      <div className="flex items-center justify-between">
        <div className="logo flex-none w-28">
          <Link href="/">
            <Image
              src={logoWhite}
              className="hidden dark:block"
              height={28}
              width={112}
              alt="Bouvet Logo"
            />
            <Image
              src={logo}
              className="block dark:hidden"
              height={28}
              width={112}
              alt="Bouvet Logo"
            />
          </Link>
        </div>

        {/* Desktop Navigation */}
        <div className="hidden md:flex grow justify-end items-center gap-8">
          <Link href="/" className="text-gray-800 dark:text-white hover:text-blue-500 font-bold">
            Home
          </Link>
          <Link href="/produkter" className="text-gray-800 dark:text-white hover:text-blue-500 font-bold">
            Produkter
          </Link>
          
          {isLoading ? (
            <span className="text-gray-500">Loading...</span>
          ) : isAuthenticated && user ? (
            <>
              <Link href="/my-page" className="text-gray-800 dark:text-white hover:text-blue-500 font-bold">
                Min sida
              </Link>
              <LogoutButton />
              <span className="ml-2 bg-blue-100 text-blue-800 px-3 py-1 rounded-full text-sm">
                {user.username || user.email}
              </span>
            </>
          ) : (
            <Link
              href="/signin"
              className="text-blue-500 hover:text-blue-700 font-bold"
            >
              Logga in
            </Link>
          )}
        </div>

        {/* Hamburger menu for mobile navigation */}
        <div
          className="hamburger md:hidden flex w-10 justify-end cursor-pointer"
          onClick={toggleMobileNav}
        >
          {isMobileNavOpen ? <FaTimes size="1.5em" /> : <FaBars size="1.5em" />}
        </div>
      </div>

      {/* Mobile Navigation */}
      {isMobileNavOpen && (
        <div className="flex flex-col items-end mt-4 bg-gray-100 p-4 shadow-md rounded md:hidden">
          <ul className="flex flex-col gap-4 w-full">
            <li>
              <Link
                href="/"
                className="text-gray-800 dark:text-white hover:text-blue-500 font-bold"
              >
                Home
              </Link>
            </li>
            <li>
              <Link href="/produkter" className="text-gray-800 dark:text-white hover:text-blue-500 font-bold">
                Produkter
              </Link>
            </li>
            
            {isLoading ? (
              <li><span className="text-gray-500">Loading...</span></li>
            ) : isAuthenticated && user ? (
              <>
                <li>
                  <Link
                    href="/my-page"
                    className="text-gray-800 dark:text-white hover:text-blue-500 font-bold"
                  >
                    Min sida
                  </Link>
                </li>
                <li>
                  <LogoutButton />
                </li>
                <li>
                  <span className="bg-blue-100 text-blue-800 px-3 py-1 rounded-full text-sm">
                    {user.username || user.email}
                  </span>
                </li>
              </>
            ) : (
              <li>
                <Link
                  href="/signin"
                  className="text-blue-500 hover:text-blue-700 font-bold"
                >
                  Logga in
                </Link>
              </li>
            )}
            <li>
              <Link
                href="http://localhost:3000/login"
                className="text-blue-500 hover:text-blue-700 font-bold"
              >
                Admin login
              </Link>
            </li>
          </ul>
        </div>
      )}
    </header>
  );
};

export default ClientHeader; 