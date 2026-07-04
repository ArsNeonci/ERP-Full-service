# security/outputs.tf
output "vpc_id" {
  value       = google_compute_network.erp_vpc.id
  description = "ID của mạng VPC"
}

output "subnet_id" {
  value       = google_compute_subnetwork.erp_subnet.id
  description = "ID của Subnet ERP"
}

output "k3s_sa_email" {
  value       = google_service_account.k3s_sa.email
  description = "Email của Service Account chạy K3s"
}