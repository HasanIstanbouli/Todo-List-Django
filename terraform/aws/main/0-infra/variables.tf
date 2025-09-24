variable "aws_region" {
  type = string
}
# ========= Network ==========
variable "vpc_name" {
  type = string
}
variable "vpc_cidr" {
  type = string
}
variable "azs" {
  type = list(string)
}
variable "public_subnet_cidrs" {
  type = list(string)
}
variable "private_subnet_cidrs" {
  type = list(string)
}

# ========= EKS ==========
variable "cluster_name" {
  type = string
}
variable "kubernetes_version" {
  type    = string
  default = "1.34"
}
variable "desired_size" {
  type    = number
  default = 2
}
variable "min_size" {
  type    = number
  default = 1
}
variable "max_size" {
  type    = number
  default = 3
}
variable "instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}

# ========= ECR ==========
variable "ecr_repository_name" {
  type = string
}
variable "ecr_image_tag_mutability" {
  type    = string
  default = "MUTABLE"
}
variable "ecr_scan_on_push" {
  type    = bool
  default = true
}
variable "ecr_encryption_type" {
  type    = string
  default = "AES256"
}

# ========= RDS ==========
variable "db_name" {
  type = string
}
variable "rds_postgres_version" {
  type    = string
  default = "16"
}
variable "rds_instance_class" {
  type    = string
  default = "db.t4g.micro"
}
variable "rds_db_port" {
  type = number
}
variable "rds_db_username" {
  type = string
}
variable "rds_db_password" {
  type      = string
  sensitive = true
}
variable "rds_allocated_storage" {
  type = string
}
variable "rds_max_allocated_storage" {
  type = string
}
variable "rds_multi_az" {
  type    = bool
  default = true
}
variable "rds_publicly_accessible" {
  type    = bool
  default = false
}
variable "rds_backup_retention_period" {
  type    = number
  default = 7
}
variable "rds_deletion_protection" {
  type    = bool
  default = false
}
variable "rds_secret_name" {
  type = string
}
variable "rds_secret_description" {
  type = string
}

# ========= Elasticache ValKey ==========
variable "valkey_description" {
  type = string
}
variable "valkey_port" {
  type = number
}
variable "valkey_engine_version" {
  type    = string
  default = "8.0"
}
variable "valkey_user_group_id" {
  type = string
}
variable "valkey_replication_group_id" {
  type = string
}
variable "valkey_user_id" {
  type = string
}
variable "valkey_user_name" {
  type = string
}
variable "valkey_access_string" {
  type      = string
  sensitive = true
}
variable "valkey_password" {
  type      = string
  sensitive = true
}
variable "valkey_secret_name" {
  type = string
}
variable "valkey_secret_description" {
  type = string
}
