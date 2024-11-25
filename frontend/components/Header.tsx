"use client";
import Link from "next/link";
import { useState } from "react";
import Image from "next/image";
import logoWhite from "../public/Bouvet_Logo_white.svg";
import logo from "../public/Bouvet_Logo_Colossus.svg";
import { FaBars, FaTimes } from "react-icons/fa";
import { API_URL } from "../lib/api";
import { useAuth } from "@/contexts/AuthContext"; 

const Header: React.FC = () => {
  const [isMobileNavOpen, setIsMobileNavOpen] = useState<boolean>(false);
  const [isLoginModalOpen, setIsLoginModalOpen] = useState<boolean>(false);
  const [isSignUpModalOpen, setIsSignUpModalOpen] = useState<boolean>(false);
  const [localEmail, setLocalEmail] = useState<string>("");
  const [localName, setLocalName] = useState<string>("");

  const { isLoggedIn, logIn } = useAuth(); // Use context

  

  const toggleMobileNav = () => {
    setIsMobileNavOpen((prevState) => !prevState);
  };

  const openLoginModal = () => {
    setIsLoginModalOpen(true);
  };

  const closeLoginModal = () => {
    setIsLoginModalOpen(false);
  };

  const openSignUpModal = () => {
    setIsLoginModalOpen(false); // Close login modal
    setIsSignUpModalOpen(true);
  };

  const closeSignUpModal = () => {
    setIsSignUpModalOpen(false);
  };

  const handleLogin = async () => {
    if (localEmail && localName) {
      try {
        // Use Strapi filters to query by email and name
        const query = `filters[email][$eq]=${encodeURIComponent(
          localEmail
        )}&filters[Name][$eq]=${encodeURIComponent(localName)}`;
        const response = await fetch(`${API_URL}/api/bidusers?${query}`);
        if (!response.ok) {
          throw new Error("Failed to fetch bidusers");
        }

        const data = await response.json();

        if (data.data.length > 0) {
          console.log("User found:", data.data[0]);
          logIn(localEmail, localName); // Update context state
          closeLoginModal();
          alert("Successfully logged in!");
        } else {
          alert("Invalid email or name. Please try again.");
          setLocalEmail("");
          setLocalName("");
        }
      } catch (error) {
        console.error("Error logging in:", error);
        alert(
          "An error occurred while trying to log in. Please try again later."
        );
      }
    } else {
      alert("Please fill in all fields.");
    }
  };


 const handleSignUp = async () => {
   if (localEmail && localName) {
     try {
       // Step 1: Check if the email already exists in the database
       const query = `filters[email][$eq]=${encodeURIComponent(localEmail)}`;
       const checkResponse = await fetch(`${API_URL}/api/bidusers?${query}`);

       if (!checkResponse.ok) {
         throw new Error("Failed to check existing accounts");
       }

       const checkData = await checkResponse.json();

       if (checkData.data.length > 0) {
         // Email already exists
         alert("This email is already registered.");
         setLocalEmail("");
         setLocalName("");
         return;
       }

       // Step 2: Create a new account
       const payload = {
         data: {
           Name: localName,
           email: localEmail,
           active: true,
           bids: [],
         },
       };

       console.log("Sending payload:", payload);

       const response = await fetch(`${API_URL}/api/bidusers`, {
         method: "POST",
         headers: {
           "Content-Type": "application/json",
         },
         body: JSON.stringify(payload),
       });

       if (!response.ok) {
         const errorData = await response.json();
         console.error("API Error Details:", errorData);
         throw new Error("Failed to create account");
       }

       const responseData = await response.json();
       console.log("API Response:", responseData);

       logIn(localEmail, localName); // Automatically log in the user
       closeSignUpModal();
       alert("Account created successfully!");
     } catch (error) {
       console.error("Error creating account:", error);
       alert("Failed to create account. Please check your input.");
     }
   } else {
     alert("Please fill in all fields.");
   }
 };


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
            {/* Add other navigation links as needed */}
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
          {/* Add other mobile navigation links as needed */}
        </ul>
      </div>

      {/* Modal for login */}
      {isLoginModalOpen && (
        <div className="fixed inset-0 bg-gray-800 bg-opacity-50 flex justify-center items-center z-50">
          <div className="bg-white p-6 rounded-md shadow-md w-96">
            <h2 className="text-xl font-bold mb-4">Logga in</h2>
            <input
              type="email"
              placeholder="Email"
              value={localEmail}
              onChange={(e) => setLocalEmail(e.target.value)}
              className="border p-2 mb-2 w-full"
            />
            <input
              type="text"
              placeholder="Namn"
              value={localName}
              onChange={(e) => setLocalName(e.target.value)}
              className="border p-2 mb-4 w-full"
            />
            <div className="flex justify-end gap-2">
              <button
                onClick={closeLoginModal}
                className="px-4 py-2 bg-gray-300 hover:bg-gray-400 rounded"
              >
                Avbryt
              </button>
              <button
                onClick={openSignUpModal}
                className="px-4 py-2 bg-green-500 text-white hover:bg-green-600 rounded"
              >
                Skapa konto
              </button>
              <button
                onClick={handleLogin}
                className="px-4 py-2 bg-blue-500 text-white hover:bg-blue-600 rounded"
              >
                Logga in
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Modal for sign up */}
      {isSignUpModalOpen && (
        <div className="fixed inset-0 bg-gray-800 bg-opacity-50 flex justify-center items-center z-50">
          <div className="bg-white p-6 rounded-md shadow-md w-96">
            <h2 className="text-xl font-bold mb-4">Skapa konto</h2>
            <input
              type="email"
              placeholder="Email"
              value={localEmail}
              onChange={(e) => setLocalEmail(e.target.value)}
              className="border p-2 mb-2 w-full"
            />
            <input
              type="text"
              placeholder="Namn"
              value={localName}
              onChange={(e) => setLocalName(e.target.value)}
              className="border p-2 mb-4 w-full"
            />
            <div className="flex justify-end gap-2">
              <button
                onClick={closeSignUpModal}
                className="px-4 py-2 bg-gray-300 hover:bg-gray-400 rounded"
              >
                Avbryt
              </button>
              <button
                onClick={handleSignUp}
                className="px-4 py-2 bg-blue-500 text-white hover:bg-blue-600 rounded"
              >
                Skapa konto
              </button>
            </div>
          </div>
        </div>
      )}
    </header>
  );
};

export default Header;
