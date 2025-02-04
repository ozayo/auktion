"use client"

import { useState } from "react";
import localFont from "next/font/local";
import "./globals.css";
import Header from "@/components/Header";
import { AuthProvider } from "@/contexts/AuthContext";
import { FavoritesProvider } from "@/contexts/FavoritesContext";
import AuthModals from "@/components/AuthModals";
import { CategoryProvider } from '@/contexts/CategoryContext';

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
      <head>
        <title>Bouvet Second Hand</title> 
        <meta name="description" content="Get a chance to win unused or old computers, phones, and other tech products through auctions or lottery! This sustainability-focused platform allows you to acquire valuable items while contributing to the environment." />
        {/* <meta name="description" content="Få chansen att vinna oanvända eller gamla datorer, telefoner och andra tekniska produkter genom auktioner eller lotteri! Denna hållbarhetsfokuserade plattform låter dig skaffa värdefulla föremål samtidigt som du bidrar till miljön." /> */}
      </head>
      <body className={`${geistSans.variable} ${geistMono.variable} antialiased`}>
        <AuthProvider>
          <FavoritesProvider openLoginModal={openLoginModal}>
            <CategoryProvider>
              <header>
                <div className="container mx-auto max-w-6xl px-4">
                  <Header /> 
                </div>
              </header>
              <main>
                <div className="container mx-auto max-w-6xl px-4">
                  {children}
                </div>
              </main>
              <AuthModals
                isLoginModalOpen={isLoginModalOpen}
                closeLoginModal={closeLoginModal}
                isSignUpModalOpen={isSignUpModalOpen}
                closeSignUpModal={closeSignUpModal}
                openSignUpModal={openSignUpModal}
              />
            </CategoryProvider>
          </FavoritesProvider>
        </AuthProvider>
      </body>
    </html>
  );
}
