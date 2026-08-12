package main

import "github.com/gin-gonic/gin"

func main() {
    r := gin.Default()
    
    // Health check endpoint
    r.GET("/api/sales/health", func(c *gin.Context) {
        c.JSON(200, gin.H{
            "status": "success",
            "message": "Sales Service is running successfully!",
        })
    })

    // K3s nội bộ và Docker local đều ánh xạ port 8080
    r.Run(":8080") 
}