import { type ClassValue, clsx } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

export function getStrapiURL() {
  return process.env.NEXT_PUBLIC_STRAPI_API_URL || "http://localhost:1337";
}

export function formatCurrency(amount: number): string {
  return new Intl.NumberFormat('sv-SE', {
    style: 'currency',
    currency: 'SEK',
    minimumFractionDigits: 0,
    maximumFractionDigits: 0,
  }).format(amount);
}

export function getImageUrl(image: any): string {
  if (!image) return "/placeholder.jpg";
  
  if (image.formats?.thumbnail?.url) {
    return `${getStrapiURL()}${image.formats.thumbnail.url}`;
  }
  
  if (image.url) {
    return `${getStrapiURL()}${image.url}`;
  }
  
  return "/placeholder.jpg";
}

export function getFormattedDate(dateString: string): string {
  const date = new Date(dateString);
  return date.toLocaleDateString('sv-SE', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
  });
}

export function truncateText(text: string, maxLength: number): string {
  if (text.length <= maxLength) return text;
  return text.slice(0, maxLength) + '...';
}
