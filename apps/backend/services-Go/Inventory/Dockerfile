# Stage 1: Build 
FROM golang:1.26.4-alpine3.23 AS build
WORKDIR /app

RUN apk add --no-cache git ca-certificates
COPY go.mod go.sum ./

# Sử dụng BuildKit Cache để tăng tốc CI/CD
RUN --mount=type=cache,target=/go/pkg/mod \
    go mod download

COPY . .
# Build binary tĩnh độc lập (CGO_ENABLED=0)
RUN --mount=type=cache,target=/go/pkg/mod \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o app ./cmd/api/main.go

# Stage 2: Final Runtime 
FROM alpine:3.23 AS final
WORKDIR /app

# Bổ sung thư viện tzdata và set biến môi trường múi giờ
RUN apk add --no-cache ca-certificates tzdata
ENV TZ=Asia/Ho_Chi_Minh

# Bảo mật: Non-root user
RUN addgroup -S gouser && adduser -S gouser -G gouser
USER gouser:gouser

# Copy file thực thi
COPY --from=build /app/app .
# [SỬA LỖI Ở ĐÂY] Copy thêm thư mục migration chứa các file .sql
COPY --from=build /app/db/migration ./db/migration

EXPOSE 8080
ENTRYPOINT ["./app"]