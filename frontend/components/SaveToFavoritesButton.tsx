import { useFavorites } from "@/contexts/FavoritesContext";
import { FaHeart } from "react-icons/fa";

const SaveToFavoritesButton = ({
  productId,
  onFavoriteChange,
}: {
  productId: number;
  onFavoriteChange?: () => void; // Callback for when favorites change
}) => {
  const { addFavorite, removeFavorite, isFavorite } = useFavorites();

  const handleClick = () => {
    if (isFavorite(productId)) {
      removeFavorite(productId);
      onFavoriteChange?.(); // Trigger callback after removing favorite
    } else {
      addFavorite(productId);
    }
  };

  return (
    <button
      onClick={handleClick}
      className="relative flex items-center justify-center p-2 focus:outline-none"
    >
      <FaHeart
        size={28}
        className="absolute text-white"
        style={{ zIndex: 0 }}
      />
      <FaHeart
        size={24}
        className={`relative z-10 transition-colors duration-300 ${
          isFavorite(productId) ? "text-red-500" : "text-gray-400"
        }`}
      />
    </button>
  );
};

export default SaveToFavoritesButton;
