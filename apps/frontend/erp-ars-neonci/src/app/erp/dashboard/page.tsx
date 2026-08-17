'use client';

import { useState } from 'react';

// Cập nhật thành MẢNG 10 DỊCH VỤ VÀ DÙNG ĐƯỜNG DẪN TƯƠNG ĐỐI (REST)
const MICROSERVICES = [
  { name: 'Identity (Java)', endpoint: '/api/identity/test', color: 'bg-blue-600' },
  { name: 'Facial Recognition', endpoint: '/api/ai-face/test', color: 'bg-indigo-500' },
  { name: 'Multimodal Engine', endpoint: '/api/ai-multimodal/test', color: 'bg-indigo-600' },
  { name: 'Orchestrator', endpoint: '/api/ai-orchestrator/test', color: 'bg-indigo-700' },
  { name: 'Inventory (Go)', endpoint: '/api/inventory/test', color: 'bg-teal-500' },
  { name: 'Purchasing (Go)', endpoint: '/api/purchasing/test', color: 'bg-teal-600' },
  { name: 'Sales (Go)', endpoint: '/api/sales/test', color: 'bg-teal-700' },
  { name: 'CRM (Java)', endpoint: '/api/crm/test', color: 'bg-orange-500' },
  { name: 'Finance (Java)', endpoint: '/api/finance/test', color: 'bg-orange-600' },
  { name: 'HRM (Java)', endpoint: '/api/hrm/test', color: 'bg-orange-700' },
];

export default function DashboardPage() {
  const [logs, setLogs] = useState<Record<string, string>>({});

  const testConnection = async (name: string, endpoint: string) => {
    setLogs(prev => ({ ...prev, [name]: 'Đang gọi API qua Gateway...' }));
    try {
      const response = await fetch(endpoint, { method: 'GET' });
      const text = await response.text(); 
      if (response.ok) {
        setLogs(prev => ({ ...prev, [name]: `✅ Cổng mở: ${text}` }));
      } else {
        setLogs(prev => ({ ...prev, [name]: `⚠️ Gateway trả về lỗi ${response.status}: ${text}` }));
      }
    } catch (error: any) {
      setLogs(prev => ({ ...prev, [name]: `❌ Lỗi mạng: ${error.message}` }));
    }
  };

  return (
    <div className="p-8 min-h-screen bg-gray-50 text-gray-800">
      <h1 className="text-3xl font-bold mb-8 text-center">Microservices Dashboard Test</h1>
      
      <div className="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-4 gap-6 max-w-7xl mx-auto">
        {MICROSERVICES.map((service) => (
          <div key={service.name} className="bg-white border rounded-lg shadow-sm p-4 flex flex-col gap-4">
            <h2 className="font-semibold text-lg">{service.name}</h2>
            <code className="text-xs bg-gray-100 p-2 rounded overflow-hidden text-ellipsis whitespace-nowrap">
              {service.endpoint}
            </code>
            <button 
              onClick={() => testConnection(service.name, service.endpoint)}
              className={`${service.color} text-white py-2 px-4 rounded transition hover:opacity-80 font-medium shadow-sm`}
            >
              Test API
            </button>
            <div className="h-20 text-sm p-2 bg-gray-900 text-green-400 rounded overflow-y-auto font-mono break-words">
              {logs[service.name] || 'Chưa gửi yêu cầu.'}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}