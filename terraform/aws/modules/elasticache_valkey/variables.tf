variable "vpc_id" {
  type = string
}
variable "subnet_ids" {
  type = list(string)
}
variable "description" {
  type = string
}
variable "replication_group_id" {
  type = string
}
variable "node_type" {
  type    = string
  default = "cache.t4g.micro"
}
variable "num_cache_clusters" {
  type    = number
  default = 2
}
variable "engine_version" {
  type    = string
  default = "8"
}
variable "parameter_group_name" {
  type    = string
  default = null
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "valkey_port" {
  type = number
}
variable "eks_cluster_security_group_id" {
  type = string
}
variable "maintenance_window" {
  type    = string
  default = "sun:03:00-sun:04:00"
}
variable "user_id" {
  type = string
}
variable "username" {
  type = string
}
variable "access_string" {
  type      = string
  sensitive = true
}
variable "password" {
  type      = string
  sensitive = true
}
