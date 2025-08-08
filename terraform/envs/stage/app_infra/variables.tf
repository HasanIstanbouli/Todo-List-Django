variable "do_token" {
  type        = string
  description = "The DO token to use"
}
variable "todo_project_name" {
  description = "The name of Todo project"
  type        = string
}
variable "region" {
  type    = string
  default = "fra1"
}
# DB
variable "db_name" {
  type        = string
  description = "Database name"
}
variable "db_cluster_size" {
  type        = string
  description = "The size of the Database cluster"
}
variable "db_pg_version" {
  type        = string
  description = "The PostgreSQL version"
}
variable "db_node_count" {
  type        = string
  description = "Number of nodes for database cluster"
}
# Val-Key
variable "val_key_name" {
  type        = string
  description = "The name of the Val-Key cluster"
}
variable "val_key_cluster_size" {
  type        = string
  description = "The size of Val-Key cluster "
}
variable "val_key_version" {
  type        = string
  description = "Version of Val-Key"
}
variable "val_key_node_count" {
  type        = string
  description = "Number of nodes for Val-Key cluster"
}
# App-Platform
variable "app_name" {
  description = "Name of the App Platform app"
  type        = string
}
variable "image_tag" {
  description = "Image tag to deploy"
  type        = string
  default     = "latest"
}
variable "image_repository" {
  type        = string
  description = "The repository docker image name"
}
variable "app_platform_auto_deploy" {
  type        = bool
  description = "Whether to automatically deploy images pushed to DOCR"
}
variable "instance_count" {
  description = "Number of instances"
  type        = number
}
variable "instance_size_slug" {
  description = "Size of the instance (e.g., 'basic-xxs')"
  type        = string
  # default     = "basic-xxs"
}
variable "http_port" {
  type        = number
  description = "Running port inside the docker container"
}
# App-Platform - Celery
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
# Django
variable "SECRET_KEY" {
  type        = string
  description = "The djagno secret key"
}
variable "FERNET_KEY" {
  type        = string
  description = "FERNET_KEY value"
}
variable "ALLOWED_HOSTS" {
  type        = string
  description = "Allowed hosts for Django"
}
variable "CSRF_TRUSTED_ORIGINS" {
  type        = string
  description = "Allowed CSRF Origins"
}
variable "TIME_ZONE" {
  type        = string
  description = "Django timezone"
}
variable "IS_DEBUG" {
  type        = string
  description = "Enable/Disable Django debug"
}
# Django - SuperUser variables
variable "DJANGO_SUPERUSER_USERNAME" {
  type = string
}
variable "DJANGO_SUPERUSER_FIRST_NAME" {
  type = string
}
variable "DJANGO_SUPERUSER_LAST_NAME" {
  type = string
}
variable "DJANGO_SUPERUSER_EMAIL" {
  type = string
}
variable "DJANGO_SUPERUSER_PASSWORD" {
  type = string
}
# Django - Email variables
variable "EMAIL_BACKEND" {
  type        = string
  description = "Email backend for the app"
}
variable "EMAIL_HOST" {
  type        = string
  description = "Email host for the app"
}
variable "EMAIL_PORT" {
  type        = string
  description = "Email port for the app"
}
variable "EMAIL_USE_TLS" {
  type        = string
  description = "Use TLS for the email connection"
}
variable "EMAIL_HOST_USER" {
  type        = string
  description = "Email host user for the app"
}
variable "EMAIL_HOST_PASSWORD" {
  type        = string
  description = "Email host password for the app"
}
# Database variables
variable "DB_ENGINE" {
  type        = string
  description = "Database engine for the app"
}
variable "DB_SSL_MODE" {
  type        = string
  description = "Database SSL mode for the app"
}
# Redis variables
variable "REDIS_USE_TLS" {
  type        = string
  description = "Use TLS for the redis connection"
}
# Celery
variable "CELERY_TIMEZONE" {
  type        = string
  description = "Celery timezone"
}