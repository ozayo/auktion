// lib/api.ts
export const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:1337';

export async function fetchAPI(endpoint: string, options = {}) {
  const res = await fetch(`${API_URL}/api${endpoint}`, options);
  if (!res.ok) {
    console.error(res.statusText);
    throw new Error('API Hatası');
  }
  const data = await res.json();
  return data;
}
