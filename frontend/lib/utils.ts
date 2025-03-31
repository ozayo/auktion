import { clsx, type ClassValue } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

export function getStrapiURL(path: string = ""): string {
  const url = process.env.NEXT_PUBLIC_STRAPI_URL || "http://localhost:1337";
  return `${url}${path}`;
}
