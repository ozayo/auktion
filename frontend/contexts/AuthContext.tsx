"use client";

import { createContext, useContext, useState, ReactNode } from "react";

interface AuthContextProps {
  isLoggedIn: boolean;
  userEmail: string;
  userName: string | null; // Allow name to be optional
  logIn: (email: string, name?: string) => void; // Make name optional
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

  return (
    <AuthContext.Provider value={{ isLoggedIn, userEmail, userName, logIn }}>
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
