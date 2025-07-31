resource "digitalocean_container_registry" "todo_container_registry" {
  name                   = var.name
  subscription_tier_slug = var.subscription_plan
  region                 = var.region
}