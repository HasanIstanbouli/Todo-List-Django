variable "vpc_id" {
  type = string
}
variable "subnet_ids" {
  type = list(string)
}
variable "db_name" {
  type = string
}
variable "engine_version" {
  type    = string
  default = "16"
}
variable "instance_class" {
  type    = string
  default = "db.t4g.micro"
}
variable "db_username" {
  type = string
}
variable "db_password" {
  type      = string
  sensitive = true
}
variable "db_port" {
  type = number
}
variable "allocated_storage" {
  type    = number
  default = 20
}
variable "max_allocated_storage" {
  type    = number
  default = 100
}
variable "multi_az" {
  type    = bool
  default = false
}
variable "publicly_accessible" {
  type = bool
}
variable "db_backup_window" {
  type    = string
  default = "02:00-03:00"
}
variable "maintenance_window" {
  type    = string
  default = "sun:03:00-sun:04:00"
}
variable "backup_retention_period" {
  type    = number
  default = 7
}
variable "deletion_protection" {
  type    = bool
  default = false
}
variable "skip_final_snapshot" {
  type    = bool
  default = true
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "performance_insights_retention_period" {
  type    = number
  default = 7
}
variable "kms_rotation_period_in_days" {
  type    = number
  default = 90
}
variable "kms_deletion_window_in_days" {
  type    = number
  default = 15
}
variable "eks_cluster_security_group_id" {
  type = string
}
variable "rds_secret_name" {
  type = string
}
variable "rds_secret_description" {
  type = string
}
