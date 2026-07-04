# Stage 1: Build (Bản chuẩn có glibc để tương thích gRPC)
FROM maven:3.9.16-eclipse-temurin-25 AS build
WORKDIR /app

COPY pom.xml . 
RUN --mount=type=cache,target=/root/.m2 \
    mvn dependency:go-offline -B

COPY src ./src
RUN --mount=type=cache,target=/root/.m2 \
    mvn package -DskipTests -B

# Stage 2: Final Runtime (Bản Alpine siêu nhẹ)
FROM eclipse-temurin:25.0.3_9-jre-alpine-3.23 AS final
WORKDIR /app

# Bảo mật: Chạy dưới quyền non-root trên K3s
RUN addgroup -S javauser && adduser -S javauser -G javauser
USER javauser:javauser

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8087
ENTRYPOINT ["java", "-jar", "app.jar"]