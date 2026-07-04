# security/vpc.tf
# Cấu hình Virtual Private Cloud
resource "google_compute_network" "erp_vpc" {
  name                    = "erp-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "erp_subnet" {
  name          = "erp-k3s-subnet"
  ip_cidr_range = "10.0.10.0/24" # Dải IP nội bộ cho cụm cụm K3s
  region        = var.region
  network       = google_compute_network.erp_vpc.id
}