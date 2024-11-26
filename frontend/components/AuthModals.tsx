"use client";

import { useState } from "react";
import InputField from "./InputField";
import { API_URL } from "../lib/api";
import { useAuth } from "@/contexts/AuthContext";

interface AuthModalsProps {
  isLoginModalOpen: boolean;
  closeLoginModal: () => void;
  isSignUpModalOpen: boolean;
  closeSignUpModal: () => void;
  openSignUpModal: (email: string) => void;
}

const AuthModals: React.FC<AuthModalsProps> = ({
  isLoginModalOpen,
  closeLoginModal,
  isSignUpModalOpen,
  closeSignUpModal,
  openSignUpModal,
}) => {
  const [localEmail, setLocalEmail] = useState<string>("");
  const [localName, setLocalName] = useState<string>("");
  const { logIn } = useAuth();

  const handleLogin = async () => {
    if (!localEmail) {
      alert("Vänligen fyll i e-postadress.");
      return;
    }

    try {
      const query = `filters[email][$eq]=${encodeURIComponent(localEmail)}`;
      const response = await fetch(`${API_URL}/api/bidusers?${query}`);
      if (!response.ok) throw new Error("Failed to fetch users");

      const data = await response.json();

      if (data.data.length > 0) {
        logIn(localEmail);
        closeLoginModal();
        alert("Inloggad!");
      } else {
        alert("Email not found. Skapa konto istället.");
        openSignUpModal(localEmail);
      }
    } catch (error) {
      console.error("Login error:", error);
      alert("Ett fel uppstod vid inloggningen. Försök igen.");
    }
  };

  const handleSignUp = async () => {
    if (!localEmail || !localName) {
      alert("Vänligen fyll i alla fält.");
      return;
    }

    try {
      const query = `filters[email][$eq]=${encodeURIComponent(localEmail)}`;
      const checkResponse = await fetch(`${API_URL}/api/bidusers?${query}`);
      if (!checkResponse.ok)
        throw new Error("Failed to check existing accounts");

      const checkData = await checkResponse.json();

      if (checkData.data.length > 0) {
        alert("Denna e-postadress är redan registrerad.");
        return;
      }

      const payload = {
        data: {
          Name: localName,
          email: localEmail,
          active: true,
          bids: [],
        },
      };

      const createResponse = await fetch(`${API_URL}/api/bidusers`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
      });

      if (!createResponse.ok) throw new Error("Failed to create account");

      logIn(localEmail, localName);
      closeSignUpModal();
      alert("Kontot skapades framgångsrikt!");
    } catch (error) {
      console.error("Sign-up error:", error);
      alert("Ett fel uppstod vid skapandet av kontot.");
    }
  };

  return (
    <>
      {isLoginModalOpen && (
        <div className="fixed inset-0 bg-gray-800 bg-opacity-50 flex justify-center items-center z-50">
          <div className="bg-white p-6 rounded-md shadow-md w-96">
            <h2 className="text-xl font-bold mb-4">Logga in</h2>
            <InputField
              type="email"
              placeholder="Email"
              value={localEmail}
              onChange={(e) => setLocalEmail(e.target.value)}
            />
            <div className="flex justify-end gap-2">
              <button
                onClick={closeLoginModal}
                className="px-4 py-2 bg-gray-300 hover:bg-gray-400 rounded"
              >
                Avbryt
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
      {isSignUpModalOpen && (
        <div className="fixed inset-0 bg-gray-800 bg-opacity-50 flex justify-center items-center z-50">
          <div className="bg-white p-6 rounded-md shadow-md w-96">
            <h2 className="text-xl font-bold mb-4">Skapa konto</h2>
            <InputField
              type="email"
              placeholder="Email"
              value={localEmail}
              onChange={(e) => setLocalEmail(e.target.value)}
            />
            <InputField
              type="text"
              placeholder="Namn"
              value={localName}
              onChange={(e) => setLocalName(e.target.value)}
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
    </>
  );
};

export default AuthModals;
