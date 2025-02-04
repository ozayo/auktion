"use client";

interface SortDropdownNewProps {
  selectedOption: string;
  onSortChange: (value: string) => void;
  isLotteryOnly: boolean;
}

export default function SortDropdownNew({ selectedOption, onSortChange, isLotteryOnly }: SortDropdownNewProps) {
  const handleSortChange = (value: string) => {
    onSortChange(value);
  };

  return (
    <div className="flex items-center gap-2">
      <label htmlFor="sort" className="text-gray-700">
        Sortera:
      </label>
      <select
        id="sort"
        value={selectedOption}
        onChange={(e) => handleSortChange(e.target.value)}
        className="border border-gray-300 rounded p-2"
      >
        <option value="createdAt:desc">Nyaste först</option>
        <option value="createdAt:asc">Äldsta först</option>
        <option value="ending_date:asc">Kortast tid kvar</option>
        <option value="ending_date:desc">Längst tid kvar</option>
        {/* This options are only shown in non-lottery products */}
        {!isLotteryOnly && (
          <>
            <option value="highestBid:desc">Högsta bud först</option>
            <option value="highestBid:asc">Lägsta bud först</option>
          </>
        )}
      </select>
    </div>
  );
}
