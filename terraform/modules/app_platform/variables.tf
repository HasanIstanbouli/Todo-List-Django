variable "app_name" {
  description = "Name of the App Platform app"
  type        = string
}
variable "region" {
  description = "DigitalOcean region for the App Platform"
  type        = string
}
variable "image_repository" {
  description = "Repository name in your DOCR registry"
  type        = string
}
variable "image_tag" {
  description = "Image tag to deploy"
  type        = string
  default     = "latest"
}
variable "instance_count" {
  description = "Number of instances"
  type        = number
}
variable "instance_size_slug" {
  description = "Size of the instance (e.g., 'basic-xxs')"
  type        = string
}
variable "auto_deploy" {
  type        = bool
  default     = false
  description = "Whether to automatically deploy images pushed to DOCR"
}
variable "http_port" {
  type        = number
  description = "Running port inside the docker container"
}
variable "environment_variables" {
  description = "Environment variables to add to the app (mimicking .env file)"
  type = map(object({
    value = string
    scope = string
    type  = string
  }))
}
variable "celery_app_name" {
  type        = string
  description = "Name of the celery app"
}
variable "celery_run_command" {
  type        = string
  description = "Run command for the celery app"
}
variable "celery_instance_count" {
  type        = number
  description = "Number of instances for the celery app"
}
variable "celery_instance_size_slug" {
  type        = string
  description = "Size of the instance for the celery app"
}
variable "celery_beat_app_name" {
  type        = string
  description = "Name of the celery beat app"
}
variable "celery_beat_run_command" {
  type        = string
  description = "Run command for the celery beat app"
}
variable "celery_beat_instance_count" {
  type        = number
  description = "Number of instances for the celery beat app"
}
variable "celery_beat_instance_size_slug" {
  type        = string
  description = "Size of the instance for the celery beat app"
}