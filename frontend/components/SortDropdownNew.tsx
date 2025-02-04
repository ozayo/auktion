"use client";

import { ProductSortingType } from '@/types';

interface SortDropdownNewProps {
  selectedOption: string;
  onSortChange: (value: string) => void;
  isLotteryOnly?: boolean;
  customOptions?: ProductSortingType[];
}

export default function SortDropdownNew({
  selectedOption,
  onSortChange,
  isLotteryOnly = false,
  customOptions
}: SortDropdownNewProps) {
  const defaultOptions = [
    { value: 'createdAt:desc', label: 'Nyast först', type: 'newfirst' },
    { value: 'createdAt:asc', label: 'Äldst först', type: 'oldfirst' },
    { value: 'ending_date:asc', label: 'Kortast tid kvar', type: 'timeshort' },
    { value: 'ending_date:desc', label: 'Längst tid kvar', type: 'timelong' }
  ];

  const biddingOptions = [
    { value: 'highestBid:desc', label: 'Högsta bud', type: 'highbid' },
    { value: 'highestBid:asc', label: 'Lägsta bud', type: 'lowbid' }
  ];

  let availableOptions = defaultOptions;

  // Eğer customOptions varsa, sadece belirtilen seçenekleri göster
  if (customOptions) {
    availableOptions = availableOptions.filter(option => 
      customOptions.includes(option.type as ProductSortingType)
    );
  }

  // Açık artırma ürünleri için ek seçenekler
  if (!isLotteryOnly && (!customOptions || customOptions.some(opt => ['highbid', 'lowbid'].includes(opt)))) {
    availableOptions = [...availableOptions, ...biddingOptions];
  }

  return (
    <div className="relative">
      <select
        value={selectedOption}
        onChange={(e) => onSortChange(e.target.value)}
        className="block appearance-none w-full bg-white border border-gray-300 text-gray-700 py-2 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
      >
        {availableOptions.map((option) => (
          <option key={option.value} value={option.value}>
            {option.label}
          </option>
        ))}
      </select>
      <div className="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
        <svg className="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
          <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/>
        </svg>
      </div>
    </div>
  );
}
