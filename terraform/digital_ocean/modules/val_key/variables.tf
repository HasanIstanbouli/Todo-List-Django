variable "val_key_name" {
  type        = string
  description = "The name of the ValKey cluster"
}
variable "cluster_size" {
  type        = string
  description = "ValKey database cluster size"
}
variable "val_key_version" {
  type        = string
  description = "ValKey version"
}
variable "region" {
  type        = string
  description = "ValKey database cluster region"
}
variable "node_count" {
  type        = number
  description = "Number of nodes for ValKey cluster"
}
variable "project_id" {
  type        = string
  description = "The ID of the attached DigitalOcean project"
}