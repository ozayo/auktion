import Link from 'next/link';
import React from 'react';
import { useState } from "react";



const MainHero: React.FC = () => {

const [categories, setCategories] = useState<any[]>([]);  

  return (
    <div className=' relative mt-4 mb-3 bg-right-bottom h-[450px] min-h-96 md:bg-cover bg-no-repeat p-2 md:p-0 bg-[url(/toppbilde.jpg)]'>
      <div className='flex flex-col gap-3 bg-[#f9ead4] p-4 md:p-8 md:w-2/5 w-full absolute md:left-5 md:bottom-5 bottom-0'>
        <h1 className='font-black text-3xl'>Ansvarsfulla steg mot framtiden med Bouvet!</h1>
        <p className='font-light'>Bouvet skapar ett hållbart ekosystem genom att erbjuda begagnad elektronik till sina anställda via auktioner eller utlottningar. Vi minskar avfall och främjar en grönare framtid.</p>
        <div className='flex flex-row gap-6'>
          <Link className='font-bold hover:text-blue-700' href="/produkter">See produkter →</Link>
          <Link className=' hover:text-blue-700' href="/om-project">Om project →</Link>
        </div>
      </div>
    </div>
  );
};

export default MainHero;