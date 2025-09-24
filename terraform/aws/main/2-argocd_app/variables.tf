variable "aws_region" {
  type = string
}
variable "kubernetes_cluster_name" {
  type = string
}
# ArgoCD
variable "argocd_namespace" {
  type        = string
  description = "Namespace for ArgoCD installation"
  default     = "argocd"
}
variable "argocd_application_name" {
  type        = string
  description = "Name of the ArgoCD application"
  default     = "todo-app"
}
variable "argocd_repo_url" {
  type        = string
  description = "Git repository URL for the application manifests"
}
variable "argocd_target_revision" {
  type        = string
  description = "Target revision/branch for the application"
  default     = "main"
}
variable "argocd_path" {
  type        = string
  description = "Path to the application manifests in the repository"
  default     = "k8s"
}
variable "kubernetes_todo_namespace" {
  type        = string
  description = "Destination namespace for the application"
}
