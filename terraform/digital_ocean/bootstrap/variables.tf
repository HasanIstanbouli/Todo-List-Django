variable "do_token" {
  type        = string
  description = "The DO token to use"
}
variable "region" {
  type    = string
  default = "fra1"
}
variable "registry_name" {
  description = "Name of your DigitalOcean Container Registry"
  type        = string
}
variable "container_registry_subscription_plan" {
  description = "The subscription plan for container registry"
  type        = string
}
variable "todo_project_name" {
  description = "The name of Todo project"
  type        = string
}