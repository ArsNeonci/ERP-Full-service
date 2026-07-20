# infra/terraform/main.tf

# 1. Gọi Module Security
module "security" {
  source     = "./security"      # Đường dẫn tới thư mục con
  
  # Bơm dữ liệu từ thư mục gốc vào module
  project_id = var.project_id
  region     = var.region
}

# 2. Gọi Module Core Infrastructure (Nằm trong thư mục main)
module "core_infra" {
  source     = "./main"          # Đường dẫn tới thư mục con

  # Bơm dữ liệu từ thư mục gốc vào
  project_id = var.project_id
  region     = var.region
  zone       = var.zone

  # Lấy Output từ Module Security truyền sang làm Input cho Module Core
  vpc_id       = module.security.vpc_id
  subnet_id    = module.security.subnet_id
  k3s_sa_email = module.security.k3s_sa_email

  # (Mẹo: depend_on đảm bảo mạng được tạo xong mới tạo máy chủ)
  depends_on = [module.security] 
}