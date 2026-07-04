# infra/terraform/main/registry.tf
# Khởi tạo Google Artifact Registry (GAR) để lưu Docker Image
resource "google_artifact_registry_repository" "erp_docker_repo" {
  location      = var.region
  repository_id = "erp-microservices-repo"
  description   = "Nơi lưu trữ Docker images cho các dịch vụ ERP (FastAPI, SpringBoot, Gin)"
  format        = "DOCKER"

  docker_config {
    immutable_tags = false # Cho phép ghi đè image tag 'latest' trong quá trình dev
  }

  # Tắt chế độ chạy thử để GCP thực sự áp dụng việc xóa image
  cleanup_policy_dry_run = false 

  # --- KỊCH BẢN DỌN DẸP TỰ ĐỘNG (CLEANUP POLICIES) ---

  # 1. Chính sách GIỮ LẠI: Không bao giờ xóa các image có tag là 'latest' hoặc 'production'
  cleanup_policies {
    id     = "keep-important-tags"
    action = "KEEP"
    condition {
      tag_state    = "TAGGED"
      tag_prefixes = ["latest", "production"]
    }
  }

  # 2. Chính sách GIỮ LẠI: Luôn giữ 5 phiên bản mới nhất của mỗi repository (Dùng để rollback khi cần)
  cleanup_policies {
    id     = "keep-recent-5-versions"
    action = "KEEP"
    most_recent_versions {
      keep_count = 5
    }
  }

  # 3. Chính sách XÓA: Xóa tất cả các image cũ hơn 30 ngày (nếu chúng không rơi vào 2 trường hợp giữ lại ở trên)
  cleanup_policies {
    id     = "delete-older-than-30-days"
    action = "DELETE"
    condition {
      tag_state  = "ANY"
      older_than = "2592000s" # 30 ngày quy đổi ra giây
    }
  }
}