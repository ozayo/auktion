import { useFavorites } from "@/contexts/FavoritesContext";
import { FaHeart } from "react-icons/fa";

const SaveToFavoritesButton = ({
  productId,
  onFavoriteChange,
  withText = false, // Optional prop to toggle the text-based button
}: {
  productId: number;
  onFavoriteChange?: () => void; // Callback for when favorites change
  withText?: boolean; // Toggle for showing text instead of a heart initially
}) => {
  const { addFavorite, removeFavorite, isFavorite } = useFavorites();

  const handleClick = () => {
    if (isFavorite(productId)) {
      removeFavorite(productId);
      onFavoriteChange?.(); // Trigger callback after removing favorite
    } else {
      addFavorite(productId);
      onFavoriteChange?.(); // Trigger callback after adding favorite
    }
  };

  const isFavorited = isFavorite(productId);

  return (
    <button
      onClick={handleClick}
      className="relative flex items-center justify-center p-2 focus:outline-none"
    >
      {withText && !isFavorited ? (
        <div className="flex flex-row gap-1">
          <span className="text-gray-700 font-medium">
            Lägg till i favoriter
          </span>
          <FaHeart
            size={24}
            className="relative z-10 transition-colors duration-300 
              text-gray-400"
          />
        </div>
      ) : (
        <>
          {/* Larger Heart Background */}
          <FaHeart
            size={28}
            className="absolute text-white"
            style={{ zIndex: 0 }}
          />
          {/* Smaller Foreground Heart */}
          <FaHeart
            size={24}
            className={`relative z-10 transition-colors duration-300 ${
              isFavorited ? "text-red-500" : "text-gray-400"
            }`}
          />
        </>
      )}
    </button>
  );
};

export default SaveToFavoritesButton;
