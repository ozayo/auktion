// lib/api.ts

export const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:1337';

export async function fetchAPI(endpoint: string, options: RequestInit = {}) {
  const res = await fetch(`${API_URL}/api${endpoint}`, options);

  if (res.status === 204) {
    return { status: 204, ok: true };
  }

  const contentType = res.headers.get("Content-Type") || "";
  
  if (contentType.includes("application/json")) {
    // If the response is JSON, let's parse it
    const data = await res.json();

    // After parsing the JSON, throw an error if the response is not successful.
    if (!res.ok) {
      console.error(res.statusText);
      throw new Error(data?.error?.message || 'API Hatası');
    }

    // If successful, return data with status and ok information.
    return { ...data, status: res.status, ok: res.ok };

  } else {
    // If the response is not JSON or the body is empty
    // In this case, if the response is unsuccessful, throw an error.
    if (!res.ok) {
      console.error(res.statusText);
      throw new Error('API Hatası');
    }

    // Successful but not JSON or empty body response
    return { status: res.status, ok: res.ok };
  }
}
