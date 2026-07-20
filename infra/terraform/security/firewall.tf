# Rule chặn/mở port - Tối ưu hóa bảo mật theo mô hình Cloudflare Tunnel (Zero Trust)
# 1. Chỉ cho phép Google IAP (dùng SSH/K8s API), ĐÓNG HOÀN TOÀN PUBLIC INTERNET
resource "google_compute_firewall" "allow_admin" {
  name    = "allow-admin-management"
  network = google_compute_network.erp_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22", "6443"]
  }

  # Chỉ cho phép dải IP của mạng lưới Google IAP
  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["k3s-node"]
}