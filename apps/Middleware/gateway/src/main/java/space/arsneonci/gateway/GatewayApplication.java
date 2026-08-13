package space.arsneonci.gateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
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
}