package space.arsneonci.identity;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.Map;

@RestController
@RequestMapping("/api/identity")
public class AuthController {

    // 1. Endpoint test REST tương tự các Microservices đại diện (CRM, Sales...)
    @GetMapping("/test")
    public String testConnection() {
        return "✅ [IDENTITY SERVICE] Kết nối REST qua Gateway thành công!";
    }

    // 2. Endpoint login tạm thời đã cấu hình từ trước
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> credentials) {
        String username = credentials.get("username");
        String password = credentials.get("password");

        if ("admin".equals(username) && "123456".equals(password)) {
            System.out.println("✅ [LOG] Đăng nhập thành công với tài khoản: " + username);
            return ResponseEntity.ok(Map.of(
                "status", "success",
                "message", "Xác thực thành công",
                "token", "dummy-token-for-testing"
            ));
        }
        
        System.out.println("❌ [LOG] Đăng nhập thất bại. Sai thông tin: " + username);
        return ResponseEntity.status(401).body(Map.of(
            "status", "error",
            "message", "Sai tài khoản hoặc mật khẩu"
        ));
    }
}