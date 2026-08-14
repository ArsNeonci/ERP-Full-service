package main

import (
	"net/http"
	"github.com/gin-gonic/gin"
)

func main() {
	router := gin.Default()

	// Tạm thời bỏ qua Middleware kiểm tra JWT Auth
	salesGroup := router.Group("/api/sales")
	{
		salesGroup.GET("/test", func(c *gin.Context) {
			c.JSON(http.StatusOK, gin.H{
				"service": "Sales",
				"tech":    "Golang Gin",
				"status":  "200 OK",
				"message": "Sales Microservice is reachable via API Gateway!",
			})
		})
	}

	// Service nội bộ K3s chạy ở port 8080
	router.Run(":8080")
}