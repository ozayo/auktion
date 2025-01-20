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
      <div>
        <h1 className='text-3xl font-bold my-4'>Admin Login</h1>
        <h2 className='text-xl mt-6 mb-5'>Hello admin <span className='font-semibold '>{admin.firstname} {admin.lastname}</span></h2>
        <div className='flex flex-col gap-2 justify-start items-start'>
          <a className='text-blue-600 hover:text-blue-950' href='/lotteries'>Start lottery →</a>
          <a className='text-blue-600 hover:text-blue-950' href='/winners/lottery-winners'>See all lottery winners →</a>
           <a className='text-blue-600 hover:text-blue-950' href='/winners/bidding-winners'>See all bidding winners →</a>
          <button className='text-blue-600 hover:text-blue-950' onClick={handleLogout}>Logout →</button>
          <a className='text-blue-600 hover:text-blue-950' href={`${process.env.NEXT_PUBLIC_API_URL}/admin`} target="_blank" rel="noopener noreferrer">Go Strapi Admin →</a>
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
