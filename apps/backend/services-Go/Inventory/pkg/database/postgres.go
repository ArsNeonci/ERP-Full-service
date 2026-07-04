package database

import (
	"database/sql"
	"fmt"
	"log"
	"os"
	"time"

	"github.com/golang-migrate/migrate/v4"
	"github.com/golang-migrate/migrate/v4/database/postgres"
	_ "github.com/golang-migrate/migrate/v4/source/file" // Import driver đọc file sql
	gorm_postgres "gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

// InitPostgres khởi tạo kết nối DB và cấu hình Pool
func InitPostgres() *gorm.DB {
	dsn := fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%s sslmode=disable TimeZone=Asia/Ho_Chi_Minh",
		os.Getenv("DB_HOST"), os.Getenv("DB_USERNAME"), os.Getenv("DB_PASSWORD"), os.Getenv("DB_NAME"), os.Getenv("DB_PORT"))

	logLevel := logger.Silent
	if os.Getenv("ENV") == "development" {
		logLevel = logger.Info
	}

	db, err := gorm.Open(gorm_postgres.Open(dsn), &gorm.Config{
		Logger: logger.Default.LogMode(logLevel),
	})
	if err != nil {
		log.Fatalf("❌ Không thể kết nối đến PostgreSQL: %v", err)
	}

	sqlDB, err := db.DB()
	if err != nil {
		log.Fatalf("❌ Lỗi khi lấy sql.DB instance: %v", err)
	}

	sqlDB.SetMaxIdleConns(5)
	sqlDB.SetMaxOpenConns(20)
	sqlDB.SetConnMaxLifetime(30 * time.Minute)

	log.Println("✅ Đã kết nối thành công tới PostgreSQL (Inventory DB)")

	// CHẠY MIGRATION TỰ ĐỘNG
	runDBMigration(sqlDB)

	return db
}

// Hàm chạy kịch bản file SQL
func runDBMigration(db *sql.DB) {
	migrationPath := "file://db/migration" // Trỏ tới thư mục chứa file .sql

	driver, err := postgres.WithInstance(db, &postgres.Config{})
	if err != nil {
		log.Fatalf("❌ Lỗi khởi tạo driver migration: %v", err)
	}

	m, err := migrate.NewWithDatabaseInstance(migrationPath, "postgres", driver)
	if err != nil {
		log.Fatalf("❌ Lỗi cấu hình migration: %v", err)
	}

	err = m.Up()
	if err != nil && err != migrate.ErrNoChange {
		log.Fatalf("❌ Lỗi khi chạy file SQL Migration: %v", err)
	}

	log.Println("✅ Hoàn tất chạy Database Migration")
}