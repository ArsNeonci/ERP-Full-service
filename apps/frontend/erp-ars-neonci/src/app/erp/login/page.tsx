'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';

export default function LoginPage() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [log, setLog] = useState('');
  const router = useRouter();

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    setLog('Đang kết nối đến API Gateway...');
    
    try {
      const res = await fetch('/api/identity/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ username, password }),
      });
      
      const data = await res.json();
      
      if (res.ok) {
        setLog(`✅ Server phản hồi: ${data.message}`);
        setTimeout(() => router.push('/dashboard'), 1000);
      } else {
        // Lấy data.message (từ service của bạn) HOẶC data.error (từ Gateway)
        const errorMessage = data.message || data.error || 'Lỗi không xác định';
        setLog(`❌ Lỗi: ${errorMessage}`);
      }
    } catch (error) {
      setLog('❌ Không thể kết nối tới Gateway/Identity Service.');
    }
  };

  return (
    <div className="flex h-screen items-center justify-center bg-gray-100">
      <form onSubmit={handleLogin} className="bg-white p-8 shadow-md rounded flex flex-col gap-4 w-96">
        <h2 className="text-2xl font-bold text-center">ERP Login</h2>
        <input 
          type="text" 
          placeholder="Tài khoản (admin)" 
          className="border p-2 rounded text-black"
          value={username} onChange={(e) => setUsername(e.target.value)} 
        />
        <input 
          type="password" 
          placeholder="Mật khẩu (123456)" 
          className="border p-2 rounded text-black"
          value={password} onChange={(e) => setPassword(e.target.value)} 
        />
        <button type="submit" className="bg-blue-600 text-white p-2 rounded hover:bg-blue-700">
          Đăng nhập
        </button>
        {log && <p className="text-sm font-mono mt-4 p-2 bg-gray-100 border rounded">{log}</p>}
      </form>
    </div>
  );
}