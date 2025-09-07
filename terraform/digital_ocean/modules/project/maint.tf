resource "digitalocean_project" "todo-project" {
  name        = var.name
  description = "A dedicated project for TODO web app"
  environment = var.project_environment
  resources   = var.resources
}