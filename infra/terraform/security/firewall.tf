# security/firewall.tf
# Rule chặn/mở port - Tối ưu hóa bảo mật theo mô hình Cloudflare Tunnel (Zero Trust)

# 1. Chỉ cho phép IP của bạn SSH (cổng 22) và kết nối Kubernetes API (cổng 6443) để quản trị hệ thống
resource "google_compute_firewall" "allow_admin" {
  name    = "allow-admin-management"
  network = google_compute_network.erp_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22", "6443"]
  }

  source_ranges = [var.admin_ip]
  target_tags   = ["k3s-node"]
}

# LƯU Ý KIẾN TRÚC:
# Toàn bộ cổng inbound 80/443 phục vụ traffic công cộng đã được ĐÓNG HOÀN TOÀN ở tầng hạ tầng này.
# Traffic từ internet đi vào sẽ đi qua Cloudflare Tunnel nhờ kết nối outbound do K3s Agent tự thiết lập.