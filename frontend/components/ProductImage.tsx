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
  const [selectedImage, setSelectedImage] = useState(mainPicture.url); // Ana görsel
  const [isModalOpen, setIsModalOpen] = useState(false); // Modal durumu

  const images = [mainPicture, ...gallery];

  // Escape tuşu ile modalı kapatmak için event listener
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
    <div className="flex flex-col">
      {/* Ana Görsel */}
      <div className="relative w-full">
        {/* Büyüteç İkonu */}
        <div
          className="absolute top-2 right-2 bg-white text-black p-2 rounded-full shadow-md cursor-pointer z-10"
          onClick={() => setIsModalOpen(true)}
        >
          <FiZoomIn className="w-6 h-6" />
        </div>
        {/* Ana Resim */}
        <div
          className="cursor-pointer rounded-md shadow-md overflow-hidden"
          onClick={() => setIsModalOpen(true)}
        >
          <Image
            src={selectedImage}
            width={800}
            height={800}
            alt={mainPicture.alternativeText || "Main product image"}
            className="object-cover"
            priority
          />
        </div>
      </div>

      {/* Gallery Thumbnails */}
      {gallery.length > 0 && (
        <div className="flex mt-4 space-x-2 overflow-x-auto">
          {images.map((image, index) => (
            <div
              key={index}
              className="w-20 h-20 rounded-md border border-gray-200 cursor-pointer hover:opacity-80 overflow-hidden"
              onClick={() => setSelectedImage(image.url)}
            >
              <Image
                src={image.url}
                width={80}
                height={80}
                alt={image.alternativeText || "Gallery image"}
                className="object-cover"
              />
            </div>
          ))}
        </div>
      )}

      {/* Modal */}
      {isModalOpen && (
        <div
          className="fixed inset-0 bg-black bg-opacity-75 flex items-center justify-center z-50"
          onClick={() => setIsModalOpen(false)} // Resim dışına tıklayınca kapat
        >
          <div
            className="relative w-auto max-w-full max-h-screen"
            onClick={(e) => e.stopPropagation()} // Resme tıklayınca modal kapanmasın
          >
            <Image
              src={selectedImage}
              width={1200}
              height={800}
              alt="Expanded product"
              className="object-contain max-w-full max-h-screen"
            />
            {/* Kapatma İkonu */}
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
