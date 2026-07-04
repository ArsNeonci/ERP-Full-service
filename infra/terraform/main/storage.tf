# infra/terraform/main/storage.tf
# Khởi tạo Cloud Storage nếu cần cho ERP (ví dụ lưu hóa đơn, avatar)
resource "google_storage_bucket" "erp_media_bucket" {
  name          = "erp-media-storage-${var.project_id}" # Thêm project_id để đảm bảo tên bucket không bị trùng
  location      = var.region
  force_destroy = true # Cho phép xóa bucket kể cả khi có file bên trong (Dùng cho môi trường Dev)

  uniform_bucket_level_access = true

  versioning {
    enabled = true # Giữ lại các phiên bản cũ của file
  }
}