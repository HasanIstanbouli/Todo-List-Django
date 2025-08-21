variable "region" {
  type = string
}
variable "cluster_name" {
  type = string
}
variable "node_pool_name" {
  type = string
}
variable "node_size" {
  type = string
}
variable "min_nodes" {
  type    = number
  default = 1
}
variable "max_nodes" {
  type    = number
  default = 3
}
# optional: override k8s version; if empty we'll pick the latest available
variable "k8s_version" {
  type = string
}
variable "maintenance_policy_start_time" {
  type        = string
  description = "The time in UTC of the maintenance window policy in 24-hour format"
  default     = "04:00"
}
variable "maintenance_policy_day" {
  type    = string
  default = "sunday"
}
variable "tags" {
  type    = list(string)
  default = null
}
variable "registry_integration" {
  type    = bool
  default = false
}
variable "is_high_availability" {
  type    = bool
  default = false
}
