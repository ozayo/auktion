"use client";

import {
  createContext,
  useContext,
  useState,
  ReactNode,
  
} from "react";

interface AuthContextProps {
  isLoggedIn: boolean;
  userEmail: string;
  
  userName: string | null; // Allow name to be optional
  logIn: (email: string, name?: string) => void; // Make name optional
  logOut: () => void;
}

const AuthContext = createContext<AuthContextProps | undefined>(undefined);

export const AuthProvider = ({ children }: { children: ReactNode }) => {
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [userEmail, setUserEmail] = useState("");
  const [userName, setUserName] = useState<string | null>(null); // Allow null for name

  const logIn = (email: string, name?: string) => {
    setIsLoggedIn(true);
    setUserEmail(email);
    setUserName(name || null); // Default to null if name is not provided
  };

  const logOut = () => {
    // Clear auth state
    setIsLoggedIn(false);
    setUserEmail("");
    setUserName(null);

    // Clear persistent cookie
    document.cookie =
      "userDocumentId=; path=/; expires=Thu, 01 Jan 1970 00:00:00 UTC;";
    console.log("Logged out: Cookie cleared");
  };


  return (
    <AuthContext.Provider value={{ isLoggedIn, userEmail, userName, logIn, logOut }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error("useAuth must be used within an AuthProvider");
  }
  return context;
};
