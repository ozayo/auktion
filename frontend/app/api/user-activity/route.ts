import { NextRequest, NextResponse } from 'next/server';

// Next.js API route artık kullanılmıyor
export async function POST(request: NextRequest) {
  return NextResponse.json(
    { 
      message: 'This API route is deprecated. Please use direct Strapi API calls.', 
      info: 'BidForm and LotForm now make direct API calls to Strapi.'
    }, 
    { status: 200 }
  );
} 