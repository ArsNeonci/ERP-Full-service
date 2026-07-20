# Biến môi trường chung
variable "region" {
  type    = string
  default = "asia-southeast1" # Singapore
}
variable "zone" {
  type    = string
  default = "asia-southeast1-a"
}

# --- Thông tin GCP ---
variable "project_id" {
  type        = string
  description = "Project ID trên Google Cloud (VD: erp-production-412301)"
}

# --- Thông tin Cloudflare & Domain ---
variable "cloudflare_api_token" {
  type        = string
  description = "API Token từ Cloudflare Dashboard (Cần quyền chỉnh sửa DNS)"
  sensitive   = true
}
variable "cloudflare_zone_id" {
  type        = string
  description = "Zone ID của Domain trên Cloudflare"
}
variable "domain_name" {
  type        = string
  description = "Tên miền (VD: congtycua-ban.com)"
}

# --- Thông tin Quản trị (Admin) ---
variable "cloudflare_account_id" {
  type        = string
  description = "Account ID của Cloudflare (Dùng cho Zero Trust)"
}
variable "dev_team_emails" {
  type        = list(string)
  description = "Danh sách email của team Dev được phép truy cập"
  default     = ["quanglinh1286@gmail.com", "chuquanglinh2004@gmail.com"]
}