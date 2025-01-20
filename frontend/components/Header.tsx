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
  const [isLogoutModalOpen, setIsLogoutModalOpen] = useState(false); // Consolidate state for Logout modal

  const { isLoggedIn } = useAuth();

  const toggleMobileNav = () => setIsMobileNavOpen(!isMobileNavOpen);
  const openLoginModal = () => setIsLoginModalOpen(true);
  const closeLoginModal = () => setIsLoginModalOpen(false);
  const openSignUpModal = () => {
    setIsLoginModalOpen(false);
    setIsSignUpModalOpen(true);
  };
  const closeSignUpModal = () => setIsSignUpModalOpen(false);
  const openLogoutModal = () => setIsLogoutModalOpen(true);
  const closeLogoutModal = () => setIsLogoutModalOpen(false);

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
        <div className="hidden md:flex grow justify-center gap-8">
          <Link
            href="/"
            className="text-gray-800 dark:text-white hover:text-blue-500 font-bold"
          >
            Home
          </Link>
          <Link
            href="/produkter"
            className="text-gray-800 dark:text-white hover:text-blue-500 font-bold"
          >Produkter
          </Link>
          {isLoggedIn ? (
            <>
              <Link
                href="/my_page"
                className="text-gray-800 dark:text-white hover:text-blue-500 font-bold"
              >
                Min sida
              </Link>
              <button
                onClick={openLogoutModal} // Directly open the logout modal
                className="text-red-500 hover:text-red-700 font-bold"
              >
                Logga ut
              </button>
            </>
          ) : (
            <button
              onClick={openLoginModal}
              className="text-blue-500 hover:text-blue-700 font-bold"
            >
              Logga in
            </button>
          )}
          <Link
            href="http://localhost:3000/login"
            className="text-blue-500 hover:text-blue-700 font-bold"
          >
            Admin login
          </Link>
        </div>

        {/* Hamburger menu for mobile navigation */}
        <div
          className="hamburger md:hidden flex w-10 justify-end"
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
            
            {isLoggedIn ? (
              <>
                <li>
                  <Link
                    href="/my_page"
                    className="text-gray-800 dark:text-white hover:text-blue-500 font-bold"
                  >
                    Min sida
                  </Link>
                </li>
                <li>
                  <button
                    onClick={openLogoutModal} // Directly open the logout modal
                    className="text-red-500 hover:text-red-700 font-bold"
                  >
                    Logga ut
                  </button>
                </li>
              </>
            ) : (
              <li>
                <button
                  onClick={openLoginModal}
                  className="text-blue-500 hover:text-blue-700 font-bold"
                >
                  Logga in
                </button>
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

      <AuthModals
        isLoginModalOpen={isLoginModalOpen}
        closeLoginModal={closeLoginModal}
        isSignUpModalOpen={isSignUpModalOpen}
        closeSignUpModal={closeSignUpModal}
        openSignUpModal={openSignUpModal}
        isLogoutModalOpen={isLogoutModalOpen} // Pass logout modal state
        closeLogoutModal={closeLogoutModal} // Pass logout modal close handler
      />
    </header>
  );
};

export default Header;
