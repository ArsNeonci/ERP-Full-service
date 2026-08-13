package main.java.space.arsneonci.crm;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/crm")
public class TestController {
    @GetMapping("/test")
    public String testJava() {
        return "THÀNH CÔNG: Đây là phản hồi từ JAVA (CRM Service)!";
    }
}