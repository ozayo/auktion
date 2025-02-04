import React from 'react';
import { useState } from "react";
import CategoryList from './CategoryList';


const MainHero: React.FC = () => {

const [categories, setCategories] = useState<any[]>([]);  

  return (
    <div className=' relative mt-4 mb-3 bg-right-bottom min-h-96 md:bg-cover bg-no-repeat p-2 md:p-0 bg-[url(/toppbilde.jpg)]'>
      <div className='box bg-[#f9ead4] p-4 md:p-8 md:w-2/5 w-full absolute md:left-5 md:bottom-5 bottom-0'>
        <h1 className='font-bold text-4xl mb-3'>Ansvarsfulla steg mot framtiden med Bouvet!</h1>
        <p className=' font-light'>Bouvet skapar ett hållbart ekosystem genom att erbjuda begagnad elektronik till sina anställda via auktioner eller utlottningar. Vi minskar avfall och främjar en grönare framtid.</p>
      </div>
      <div className='rightbox'>
        <CategoryList />
      </div>
    </div>
  );
};

export default MainHero;