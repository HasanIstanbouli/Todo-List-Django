resource "digitalocean_database_cluster" "todo-db" {
  engine     = "pg"
  name       = var.db_name
  version    = var.pg_version
  size       = var.db_cluster_size
  region     = var.region
  node_count = var.node_count
  project_id = var.project_id
}