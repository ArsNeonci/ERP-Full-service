# main/compute.tf
# Khởi tạo VM Instance chạy K3s
resource "google_compute_instance" "k3s_server" {
  name         = "erp-k3s-server-dev"
  machine_type = "e2-standard-4"
  zone         = var.zone

  tags = ["k3s-node"] # Tag này để bắt cặp với Firewall Rules ở trên

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 50 # Tối thiểu 50GB vì chứa nhiều database nội bộ khi dev
      type  = "pd-ssd" # Dùng ổ SSD để đảm bảo tốc độ đọc ghi của Database
    }
  }

  network_interface {
    network    = var.vpc_id
    subnetwork = var.subnet_id

    access_config {
      // Để trống mục này để cấp 1 IP Public dạng Ephemeral cho VM kết nối Internet công cộng
    }
  }

  # Gắn Service Account quyền tối thiểu đã tạo ở tầng bảo mật
  service_account {
    email  = var.k3s_sa_email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  metadata = {
    # Tự động cập nhật OS khi khởi tạo xong
    user-data = <<-EOF
                #!/bin/bash
                apt-get update && apt-get upgrade -y
                EOF
  }
}

# Xuất ra IP Public của Server để cấu hình ở bước tiếp theo
output "k3s_server_public_ip" {
  value       = google_compute_instance.k3s_server.network_interface[0].access_config[0].nat_ip
  description = "Địa chỉ IP Public của máy chủ K3s ERP"
}