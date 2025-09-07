# ArgoCD Application
resource "kubernetes_manifest" "argocd_application" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = var.argocd_application_name
      namespace = var.argocd_namespace
    }
    spec = {
      project = "default"
      source = {
        repoURL        = var.argocd_repo_url
        targetRevision = var.argocd_target_revision
        path           = var.argocd_path
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = var.kubernetes_todo_namespace
      }
      syncPolicy = {
        automated = {
          prune      = true
          selfHeal   = true
          allowEmpty = false
        }
        syncOptions = [
          "CreateNamespace=false",
          "PrunePropagationPolicy=foreground",
          "PruneLast=true"
        ]
      }
    }
  }
}
