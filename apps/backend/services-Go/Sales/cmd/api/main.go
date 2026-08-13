package main

import "github.com/gin-gonic/gin"

func main() {
    r := gin.Default()
    
    r.GET("/api/sales/test", func(c *gin.Context) {
        c.String(200, "THÀNH CÔNG: Đây là phản hồi từ GOLANG (Sales Service)!")
    })

    r.Run(":8080") 
}