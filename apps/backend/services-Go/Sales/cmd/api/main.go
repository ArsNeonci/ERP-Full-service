package main

import (
	"net/http"
	"github.com/gin-gonic/gin"
)

func main() {
	router := gin.Default()

	// Tạm thời bỏ qua Middleware kiểm tra JWT Auth theo yêu cầu test
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

	// Service nội bộ K3s chạy ở port 8093 (Khớp với containerPort trong backend-sales.yaml)
	router.Run(":8093")
}