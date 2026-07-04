# infra/terraform/cloudflare_access.tf

# 1. Tạo Application bảo vệ toàn bộ Tên miền (Self-hosted)
resource "cloudflare_zero_trust_access_application" "erp_zero_trust" {
  account_id       = var.cloudflare_account_id
  name             = "Hệ thống ERP Nội Bộ"
  domain           = var.domain_name
  session_duration = "24h" # Mã OTP có hiệu lực 24 giờ
}

# 2. Tạo Service Token cho các hệ thống tự động (Terraform/CI-CD/GCP Scripts)
resource "cloudflare_zero_trust_access_service_token" "gcp_automation_token" {
  account_id = var.cloudflare_account_id
  name       = "Terraform-GCP-Access-Token"
}

# 3. Policy 1: Cho phép Team Dev đăng nhập bằng OTP gửi qua Email
resource "cloudflare_zero_trust_access_policy" "allow_dev_team" {
  application_id = cloudflare_zero_trust_access_application.erp_zero_trust.id
  account_id     = var.cloudflare_account_id
  name           = "Cho phep Team Dev (OTP)"
  precedence     = 1
  decision       = "allow"

  include {
    email = var.dev_team_emails
  }
}

# 4. Policy 2: Cho phép Hệ thống tự động đi qua bằng Service Token
resource "cloudflare_zero_trust_access_policy" "allow_automation" {
  application_id = cloudflare_zero_trust_access_application.erp_zero_trust.id
  account_id     = var.cloudflare_account_id
  name           = "Cho phep CI/CD va GCP Scripts"
  precedence     = 2
  decision       = "non_identity" 

  include {
    service_token = [cloudflare_zero_trust_access_service_token.gcp_automation_token.id]
  }
}