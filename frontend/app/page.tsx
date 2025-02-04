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
      
      {/* Açık Artırma Ürünleri */}
      <ProductList
        productType="bidding"
        showItems={3}
        title="Senaste auktioner"
        sorting="custom"
        customSorting={['newfirst', 'timeshort']}
        showOld={false}
      />

      {/* Otomatik Çekiliş Ürünleri */}
      <ProductList
        productType="lotteryAuto"
        showItems={3}
        title="Automatiska lotterier"
        sorting={false}
        showOld={false}
      />

      {/* Manuel Çekiliş Ürünleri */}
      <ProductList
        productType="lotteryManual"
        showItems={1}
        title="Manuella lotterier"
        sorting={false}
        showOld={false}
      />
    </div>
  );
}
