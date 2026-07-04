# security/iam.tf
# Cấu hình Service Account, Workload Identity Federation
resource "google_service_account" "k3s_sa" {
  account_id   = "erp-k3s-node-sa"
  display_name = "Service Account phục vụ K3s Node Instance"
}

# Quyền ghi Log vào Google Cloud Logging để giám sát hệ thống
resource "google_project_iam_member" "log_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.k3s_sa.email}"
}

# Quyền giám sát hạ tầng
resource "google_project_iam_member" "monitoring_viewer" {
  project = var.project_id
  role    = "roles/monitoring.viewer"
  member  = "serviceAccount:${google_service_account.k3s_sa.email}"
}

# Quyền đọc dữ liệu từ Google Artifact Registry để K3s kéo Docker image (SpringBoot, Gin, FastAPI)
resource "google_project_iam_member" "gar_reader" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.k3s_sa.email}"
}