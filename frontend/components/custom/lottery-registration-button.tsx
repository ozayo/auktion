"use client";

import React, { useState } from "react";
import { useAuth } from "@/contexts/AuthContext";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";

interface LotteryRegistrationButtonProps {
  productId: number | string;
  isRegistered: boolean;
  loading?: boolean;
  setLoading?: (loading: boolean) => void;
}

const LotteryRegistrationButton: React.FC<LotteryRegistrationButtonProps> = ({
  productId,
  isRegistered,
  loading,
  setLoading,
}) => {
  const { isAuthenticated } = useAuth();
  const router = useRouter();
  const [internalLoading, setInternalLoading] = useState(false);
  
  // Use provided loading state or internal state
  const buttonLoading = loading !== undefined ? loading : internalLoading;
  const setButtonLoading = setLoading || setInternalLoading;

  const handleRegistration = async () => {
    if (!isAuthenticated) {
      router.push("/login");
      return;
    }

    if (buttonLoading) return;

    setButtonLoading(true);
    try {
      const response = await fetch("/api/lottery-register", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ productId }),
      });

      const data = await response.json();

      if (data.ok) {
        // Force a refresh to update the UI
        router.refresh();
      } else {
        console.error("Registration failed:", data.error);
        alert("Kunde inte registrera: " + data.error);
      }
    } catch (error) {
      console.error("Error during registration:", error);
      alert("Ett fel inträffade vid registrering.");
    } finally {
      setButtonLoading(false);
    }
  };

  return (
    <Button
      onClick={handleRegistration}
      disabled={buttonLoading || isRegistered}
      variant={isRegistered ? "secondary" : "default"}
      className={`w-full ${isRegistered ? "bg-green-100 text-green-800 hover:bg-green-100" : ""}`}
    >
      {buttonLoading ? (
        <div className="flex items-center justify-center">
          <div className="w-5 h-5 border-t-2 border-b-2 border-current rounded-full animate-spin mr-2"></div>
          Laddar...
        </div>
      ) : isRegistered ? (
        "Du är registrerad"
      ) : (
        "Registrera i lotteri"
      )}
    </Button>
  );
};

export default LotteryRegistrationButton; 