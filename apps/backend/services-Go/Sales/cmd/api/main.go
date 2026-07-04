package main

import (
	"log"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"

	"erp-monorepo/apps/backend/services-Go/sales/internal/repositories"
	"erp-monorepo/apps/backend/services-Go/sales/pkg/database"
)

func main() {
	// 1. Nạp biến môi trường
	_ = godotenv.Load()

	// 2. Khởi tạo DB (Bao gồm Connection Pool & Tự động chạy Migration)
	db := database.InitPostgres()

	// 3. Khởi tạo các layer theo chuẩn Clean Architecture
	OrderRepo := repositories.NewOrderRepository(db)
	_ = OrderRepo // Tạm bypass lỗi UnusedVar chờ code tầng Service

	// 4. Khởi tạo Gin Router
	router := gin.Default()

	port := ":8084"
	log.Printf("🚀 sales Service (Golang) đang chạy tại port %s", port)
	router.Run(port)
}