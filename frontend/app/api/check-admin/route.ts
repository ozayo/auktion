import { NextResponse } from 'next/server';

export async function POST(req: Request) {
  try {
    const { token }: { token: string } = await req.json();

    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/admin/users/me`, {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });

    if (!response.ok) {
      throw new Error('Unauthorized');
    }

    const { data } = await response.json();
    return NextResponse.json({ isAdmin: true, user: data });
  } catch (error) {
    return NextResponse.json({ isAdmin: false }, { status: 401 });
  }
}
