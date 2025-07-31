module "project" {
  source              = "../../../modules/project"
  name                = var.todo_project_name
  project_environment = "Staging"
}
module "container_registry" {
  source            = "../../../modules/container_registry"
  name              = var.registry_name
  region            = var.region
  subscription_plan = var.container_registry_subscription_plan
}
