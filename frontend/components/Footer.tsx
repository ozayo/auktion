import Link from 'next/link';
import React from 'react';



const Footer: React.FC = () => {

  return (
    <div className='pt-5 pb-12 mt-20 border-t border-gray-200'>
      <div className='flex flex-col gap-3 items-center'>
        <p className='font-light text-sm'>© 2025, Bouvet</p>
        <div className='items-center'>
          <Link className='font-light text-xs hover:text-blue-700 mr-1 py-1 px-2 inline-block' href="/">Hem</Link>
          <Link className='font-light text-xs hover:text-blue-700 mr-1 py-1 px-2 inline-block' href="/produkter">Produkter</Link>
          <Link className='font-light text-xs hover:text-blue-700 mr-1 py-1 px-2 inline-block ' href="/om-project">Om project</Link>
          <Link className='font-light text-xs hover:text-blue-700 mr-1 py-1 px-2 inline-block ' href="/my-page">Min Sida</Link>
          <Link className='font-light text-xs hover:text-blue-700 mr-1 py-1 px-2 inline-block ' href="/my_page">Old Min Sida</Link>
          <Link className='font-light text-xs hover:text-blue-700 mr-1 py-1 px-2 inline-block ' href="/login">Admin login</Link>
        </div>
      </div>
    </div>
  );
};

export default Footer;