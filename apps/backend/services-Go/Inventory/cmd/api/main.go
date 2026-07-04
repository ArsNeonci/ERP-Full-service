package main

import (
	"log"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"

	"erp-monorepo/apps/backend/services-Go/inventory/internal/repositories"
	"erp-monorepo/apps/backend/services-Go/inventory/pkg/database"
)

func main() {
	// 1. Nạp biến môi trường
	_ = godotenv.Load()

	// 2. Khởi tạo DB (Bao gồm Connection Pool & Tự động chạy Migration)
	db := database.InitPostgres()

	// 3. Khởi tạo các layer theo chuẩn Clean Architecture
	productRepo := repositories.NewProductRepository(db)
	_ = productRepo // Tạm bypass lỗi UnusedVar chờ code tầng Service

	// 4. Khởi tạo Gin Router
	router := gin.Default()

	port := ":8082"
	log.Printf("🚀 Inventory Service (Golang) đang chạy tại port %s", port)
	router.Run(port)
}