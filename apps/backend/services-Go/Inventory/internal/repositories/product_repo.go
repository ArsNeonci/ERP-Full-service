package repositories

import (
	"context"
	"errors"

	"gorm.io/gorm"
)

type Product struct {
	gorm.Model
	Name     string
	Quantity int
	TenantID string `gorm:"index"` // Dùng để phân biệt data của user/doanh nghiệp
}

type ProductRepository interface {
	GetProductsByUser(ctx context.Context) ([]Product, error)
}

type productRepo struct {
	db *gorm.DB
}

func NewProductRepository(db *gorm.DB) ProductRepository {
	return &productRepo{db: db}
}

func (r *productRepo) GetProductsByUser(ctx context.Context) ([]Product, error) {
	// Lấy X-User-ID đã được inject từ Gin Middleware (Tier 2)
	userID, ok := ctx.Value("X-User-ID").(string)
	if !ok || userID == "" {
		return nil, errors.New("unauthorized db access: missing User-ID in context")
	}

	var products []Product
	// Truy vấn kết hợp Tenant Isolation
	err := r.db.WithContext(ctx).Where("tenant_id = ?", userID).Find(&products).Error
	return products, err
}