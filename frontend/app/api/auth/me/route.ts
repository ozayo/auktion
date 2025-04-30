import { NextRequest, NextResponse } from 'next/server';
import { getUserMeLoader } from '@/app/data/services/get-user-me-loader';

export async function GET(request: NextRequest) {
  // Server-side'da getUserMeLoader kullanarak kullanıcı bilgilerini al
  const userResponse = await getUserMeLoader();
  
  // JSON response olarak döndür
  return NextResponse.json(userResponse);
} 