package main.java.space.arsneonci.crm;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.Map;

@RestController
@RequestMapping("/api/crm")
public class TestController {
    
    @GetMapping("/test")
    public ResponseEntity<Map<String, String>> test() {
        return ResponseEntity.ok(Map.of(
            "service", "CRM",
            "tech", "Java Spring Boot",
            "status", "200 OK",
            "message", "CRM Microservice is reachable via API Gateway!"
        ));
    }
}