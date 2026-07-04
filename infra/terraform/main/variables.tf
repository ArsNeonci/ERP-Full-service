# main/variables.tf
variable "project_id" { type = string }
variable "region" { type = string }
variable "zone" { type = string }

# Các biến nhận từ module Security truyền sang
variable "vpc_id" { type = string }
variable "subnet_id" { type = string }
variable "k3s_sa_email" { type = string }