"use client";

import { useState, useEffect } from "react";
import InputField from "./InputField";
import { API_URL } from "../lib/api";
import { useAuth } from "@/contexts/AuthContext";
import { useRouter } from "next/navigation";

interface AuthModalsProps {
  isLoginModalOpen: boolean;
  closeLoginModal: () => void;
  isSignUpModalOpen: boolean;
  closeSignUpModal: () => void;
  openSignUpModal: (email: string) => void;
  isLogoutModalOpen?: boolean; // New prop for logout modal state
  closeLogoutModal?: () => void; // New prop for closing logout modal
}

const AuthModals: React.FC<AuthModalsProps> = ({
  isLoginModalOpen,
  closeLoginModal,
  isSignUpModalOpen,
  closeSignUpModal,
  openSignUpModal,
  isLogoutModalOpen,
  closeLogoutModal,
}) => {
  const [localEmail, setLocalEmail] = useState<string>("");
  const [localName, setLocalName] = useState<string>("");
  const { logIn, logOut } = useAuth();
  const router = useRouter();

  // Utility function to set a persistent cookie
  const setPersistentLogin = (documentId: string) => {
    document.cookie = `userDocumentId=${documentId}; path=/; max-age=${
      30 * 24 * 60 * 60
    };`; // 30 days
    console.log(`Cookie set: userDocumentId=${documentId}`);
  };

  // Utility function to get a cookie value by name
  const getCookie = (name: string): string | null => {
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length === 2) return parts.pop()?.split(";").shift() || null;
    return null;
  };

  // Restore user session on page load
  useEffect(() => {
    const restoreSession = async () => {
      const documentId = getCookie("userDocumentId");
      if (documentId) {
        try {
          const query = `filters[documentId][$eq]=${documentId}`;
          const response = await fetch(`${API_URL}/api/bidusers?${query}`);
          if (!response.ok) throw new Error("Failed to fetch user details");

          const data = await response.json();
          if (data.data.length > 0) {
            const user = data.data[0];
            logIn(user.email, user.Name); // Restore user session
            console.log("User session restored:", user);
          } else {
            console.log("User not found. Invalid cookie.");
          }
        } catch (error) {
          console.error("Error restoring user session:", error);
        }
      }
    };

    restoreSession();
  }, [logIn]);

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
        const documentId = data.data[0].documentId; // Retrieve documentId
        setPersistentLogin(documentId); // Store documentId in cookie
        logIn(localEmail); // Log in using the email or other method
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

      const createdUser = await createResponse.json();
      const documentId = createdUser.data.documentId; // Retrieve documentId
      setPersistentLogin(documentId); // Store documentId in cookie
      logIn(localEmail, localName);
      closeSignUpModal();
      alert("Kontot skapades framgångsrikt!");
    } catch (error) {
      console.error("Sign-up error:", error);
      alert("Ett fel uppstod vid skapandet av kontot.");
    }
  };

  const handleLogout = () => {
    if (logOut) logOut(); // Perform logout if logOut is available
    if (closeLogoutModal) closeLogoutModal(); // Close the modal if the handler is available
    router.push("/");
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
      {isLogoutModalOpen && closeLogoutModal && (
        <div className="fixed inset-0 bg-gray-800 bg-opacity-50 flex justify-center items-center z-50">
          <div className="bg-white p-6 rounded-md shadow-md w-96">
            <h2 className="text-xl font-bold mb-4">
              Är du säker på att du vill logga ut?
            </h2>
            <div className="flex justify-end gap-2">
              <button
                onClick={closeLogoutModal}
                className="px-4 py-2 bg-gray-300 hover:bg-gray-400 rounded"
              >
                Avbryt
              </button>
              <button
                onClick={handleLogout}
                className="px-4 py-2 bg-red-500 text-white hover:bg-red-600 rounded"
              >
                Ja
              </button>
            </div>
          </div>
        </div>
      )}
    </>
  );
};

export default AuthModals;
