# variables.tf
# Biến môi trường chung

variable "region" {
  type    = string
  default = "asia-southeast1" # Singapore - tối ưu cho Việt Nam
}

variable "zone" {
  type    = string
  default = "asia-southeast1-a"
}

# infra/terraform/variables.tf
# --- Liên kết GCP ---
variable "project_id" {
  type        = string
  description = "Project ID trên Google Cloud (VD: erp-production-412301)"
}

# --- Liên kết Cloudflare & Domain ---
variable "cloudflare_api_token" {
  type        = string
  description = "API Token tạo từ Cloudflare Dashboard (Cần quyền chỉnh sửa DNS)"
  sensitive   = true
}

variable "cloudflare_zone_id" {
  type        = string
  description = "Zone ID của Domain trên Cloudflare (Nằm ở trang tổng quan của Domain)"
}

variable "domain_name" {
  type        = string
  description = "Tên miền gốc của bạn (VD: congtycua-ban.com)"
}

# --- Liên kết Quản trị (Admin) ---
variable "admin_ip" {
  type        = string
  description = "IP Public của máy tính bạn đang dùng (VD: 113.190.23.45/32). Tra tại whatismyip.com"
}

variable "cloudflare_account_id" {
  type        = string
  description = "Account ID của Cloudflare (Dùng cho Zero Trust)"
}

variable "dev_team_emails" {
  type        = list(string)
  description = "Danh sách email của team Dev được phép truy cập"
  default     = ["quanglinh1286@gmail.com", "chuquanglinh2004@gmail.com"]
}