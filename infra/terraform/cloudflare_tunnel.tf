# infra/terraform/cloudflare_tunnel.tf

# 1. Tạo chuỗi ngẫu nhiên làm Secret cho Tunnel
resource "random_password" "tunnel_secret" {
  length  = 64
  special = true
}

# 2. Khởi tạo Cloudflare Tunnel (Sử dụng Resource mới)
resource "cloudflare_zero_trust_tunnel_cloudflared" "k3s_tunnel" {
  account_id = var.cloudflare_account_id
  name       = "erp-monorepo-tunnel"
  secret     = base64encode(random_password.tunnel_secret.result) 
}

# 3. Định tuyến trang nội bộ (Portal)
resource "cloudflare_record" "portal_cname" {
  zone_id = var.cloudflare_zone_id
  name    = "portal"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.k3s_tunnel.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}

# 4. Định tuyến trang bán hàng (Ecommerce)
resource "cloudflare_record" "ecommerce_cname" {
  zone_id = var.cloudflare_zone_id
  name    = "@"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.k3s_tunnel.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}