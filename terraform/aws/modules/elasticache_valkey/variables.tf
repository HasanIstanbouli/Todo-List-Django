variable "vpc_id" {
  type = string
}
variable "subnet_ids" {
  type = list(string)
}
variable "cluster_name" {
  type = string
}
variable "node_type" {
  type    = string
  default = "cache.t4g.micro"
}
variable "num_cache_nodes" {
  type    = number
  default = 1
}
variable "engine_version" {
  type    = string
  default = "7.1"
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
