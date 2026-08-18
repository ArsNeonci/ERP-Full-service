package space.arsneonci.identity.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            // 1. Bổ sung: Tắt CSRF Protection để cho phép các request đổi trạng thái như POST (Login), PUT, DELETE đi qua
            .csrf(csrf -> csrf.disable())
            
            // 2. Giữ nguyên: Cho phép mọi request đi qua (chưa cần xác thực lúc này)
            .authorizeHttpRequests(auth -> auth
                .anyRequest().permitAll()
            )
            
            // 3. Giữ nguyên: Tắt hộp thoại đăng nhập mặc định của trình duyệt và form login mặc định của Spring
            .httpBasic(httpBasic -> httpBasic.disable())
            .formLogin(formLogin -> formLogin.disable());

        return http.build();
    }
}