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

RUN apk add --no-cache ca-certificates

# Bảo mật: Non-root user
RUN addgroup -S gouser && adduser -S gouser -G gouser
USER gouser:gouser

COPY --from=build /app/app .

EXPOSE 8082
ENTRYPOINT ["./app"]