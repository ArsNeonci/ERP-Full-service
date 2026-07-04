package repositories

import (
	"context"
	"errors"

	"gorm.io/gorm"
)

type PurchaseOrder struct {
	gorm.Model
	Name     string
	Quantity int
	TenantID string `gorm:"index"` // Dùng để phân biệt data của user/doanh nghiệp
}

type PurchaseOrderRepository interface {
	GetPurchaseOrdersByUser(ctx context.Context) ([]PurchaseOrder, error)
}

type PurchaseOrderRepo struct {
	db *gorm.DB
}

func NewPurchaseOrderRepository(db *gorm.DB) PurchaseOrderRepository {
	return &PurchaseOrderRepo{db: db}
}

func (r *PurchaseOrderRepo) GetPurchaseOrdersByUser(ctx context.Context) ([]PurchaseOrder, error) {
	// Lấy X-User-ID đã được inject từ Gin Middleware (Tier 2)
	userID, ok := ctx.Value("X-User-ID").(string)
	if !ok || userID == "" {
		return nil, errors.New("unauthorized db access: missing User-ID in context")
	}

	var PurchaseOrders []PurchaseOrder
	// Truy vấn kết hợp Tenant Isolation
	err := r.db.WithContext(ctx).Where("tenant_id = ?", userID).Find(&PurchaseOrders).Error
	return PurchaseOrders, err
}