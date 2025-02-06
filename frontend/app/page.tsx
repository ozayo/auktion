// /app/page.tsx

"use client";

import MainHero from "@/components/MainHero";
import ProductList from "@/components/ProductList";
import CategoryList from "@/components/CategoryList";
import Link from "next/link";

export default function HomePage() {
  return (
    <div className="container mx-auto">
      <MainHero />
      <CategoryList />
      <div className="py-4">
        {/* Senaste auktioner */}
        <ProductList
          productType="bidding"
          showItems={3}
          title="Senaste auktioner"
          sorting="custom"
          customSorting={['newfirst', 'timeshort']}
          showOld={false}
          gridClassName="grid grid-cols-1 md:grid-cols-3 gap-6"
        />
        
        {/* Manuella lotterier */}
        <ProductList
          productType="lotteryAuto"
          showItems={3}
          title="Senaste lotterier"
          sorting={true}
          showOld={false}
          gridClassName="grid grid-cols-1 md:grid-cols-3 gap-6"
        />

        <div className="grid grid-cols-3 gap-6 bg-blue-950 px-6 py-6 -mx-[10px] ">
          <div className="col-span-1 p-4">
            <h3 className="text-white font-bold text-2xl mb-3">Sepecial Lottery</h3>
            <p className="text-white pb-2">The winners of the lottery products below will be determined live at the special event.</p>
            <p className="text-white pb-2">The location and time of the event are specified in the product details.</p>
            <Link className="text-white font-bold border-white border py-2 px-6 rounded-full my-3 inline-block hover:bg-white hover:text-black" href="#">Mer info →</Link>
          </div>
          <div className="col-span-2">
            {/* Manuella lotterier */}
            <ProductList
              productType="lotteryManual"
              showItems={2}
              sorting={false}
              gridClassName="grid grid-cols-1 md:grid-cols-2 gap-6"/>
          </div>
        </div>
       </div>

    </div>
  );
}
