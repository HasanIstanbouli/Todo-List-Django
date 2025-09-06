# ArgoCD Namespace
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.argocd_namespace
  }
}
# Install ArgoCD using Helm
resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.51.6"
  namespace  = var.argocd_namespace
  set = [
    {
      name  = "configs.params.server\\.insecure"
      value = "true"
    },
    {
      name  = "server.ingress.enabled"
      value = "true"
    },
    {
      name  = "server.ingress.ingressClassName"
      value = "nginx"
    },
    {
      name  = "server.ingress.paths[0]"
      value = "/argocd"
    },
    {
      name  = "server.ingress.pathType"
      value = "Prefix"
    },
    {
      name  = "configs.params.server\\.basehref"
      value = "/argocd"
    },
    {
      name  = "configs.params.server\\.rootpath"
      value = "/argocd"
    },
    {
      name  = "configs.secret.argocdServerAdminPassword"
      value = bcrypt(var.argocd_admin_password)
    },
  ]
  depends_on = [kubernetes_namespace.argocd]
}
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
  depends_on = [helm_release.argocd]
}
