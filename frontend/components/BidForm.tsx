"use client";

import { useState } from "react";
import { fetchAPI } from "../lib/api";
import { useAuth } from "@/contexts/AuthContext";

interface BidFormProps {
  productId: string;
}

export default function BidForm({ productId }: BidFormProps) {
  const [amount, setAmount] = useState("");
  const [message, setMessage] = useState("");
  const [localEmail, setLocalEmail] = useState(""); // Local state for email
  const [localName, setLocalName] = useState(""); // Local state for name

  const { isLoggedIn, userEmail, userName, logIn } = useAuth(); // Use context

  const handleLogin = async () => {
    if (!localEmail || !localName) {
      setMessage("Vänligen fyll i både namn och e-postadress.");
      return;
    }

    try {
      // Fetch user by email and name
      const query = `filters[email][$eq]=${encodeURIComponent(
        localEmail
      )}&filters[Name][$eq]=${encodeURIComponent(localName)}`;
      const response = await fetchAPI(`/bidusers?${query}`);

      if (response.data.length > 0) {
        // User exists
        logIn(localEmail, localName); // Update global state
        setMessage("Inloggad!");
      } else {
        setMessage("Kunde inte hitta användaren. Kontrollera dina uppgifter.");
      }
    } catch (error) {
      console.error("Login error:", error);
      setMessage("Ett fel uppstod vid inloggningen. Försök igen.");
    }
  };

  const handleBid = async () => {
    if (!isLoggedIn) {
      setMessage("Du måste logga in för att bjuda.");
      return;
    }

    try {
      let biduserId;

      // Fetch user by email
      const bidusersData = await fetchAPI(
        `/bidusers?filters[email][$eq]=${encodeURIComponent(userEmail)}`
      );
      if (bidusersData.data.length > 0) {
        // User exists
        biduserId = bidusersData.data[0].id;
      } else {
        // Create new user
        const newUser = await fetchAPI("/bidusers", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            data: {
              email: userEmail,
              Name: userName,
            },
          }),
        });
        biduserId = newUser.data.id;
      }

      // Create a new bid
      await fetchAPI("/bids", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          data: {
            Amount: parseFloat(amount),
            biduser: biduserId,
            product: parseInt(productId, 10),
          },
        }),
      });

      setMessage("Ditt bud har registrerats!");
      setAmount("");
    } catch (error) {
      console.error(error);
      setMessage("Ett fel har uppstått.");
    }
  };

  return (
    <div className="mt-8">
      <h2 className="text-xl font-semibold">Lägg ett bud</h2>
      {!isLoggedIn ? (
        <div>
          <p>Logga in för att bjuda:</p>
          <input
            type="email"
            placeholder="Email"
            value={localEmail} // Bind to localEmail
            onChange={(e) => setLocalEmail(e.target.value)} // Update localEmail
            className="border p-2 mr-2"
          />
          <input
            type="text"
            placeholder="Namn"
            value={localName} // Bind to localName
            onChange={(e) => setLocalName(e.target.value)} // Update localName
            className="border p-2 mr-2"
          />
          <button
            onClick={handleLogin}
            className="bg-blue-500 text-white px-4 py-2"
          >
            Börja
          </button>
        </div>
      ) : (
        <div>
          <p>Budbelopp:</p>
          <input
            type="number"
            placeholder="Budbelopp:"
            value={amount}
            onChange={(e) => setAmount(e.target.value)}
            className="border p-2 mr-2"
          />
          <button
            onClick={handleBid}
            className="bg-green-500 text-white px-4 py-2"
          >
            Lägg ett bud
          </button>
        </div>
      )}
      {message && <p className="mt-2">{message}</p>}
    </div>
  );
}
