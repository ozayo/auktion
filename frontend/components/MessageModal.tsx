import React from "react";

interface MessageModalProps {
  isOpen: boolean;
  message: string;
  onClose: () => void;
  onConfirm?: () => void; // Optional confirm action
  confirmText?: string; // Custom text for confirm button
}

const MessageModal: React.FC<MessageModalProps> = ({
  isOpen,
  message,
  onClose,
  onConfirm,
  confirmText = "OK",
}) => {
  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-gray-800 bg-opacity-50 flex justify-center items-center z-60">
      <div className="bg-white p-6 rounded-md shadow-md w-96 z-70">
        <p className="text-lg text-gray-800">{message}</p>
        <div className="flex justify-end gap-2 mt-4">
          <button
            onClick={onClose}
            className="px-4 py-2 bg-gray-300 hover:bg-gray-400 rounded"
          >
            Stäng
          </button>
          {onConfirm && (
            <button
              onClick={onConfirm}
              className="px-4 py-2 bg-blue-500 text-white hover:bg-blue-600 rounded"
            >
              {confirmText}
            </button>
          )}
        </div>
      </div>
    </div>
  );
};

export default MessageModal;
