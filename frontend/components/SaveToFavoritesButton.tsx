import { useFavorites } from "@/contexts/FavoritesContext";
import { FaHeart } from "react-icons/fa";

const SaveToFavoritesButton = ({ productId }: { productId: number }) => {
  const { addFavorite, removeFavorite, isFavorite } = useFavorites();

  const handleClick = () => {
    if (isFavorite(productId)) {
      removeFavorite(productId);
    } else {
      addFavorite(productId);
    }
  };

  return (
    <button
      onClick={handleClick}
      className="relative flex items-center justify-center p-2 focus:outline-none"
    >
      {/* Outer Heart for Border */}
      <FaHeart
        size={28} // Slightly larger heart for the border
        className="absolute text-white"
        style={{
          zIndex: 0,
        }}
      />
      {/* Inner Heart */}
      <FaHeart
        size={24} // Slightly smaller heart for the filled shape
        className={`relative z-10 transition-colors duration-300 ${
          isFavorite(productId) ? "text-red-500" : "text-gray-400"
        }`}
      />
    </button>
  );
};

export default SaveToFavoritesButton;
