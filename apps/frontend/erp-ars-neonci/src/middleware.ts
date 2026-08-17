import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';

export function middleware(request: NextRequest) {
  const url = request.nextUrl;
  
  // Lấy tên miền mà người dùng đang truy cập
  const hostname = request.headers.get('host') || '';

  // Bỏ qua các file tĩnh và API nội bộ của Next.js
  if (url.pathname.startsWith('/_next') || url.pathname.startsWith('/api')) {
    return NextResponse.next();
  }

  // Luồng 1: Nếu người dùng truy cập portal.arsneonci.space
  if (hostname.includes('portal.arsneonci.space')) {
    // Rewrite ngầm request vào thư mục /erp
    return NextResponse.rewrite(new URL(`/erp${url.pathname}`, request.url));
  }

  // Luồng 2: Nếu người dùng truy cập arsneonci.space (Ecommerce)
  if (hostname === 'arsneonci.space' || hostname.startsWith('arsneonci.space')) {
    // Rewrite ngầm request vào thư mục /ecommerce
    return NextResponse.rewrite(new URL(`/ecommerce${url.pathname}`, request.url));
  }

  return NextResponse.next();
}

// Cấu hình matcher để middleware không chặn các file ảnh, font, css...
export const config = {
  matcher: [
    '/((?!api|_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)',
  ],
};