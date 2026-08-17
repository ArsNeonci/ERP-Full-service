package space.arsneonci.gateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class GatewayApplication {

    public static void main(String[] args) {
        SpringApplication.run(GatewayApplication.class, args);
    }

    // Endpoint để kiểm tra Gateway đã sống chưa
    @GetMapping("/")
    public String gatewayHello() {
        return "HELLO TỪ API GATEWAY!";
    }

    // Cấu hình định tuyến trực tiếp bằng Java để khắc phục lỗi 0 Route từ YAML
    @Bean
    public RouteLocator customRouteLocator(RouteLocatorBuilder builder) {
        return builder.routes()
            // Route cho CRM Service
            .route("crm-service", r -> r.path("/api/crm/**")
                .uri("http://backend-crm-svc:80"))
            
            // Route cho Sales Service
            .route("sales-service", r -> r.path("/api/sales/**")
                .uri("http://backend-sales-svc:80"))
            
            // Route cho AI Facial Recognition Service
            .route("ai-face-recognition", r -> r.path("/api/ai-face/**")
                .uri("http://ai-face-recognition-svc:80"))
            
            .route("identity-service", r -> r.path("/api/identity/**")
                .uri("http://auth-identity-svc:80"))
                
            .build();
    }
}