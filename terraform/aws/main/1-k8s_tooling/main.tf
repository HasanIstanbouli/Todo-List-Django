locals {
  environment = terraform.workspace
}
# Retrieve the secret
data "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = var.rds_secret_id
}
data "aws_secretsmanager_secret_version" "valkey_credentials" {
  secret_id = var.valkey_secret_id
}
# Parse the JSON secret
locals {
  db_credentials     = jsondecode(data.aws_secretsmanager_secret_version.db_credentials.secret_string)
  valkey_credentials = jsondecode(data.aws_secretsmanager_secret_version.valkey_credentials.secret_string)
}

resource "kubernetes_namespace_v1" "todo" {
  metadata {
    name = "${var.kubernetes_todo_namespace}-${local.environment}"
  }
}
resource "kubernetes_secret" "todo" {
  metadata {
    name      = var.kubernetes_todo_secret_name
    namespace = kubernetes_namespace_v1.todo.metadata[0].name
  }
  data = {
    # DB
    DB_HOST     = local.db_credentials.host
    DB_PORT     = local.db_credentials.port
    DB_NAME     = local.db_credentials.db_name
    DB_USER     = local.db_credentials.username
    DB_PASSWORD = local.db_credentials.password
    # Redis
    REDIS_PORT     = local.valkey_credentials.port
    REDIS_HOST     = local.valkey_credentials.primary_endpoint
    REDIS_PASSWORD = local.valkey_credentials.password
    REDIS_USERNAME = local.valkey_credentials.username
    # Django
    SECRET_KEY                = var.django_secret_key
    FERNET_KEY                = var.django_fernet_key
    DJANGO_SUPERUSER_PASSWORD = var.django_superuser_password
    DJANGO_SUPERUSER_EMAIL    = var.django_superuser_email
    EMAIL_HOST                = var.django_email_host
    EMAIL_HOST_USER           = var.django_email_host_user
    EMAIL_HOST_PASSWORD       = var.django_email_host_password
  }
  type = "Opaque"
}
resource "kubernetes_config_map" "todo_config" {
  metadata {
    name      = var.kubernetes_todo_config_name
    namespace = kubernetes_namespace_v1.todo.metadata[0].name
  }
  data = {
    ALLOWED_HOSTS               = var.django_allowed_hosts
    CSRF_TRUSTED_ORIGINS        = var.django_csrf_trusted_origins
    TIME_ZONE                   = var.django_time_zone
    IS_DEBUG                    = var.django_is_debug
    TODO_BACKEND_PORT           = var.django_todo_backend_port
    DJANGO_SUPERUSER_USERNAME   = var.django_superuser_username
    DJANGO_SUPERUSER_FIRST_NAME = var.django_superuser_first_name
    DJANGO_SUPERUSER_LAST_NAME  = var.django_superuser_last_name
    EMAIL_BACKEND               = var.django_email_backend
    EMAIL_USE_TLS               = var.django_email_use_tls
    EMAIL_PORT                  = var.django_email_port
    CELERY_TIMEZONE             = var.django_celery_timezone
    REDIS_USE_TLS               = var.django_redis_use_tls
    DB_SSL_MODE                 = var.django_db_ssl_mode
    DB_ENGINE                   = var.django_db_engine
  }
}

resource "kubernetes_namespace_v1" "ingress_nginx" {
  metadata {
    name = "${var.kubernetes_ingress_namespace}-${local.environment}"
  }
}
resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.13.1"
  namespace  = kubernetes_namespace_v1.ingress_nginx.metadata[0].name
  set = [
    {
      name  = "controller.service.type"
      value = "LoadBalancer"
    },
    {
      name  = "controller.metrics.enabled"
      value = "true"
    },
    # {
    #   name  = "controller.metrics.serviceMonitor.enabled"
    #   value = "true"
    # }
  ]
}
# ArgoCD Namespace
resource "kubernetes_namespace_v1" "argocd" {
  metadata {
    name = "${var.argocd_namespace}-${local.environment}"
  }
}
# Install ArgoCD using Helm
resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.51.6"
  namespace  = kubernetes_namespace_v1.argocd.metadata[0].name
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
  depends_on = [helm_release.ingress_nginx]
}
