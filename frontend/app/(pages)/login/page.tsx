'use client';

import { useEffect, useState } from 'react';

interface AdminData {
  id: number;
  documentId: string;
  firstname: string;
  lastname: string;
  username: string;
  email: string;
}

export default function LoginPage() {
  const [email, setEmail] = useState<string>('');
  const [password, setPassword] = useState<string>('');
  const [admin, setAdmin] = useState<AdminData | null>(null);

  useEffect(() => {
    const token = localStorage.getItem('strapi-admin-token');

    if (token) {

      // take user info from API
      fetch('/api/check-admin', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ token }),
      })
        .then((res) => res.json())
        .then((data) => {
          if (data.isAdmin) {
            setAdmin(data.user);
          }
        });
    }
  }, []);

  const handleLogin = async () => {
    try {
      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/admin/login`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          email,
          password,
        }),
      });

      const data: { data?: { token: string } } = await response.json();

      if (data.data?.token) {
        localStorage.setItem('strapi-admin-token', data.data.token);

        // take admin info and set to state
        const adminResponse = await fetch('/api/check-admin', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ token: data.data.token }),
        });

        const adminData = await adminResponse.json();
        if (adminData.isAdmin) {
          setAdmin(adminData.user);
        }
      } else {
        alert('Invalid credentials');
      }
    } catch (error) {
      alert('Login failed');
    }
  };

  const handleLogout = () => {
    localStorage.removeItem('strapi-admin-token');
    setAdmin(null);
    alert('Logged out successfully');
  };

  if (admin) {
    return (
      <div className='pt-8 pb-14'>
        <h1 className='text-3xl font-bold mb-4'>Admin Login</h1>
        <h2 className='text-xl mt-6 mb-8'>Hej admin <span className='font-semibold '>{admin.firstname} {admin.lastname}!</span></h2>
        <div className='flex flex-col gap-2 justify-start items-start'>
          <a className='text-black hover:text-blue-600 font-bold border border-gray-400 rounded-lg py-3 px-4 w-full mb-2' href='/lotteries'>
           
            Starta en ny lotteri  →
            <span className='font-normal block text-sm text-gray-500'>Du kan lista alla manuella lotteriprodukter och sedan starta en ny manuell lotteri.</span>
          
          </a>
          <a className='text-black hover:text-blue-600 font-bold border border-gray-400 rounded-lg py-3 px-4 w-full mb-2' href='/winners/lottery-winners'>
            Se alla lotterivinnare → 
            <span className='font-normal block text-sm text-gray-500'>Detta är arkivet för lotterivinnare; du kan se alla lotterivinnare från både automatiska och manuella lotterier</span>
          </a>
          <a className='text-black hover:text-blue-600 font-bold border border-gray-400 rounded-lg py-3 px-4 w-full mb-2'>
            Se alla budvinnare → 
            <span className='font-normal block text-sm text-gray-500'>Detta är arkivet för budvinnare; du kan se alla vinnare av auktionsprodukter här.</span>
          </a>
          <div className='flex flex-row gap-4 w-full mt-4'>
            <button className='text-black hover:text-blue-600 font-bold border border-gray-400 rounded-lg py-3 px-4 w-1/2 mb-2 text-left' onClick={handleLogout}>
              Admin logga ut → 
              <span className='font-normal block text-sm text-gray-500'>Logga ut från frontend som Admin.</span>
            </button>
            <a className='text-black hover:text-blue-600 font-bold border border-gray-400 rounded-lg py-3 px-4 w-1/2 mb-2' href={`${process.env.NEXT_PUBLIC_API_URL}/admin`} target="_blank" rel="noopener noreferrer">
              Gå till Strapi Dashboard ↗ 
              <span className='font-normal block text-sm text-gray-500'>Åtkomst till Strapi adminpanel.</span>
            </a>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className='flex flex-col gap-4'>
      <h1 className='text-3xl font-bold my-4'>Admin Login</h1>
      <input
        type="email"
        placeholder="Email"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        className='w-full py-2 px-3 border border-gray-400 rounded-md shadow-sm focus:outline-none focus:border-blue-500'
      />
      <input
        type="password"
        placeholder="Password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        className='w-full py-2 px-3 border border-gray-400 rounded-md shadow-sm focus:outline-none focus:border-blue-500'
      />
      <button className='bg-blue-500 text-white py-2 px-4 rounded-md shadow-sm hover:bg-blue-700 focus:outline-none focus:shadow-outline-blue active:bg-blue-800 transition duration-150 ease-in-out' onClick={handleLogin}>Login</button>
    </div>
  );
}
