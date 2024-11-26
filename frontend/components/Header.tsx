"use client";

import Link from "next/link";
import Image from "next/image";
import { FaBars, FaTimes } from "react-icons/fa";
import AuthModals from "./AuthModals";
import logoWhite from "../public/Bouvet_Logo_white.svg";
import logo from "../public/Bouvet_Logo_Colossus.svg";
import { useState } from "react";
import { useAuth } from "@/contexts/AuthContext";

const Header: React.FC = () => {
  const [isMobileNavOpen, setIsMobileNavOpen] = useState(false);
  const [isLoginModalOpen, setIsLoginModalOpen] = useState(false);
  const [isSignUpModalOpen, setIsSignUpModalOpen] = useState(false);

  const { isLoggedIn } = useAuth();

  const toggleMobileNav = () => setIsMobileNavOpen(!isMobileNavOpen);
  const openLoginModal = () => setIsLoginModalOpen(true);
  const closeLoginModal = () => setIsLoginModalOpen(false);
  const openSignUpModal = (email: string) => {
    setIsLoginModalOpen(false);
    setIsSignUpModalOpen(true);
  };
  const closeSignUpModal = () => setIsSignUpModalOpen(false);

  return (
    <header className="py-4 md:py-6 px-4 md:px-0">
      <div className="flex items-center">
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
        <div className="desknav grow hidden md:inline-block">
          <ul className="flex justify-center gap-5">
            <li>
              <Link
                href="/"
                className="text-gray-800 dark:text-white hover:text-blue-500 font-bold"
              >
                Home
              </Link>
            </li>
          </ul>
        </div>
        <div className="flex grow md:grow-0 justify-end gap-2 md:gap-1">
          <div className="flex-none w-24 md:flex justify-center">
            {isLoggedIn ? (
              <span className="text-gray-800 dark:text-white font-bold">
                Min sida
              </span>
            ) : (
              <button
                onClick={openLoginModal}
                className="text-blue-500 hover:text-blue-700 font-bold"
              >
                Logga in
              </button>
            )}
          </div>
        </div>
        <div
          className="hamburger md:hidden flex w-10 justify-end"
          onClick={toggleMobileNav}
        >
          {isMobileNavOpen ? <FaTimes size="1.5em" /> : <FaBars size="1.5em" />}
        </div>
      </div>
      <AuthModals
        isLoginModalOpen={isLoginModalOpen}
        closeLoginModal={closeLoginModal}
        isSignUpModalOpen={isSignUpModalOpen}
        closeSignUpModal={closeSignUpModal}
        openSignUpModal={openSignUpModal}
      />
    </header>
  );
};

export default Header;
