output "private_host" {
  value = digitalocean_database_cluster.todo-db.private_host
}
output "port" {
  value = digitalocean_database_cluster.todo-db.port
}
output "private_uri" {
  value = digitalocean_database_cluster.todo-db.private_uri
}
output "database_name" {
  value = digitalocean_database_cluster.todo-db.database
}
output "username" {
  value     = digitalocean_database_cluster.todo-db.user
  sensitive = true
}
output "password" {
  value     = digitalocean_database_cluster.todo-db.password
  sensitive = true
}
output "urn" {
  value = digitalocean_database_cluster.todo-db.urn
}
output "public_host" {
  value = digitalocean_database_cluster.todo-db.host
}