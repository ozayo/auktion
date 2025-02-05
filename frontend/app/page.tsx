// /app/page.tsx

"use client";

import MainHero from "@/components/MainHero";
import ProductList from "@/components/ProductList";
import CategoryList from "@/components/CategoryList";

export default function HomePage() {
  return (
    <div className="container mx-auto">
      <MainHero />
      <CategoryList />
      
      {/* Senaste auktioner */}
      <ProductList
        productType="bidding"
        showItems={3}
        title="Senaste auktioner"
        sorting="custom"
        customSorting={['newfirst', 'timeshort']}
        showOld={false}
      />
      
      {/* Manuella lotterier */}
      <ProductList
        productType="lottery"
        showItems={3}
        title="Alla lotterier"
        sorting={true}
        showOld={false}
      />

      {/* Automatiska lotterier */}
      <ProductList
        productType="lotteryAuto"
        showItems={3}
        title="Automatiska lotterier"
        sorting={false}
        showOld={false}
      />

      {/* Manuella lotterier */}
      <ProductList
        productType="lotteryManual"
        showItems={1}
        title="Manuella lotterier"
        sorting={false}
        showOld={false}
      />

      <ProductList
        productType="bidding"
        showItems={3}
        title="Dator Auktioner"
        sorting="custom"
        customSorting={['newfirst', 'timeshort']}
        showOld={false}
        category="dator"  // slug of category
      />

    </div>
  );
}
