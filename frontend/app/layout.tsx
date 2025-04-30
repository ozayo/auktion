import localFont from "next/font/local";
import "./globals.css";
import Header from "@/components/Header";
import Footer from "@/components/Footer";
import { Inter } from 'next/font/google'
import ClientProviders from "@/components/ClientProviders";
import { getUserMeLoader } from "@/app/data/services/get-user-me-loader";

// const geistSans = localFont({
//   src: "./fonts/GeistVF.woff",
//   variable: "--font-geist-sans",
//   weight: "100 900",
// });
// const geistMono = localFont({
//   src: "./fonts/GeistMonoVF.woff",
//   variable: "--font-geist-mono",
//   weight: "100 900",
// });
const inter = Inter({
  subsets: ['latin'],
  display: 'swap',
  variable: '--font-inter',
})


export default async function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  // Server-side'da kullanıcı bilgilerini al
  const initialUser = await getUserMeLoader();

  return (
    <html lang="en" className={`${inter.variable}`}>
      <head>
        <title>Bouvet Second Hand</title> 
        <meta name="description" content="Get a chance to win unused or old computers, phones, and other tech products through auctions or lottery! This sustainability-focused platform allows you to acquire valuable items while contributing to the environment." />
        {/* <meta name="description" content="Få chansen att vinna oanvända eller gamla datorer, telefoner och andra tekniska produkter genom auktioner eller lotteri! Denna hållbarhetsfokuserade plattform låter dig skaffa värdefulla föremål samtidigt som du bidrar till miljön." /> */}
      </head>
      {/* <body className={`${geistSans.variable} ${geistMono.variable} antialiased`}> */}
      <body>
        <ClientProviders initialUser={initialUser}>
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
          <footer className="container mx-auto max-w-6xl px-4">
            <Footer />
          </footer>
        </ClientProviders>
      </body>
    </html>
  );
}
