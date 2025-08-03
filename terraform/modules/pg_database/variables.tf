variable "db_name" {
  type        = string
  description = "Name of the database"
}
variable "pg_version" {
  type        = string
  description = "Postgres version"
}
variable "db_cluster_size" {
  type        = string
  description = "Database cluster size"
}
variable "region" {
  type        = string
  description = "Database cluster region"
}
variable "node_count" {
  type        = number
  description = "Number of nodes for DB cluster"
}
variable "project_id" {
  type        = string
  description = "The ID of the attached DigitalOcean project"
}