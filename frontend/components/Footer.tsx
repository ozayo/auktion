import Link from 'next/link';
import React from 'react';



const Footer: React.FC = () => {

  return (
    <div className='pt-5 pb-12 mt-20 border-t border-gray-200'>
      <div className='flex flex-col gap-3 items-center'>
        <p className='font-light text-sm'>© 2025, Bouvet</p>
        <div className='flex flex-row gap-3'>
          <Link className='font-light text-xs hover:text-blue-700' href="/">Hem</Link>
          <Link className='font-light text-xs hover:text-blue-700' href="/produkter">Produkter</Link>
          <Link className='font-light text-xs hover:text-blue-700' href="/om-project">Om project</Link>
          <Link className='font-light text-xs hover:text-blue-700' href="/my-page">Min Sida</Link>
          <Link className='font-light text-xs hover:text-blue-700' href="/my_page">Old Min Sida</Link>
          <Link className='font-light text-xs hover:text-blue-700' href="/login">Admin login</Link>
        </div>
      </div>
    </div>
  );
};

export default Footer;