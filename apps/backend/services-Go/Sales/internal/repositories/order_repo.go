package repositories

import (
	"context"
	"errors"

	"gorm.io/gorm"
)

type Order struct {
	gorm.Model
	Name     string
	Quantity int
	TenantID string `gorm:"index"` // Dùng để phân biệt data của user/doanh nghiệp
}

type OrderRepository interface {
	GetOrdersByUser(ctx context.Context) ([]Order, error)
}

type OrderRepo struct {
	db *gorm.DB
}

func NewOrderRepository(db *gorm.DB) OrderRepository {
	return &OrderRepo{db: db}
}

func (r *OrderRepo) GetOrdersByUser(ctx context.Context) ([]Order, error) {
	// Lấy X-User-ID đã được inject từ Gin Middleware (Tier 2)
	userID, ok := ctx.Value("X-User-ID").(string)
	if !ok || userID == "" {
		return nil, errors.New("unauthorized db access: missing User-ID in context")
	}

	var Orders []Order
	// Truy vấn kết hợp Tenant Isolation
	err := r.db.WithContext(ctx).Where("tenant_id = ?", userID).Find(&Orders).Error
	return Orders, err
}