resource "digitalocean_database_cluster" "todo_val_key" {
  name       = var.val_key_name
  engine     = "valkey"
  version    = var.val_key_version
  size       = var.cluster_size
  region     = var.region
  node_count = var.node_count
  project_id = var.project_id
}