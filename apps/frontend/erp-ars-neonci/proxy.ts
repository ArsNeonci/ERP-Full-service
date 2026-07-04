import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'

// BẮT BUỘC phải là 'export function proxy' (nếu tên file là proxy.ts) 
// hoặc 'export function middleware' / 'export default function middleware'
export function proxy(request: NextRequest) {
  
  // Logic kiểm tra auth/phân quyền nội bộ của bạn...
  // Ví dụ:
  const token = request.cookies.get('access_token');
  
  if (!token && request.nextUrl.pathname.startsWith('/admin')) {
    return NextResponse.redirect(new URL('/login', request.url))
  }

  return NextResponse.next()
}

// Cấu hình matcher (Bắt buộc phải export const config)
export const config = {
  matcher: [
    '/((?!api|_next/static|_next/image|favicon.ico).*)',
  ],
}