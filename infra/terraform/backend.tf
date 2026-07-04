# infra/terraform/backend.tf
# Cấu hình lưu state trên Google Cloud Storage (GCS)
terraform {
  backend "gcs" {
    bucket  = "arsneonci-erp-infra-tfstate" # ĐIỂM CẦN THAY ĐỔI: Tên bucket phải là duy nhất trên toàn cầu
    prefix  = "terraform/state"
  }
}