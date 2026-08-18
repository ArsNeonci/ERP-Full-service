package space.arsneonci.identity;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

// KHÔNG CẦN IMPORT CÁC CLASS SECURITY NỮA ĐỂ TRÁNH LỖI VS CODE

// Sử dụng excludeName và truyền tên package dưới dạng chuỗi (String)
@SpringBootApplication(excludeName = { 
    // Đường dẫn chuẩn của Spring Boot
    "org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration",
    "org.springframework.boot.autoconfigure.security.servlet.UserDetailsServiceAutoConfiguration",
    
    // Đường dẫn phụ (dự phòng theo log báo lỗi trước đó của hệ thống)
    "org.springframework.boot.security.autoconfigure.SecurityAutoConfiguration",
    "org.springframework.boot.security.autoconfigure.UserDetailsServiceAutoConfiguration"
})
public class IdentityApplication {

    public static void main(String[] args) {
        SpringApplication.run(IdentityApplication.class, args);
    }
}