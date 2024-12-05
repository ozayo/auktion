"use client"

import { useState } from "react";
import localFont from "next/font/local";
import "./globals.css";
import Header from "@/components/Header";
import { AuthProvider } from "@/contexts/AuthContext";
import { FavoritesProvider } from "@/contexts/FavoritesContext";
import AuthModals from "@/components/AuthModals";

const geistSans = localFont({
  src: "./fonts/GeistVF.woff",
  variable: "--font-geist-sans",
  weight: "100 900",
});
const geistMono = localFont({
  src: "./fonts/GeistMonoVF.woff",
  variable: "--font-geist-mono",
  weight: "100 900",
});



export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  // State and handlers for the login modal
  const [isLoginModalOpen, setLoginModalOpen] = useState(false);
  const [isSignUpModalOpen, setSignUpModalOpen] = useState(false);

  const openLoginModal = () => setLoginModalOpen(true);
  const closeLoginModal = () => setLoginModalOpen(false);

  const openSignUpModal = () => setSignUpModalOpen(true);
  const closeSignUpModal = () => setSignUpModalOpen(false);

  return (
    <html lang="en">
      <body
        className={`${geistSans.variable} ${geistMono.variable} antialiased`}
      >
        <AuthProvider>
          {/* Pass the login modal handler to the FavoritesProvider */}
          <FavoritesProvider openLoginModal={openLoginModal}>
            <main className="container mx-auto max-w-5xl px-3">
              <Header />
              {children}
            </main>
            {/* Include the AuthModals for login/signup functionality */}
            <AuthModals
              isLoginModalOpen={isLoginModalOpen}
              closeLoginModal={closeLoginModal}
              isSignUpModalOpen={isSignUpModalOpen}
              closeSignUpModal={closeSignUpModal}
              openSignUpModal={openSignUpModal}
            />
          </FavoritesProvider>
        </AuthProvider>
      </body>
    </html>
  );
}
