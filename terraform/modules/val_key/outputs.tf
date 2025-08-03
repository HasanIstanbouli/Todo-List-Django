output "urn" {
  value = digitalocean_database_cluster.todo_val_key.urn
}
output "port" {
  value = digitalocean_database_cluster.todo_val_key.port
}
output "host" {
  value = digitalocean_database_cluster.todo_val_key.host
}
output "password" {
  value     = digitalocean_database_cluster.todo_val_key.password
  sensitive = true
}