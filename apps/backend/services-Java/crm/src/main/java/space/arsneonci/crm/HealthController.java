package space.arsneonci.crm;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/crm")
public class HealthController {

    @GetMapping("/health")
    public String healthCheck() {
        return "{\"status\": \"success\", \"message\": \"CRM Service is running successfully!\"}";
    }
}