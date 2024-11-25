"use client";
import Link from "next/link";
import { useState } from "react";
import Image from "next/image";
import logoWhite from "../public/Bouvet_Logo_white.svg";
import logo from "../public/Bouvet_Logo_Colossus.svg";
import { FaGithub, FaBars, FaTimes } from "react-icons/fa";


const Header: React.FC = () => {
  const [isMobileNavOpen, setIsMobileNavOpen] = useState<boolean>(false);

  const toggleMobileNav = () => {
    setIsMobileNavOpen((prevState) => !prevState);
  };

  return (
    <header className="py-4 md:py-6 px-4 md:px-0">
      <div className="flex items-center">
        <div className="logo flex-none w-28">
          <Link href="/">
            <Image src={logoWhite} className="hidden dark:block" height={28} width={112} alt="Bouvet Logo"/>
            <Image src={logo} className="block dark:hidden" height={28} width={112} alt="Bouvet Logo"/>
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
            <li>
              <Link
                href="/"
                className="text-gray-800 dark:text-white hover:text-blue-500 dark:hover:text-blue-500 font-bold"
              >
                Link
              </Link>
            </li>
            <li>
              <Link
                href="/"
                className="text-gray-800 dark:text-white hover:text-blue-500 font-bold"
              >
                Link3
              </Link>
            </li>
            <li>
              <Link
                href="/contact"
                className="text-gray-800 dark:text-white hover:text-blue-500 font-bold"
              >
                Link4
              </Link>
            </li>
          </ul>
        </div>
        <div className="flex grow md:grow-0 justify-end gap-2 md:gap-1">
          <div className="textchangeflex-none w-24 md:flex justify-center">
           <Link href="http://localhost:1337/admin">Admin</Link>
          </div>
        </div>
        <div
          className="hamburger md:hidden flex w-10 justify-end"
          onClick={toggleMobileNav}
        >
          {isMobileNavOpen ? <FaTimes size="1.5em" /> : <FaBars size="1.5em" />}
        </div>
      </div>
      {/* Mobile menu start */}
      <div
        className={`${
          isMobileNavOpen
            ? "flex flex-col items-end mt-4 test md:hidden"
            : "hidden md:hidden"
        } justify-end`}
      >
        <ul className="md:flex gap-4">
          <li>
            <Link
              href="/"
              className="text-gray-800 dark:text-white hover:text-blue-500 font-bold"
            >
              Home
            </Link>
          </li>
          <li>
            <Link
              href="/"
              className="text-gray-800 dark:text-white hover:text-blue-500 dark:hover:text-blue-500 font-bold"
            >
              Link2
            </Link>
          </li>
          <li>
            <Link
              href="/"
              className="text-gray-800 dark:text-white hover:text-blue-500 font-bold"
            >
              Link3
            </Link>
          </li>
          <li>
            <Link
              href="/"
              className="text-gray-800 dark:text-white hover:text-blue-500 font-bold"
            >
              Link3
            </Link>
          </li>
        </ul>
      </div>
    </header>
  );
};

export default Header;
