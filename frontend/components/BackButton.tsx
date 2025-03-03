'use client';

import { useRouter } from 'next/navigation';

export default function BackButton() {
  const router = useRouter();
  
  return (
    <a 
      className='border border-gray-500 py-1 px-5 content-center rounded hover:bg-black hover:text-white' 
      onClick={() => router.back()}
      style={{ cursor: 'pointer' }}
    >
      ← gå tillbaka
    </a>
  );
} 