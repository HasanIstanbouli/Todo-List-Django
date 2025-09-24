variable "aws_region" {
  type = string
}
variable "rds_secret_id" {
  type = string
}
variable "valkey_secret_id" {
  type = string
}
# ========= Kubernetes ==========
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
