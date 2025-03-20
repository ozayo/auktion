//components/ProductImage.tsx

import { useState, useEffect } from "react";
import Image from "next/image";
import { FiZoomIn, FiX } from "react-icons/fi";

interface ImageData {
  url: string;
  alternativeText?: string;
}

interface ProductImageProps {
  mainPicture: ImageData;
  gallery?: ImageData[];
}

const ProductImage: React.FC<ProductImageProps> = ({ mainPicture, gallery = [] }) => {
  const [selectedImage, setSelectedImage] = useState(mainPicture.url); // main image
  const [isModalOpen, setIsModalOpen] = useState(false); // Modal status

  const images = [mainPicture, ...gallery];

  // Event listener for close with Escape
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === "Escape" && isModalOpen) {
        setIsModalOpen(false);
      }
    };
    window.addEventListener("keydown", handleKeyDown);

    return () => {
      window.removeEventListener("keydown", handleKeyDown);
    };
  }, [isModalOpen]);

  return (
    <div className="flex flex-col gap-4">
      {/* Main */}
      <div className="relative w-full">
        {/* magnifying glass icon */}
        <div
          className="absolute top-2 right-2 bg-white text-black p-2 rounded-full shadow-md cursor-pointer z-10"
          onClick={() => setIsModalOpen(true)}
        >
          <FiZoomIn className="w-6 h-6" />
        </div>
        {/* Main product image */}
        <div
          className="cursor-pointer border border-gray-200 overflow-hidden"
          onClick={() => setIsModalOpen(true)}
        >
          <Image
            src={selectedImage}
            width={800}
            height={800}
            alt={mainPicture.alternativeText || "Main product image"}
            className="object-cover h-96 w-full p-1"
            priority
          />
        </div>
      </div>

      {/* Gallery Thumbnails */}
      {gallery.length > 0 && (
        <div className="grid grid-cols-4 md:grid-cols-6 gap-2">
          {images.map((image, index) => (
            <div
              key={index}
              className="w-full rounded-md border border-gray-200 cursor-pointer hover:opacity-80 overflow-hidden"
              onClick={() => setSelectedImage(image.url)}
            >
              <Image
                src={image.url}
                width={80}
                height={80}
                alt={image.alternativeText || "Gallery image"}
                className="object-cover w-full h-20"
              />
            </div>
          ))}
        </div>
      )}

      {/* Modal */}
      {isModalOpen && (
        <div
          className="fixed inset-0 bg-black bg-opacity-75 flex items-center justify-center z-50"
          onClick={() => setIsModalOpen(false)} // close modal when click outside of picture
        >
          <div
            className="relative w-auto max-w-full max-h-screen"
            onClick={(e) => e.stopPropagation()} // But dont close modal when click picture
          >
            <Image
              src={selectedImage}
              width={1200}
              height={800}
              alt="Expanded product"
              className="object-contain max-w-full max-h-screen"
            />
            {/* Close icon */}
            <button
              className="absolute top-4 right-4 bg-white text-black rounded-full p-2 z-10"
              onClick={() => setIsModalOpen(false)}
            >
              <FiX className="w-6 h-6" />
            </button>
          </div>
        </div>
      )}
    </div>
  );
};

export default ProductImage;
