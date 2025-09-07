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
# Val-Key (Redis)
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
# Kubernetes
variable "kubernetes_node_pool_name" {
  type = string
}
variable "kubernetes_node_size" {
  type = string
}
variable "kubernetes_min_nodes" {
  type = number
}
variable "kubernetes_max_nodes" {
  type = number
}
variable "kubernetes_maintenance_policy_start_time" {
  type = string
}
variable "kubernetes_maintenance_policy_day" {
  type = string
}
variable "kubernetes_tags" {
  type = list(string)
}
variable "kubernetes_registry_integration" {
  type = bool
}
variable "kubernetes_is_high_availability" {
  type = bool
}
variable "kubernetes_cluster_name" {
  type = string
}
variable "kubernetes_todo_namespace" {
  type = string
}
variable "kubernetes_todo_secret_name" {
  type      = string
  sensitive = true
}
variable "django_secret_key" {
  type      = string
  sensitive = true
}
variable "django_fernet_key" {
  type      = string
  sensitive = true
}
variable "django_superuser_password" {
  type      = string
  sensitive = true
}
variable "django_superuser_email" {
  type      = string
  sensitive = true
}
variable "django_email_host" {
  type      = string
  sensitive = true
}
variable "django_email_host_user" {
  type      = string
  sensitive = true
}
variable "django_email_host_password" {
  type      = string
  sensitive = true
}
variable "kubernetes_ingress_namespace" {
  type = string
}
variable "kubernetes_todo_config_name" {
  type = string
}
variable "django_allowed_hosts" {
  type      = string
  sensitive = true
}
variable "django_csrf_trusted_origins" {
  type      = string
  sensitive = true
}
variable "django_time_zone" {
  type = string
}
variable "django_is_debug" {
  type      = string
  sensitive = true
}
variable "django_todo_backend_port" {
  type = string
}
variable "django_superuser_username" {
  type = string
}
variable "django_superuser_first_name" {
  type = string
}
variable "django_superuser_last_name" {
  type = string
}
variable "django_email_backend" {
  type = string
}
variable "django_email_use_tls" {
  type = string
}
variable "django_email_port" {
  type = string
}
variable "django_celery_timezone" {
  type = string
}
variable "django_redis_use_tls" {
  type = string
}
variable "django_db_ssl_mode" {
  type = string
}
variable "django_db_engine" {
  type      = string
  sensitive = true
}
# ArgoCD
variable "argocd_namespace" {
  type        = string
  description = "Namespace for ArgoCD installation"
  default     = "argocd"
}
variable "argocd_admin_password" {
  type        = string
  description = "Admin password for ArgoCD"
  sensitive   = true
}
