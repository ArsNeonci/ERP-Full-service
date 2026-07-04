# infra/terraform/outputs.tf
output "k3s_server_ip" {
  value       = module.core_infra.k3s_server_public_ip
  description = "Địa chỉ IP Public của Server ERP để bạn SSH vào cài đặt K3s"
}

output "cf_access_client_id" {
  value       = cloudflare_zero_trust_access_service_token.gcp_automation_token.client_id
  description = "Client ID của Zero Trust (Dùng cho Automation)"
}

output "cf_access_client_secret" {
  value       = cloudflare_zero_trust_access_service_token.gcp_automation_token.client_secret
  description = "Client Secret của Zero Trust (Tuyệt đối giữ kín)"
  sensitive   = true 
}

output "cf_tunnel_token" {
  value       = cloudflare_zero_trust_tunnel_cloudflared.k3s_tunnel.tunnel_token
  description = "Token để kết nối K3s Agent với Cloudflare Tunnel (Bơm vào file yaml K3s)"
  sensitive   = true 
}