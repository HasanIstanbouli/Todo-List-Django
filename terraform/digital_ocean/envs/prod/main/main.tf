data "digitalocean_project" "todo_project" {
  name = var.todo_project_name
}
module "db" {
  source          = "../../../modules/pg_database"
  region          = var.region
  db_name         = var.db_name
  db_cluster_size = var.db_cluster_size
  pg_version      = var.db_pg_version
  node_count      = var.db_node_count
  project_id      = data.digitalocean_project.todo_project.id
}
module "valkey" {
  source          = "../../../modules/val_key"
  region          = var.region
  val_key_name    = var.val_key_name
  cluster_size    = var.val_key_cluster_size
  val_key_version = var.val_key_version
  node_count      = var.val_key_node_count
  project_id      = data.digitalocean_project.todo_project.id
}

data "digitalocean_kubernetes_versions" "available" {
  # Get the latest available DO Kubernetes versions (we'll pick index 0)
}
module "kubernetes_cluster" {
  source                        = "../../../modules/kubernetes"
  cluster_name                  = var.kubernetes_cluster_name
  region                        = var.region
  k8s_version                   = data.digitalocean_kubernetes_versions.available.valid_versions[0]
  node_pool_name                = var.kubernetes_node_pool_name
  node_size                     = var.kubernetes_node_size
  min_nodes                     = var.kubernetes_min_nodes
  max_nodes                     = var.kubernetes_max_nodes
  maintenance_policy_start_time = var.kubernetes_maintenance_policy_start_time
  maintenance_policy_day        = var.kubernetes_maintenance_policy_day
  tags                          = var.kubernetes_tags
  registry_integration          = var.kubernetes_registry_integration
  is_high_availability          = var.kubernetes_is_high_availability
}
resource "kubernetes_namespace" "todo" {
  metadata {
    name = var.kubernetes_todo_namespace
  }
}
resource "kubernetes_secret" "todo" {
  metadata {
    name      = var.kubernetes_todo_secret_name
    namespace = var.kubernetes_todo_namespace
  }
  data = {
    # DB
    DB_HOST     = module.db.private_host
    DB_PORT     = module.db.port
    DB_NAME     = module.db.database_name
    DB_USER     = module.db.username
    DB_PASSWORD = module.db.password
    # Redis
    REDIS_PORT     = module.valkey.port
    REDIS_HOST     = module.valkey.host
    REDIS_PASSWORD = module.valkey.password
    REDIS_USERNAME = module.valkey.username
    # Django
    SECRET_KEY                = var.django_secret_key
    FERNET_KEY                = var.django_fernet_key
    DJANGO_SUPERUSER_PASSWORD = var.django_superuser_password
    DJANGO_SUPERUSER_EMAIL    = var.django_superuser_email
    EMAIL_HOST                = var.django_email_host
    EMAIL_HOST_USER           = var.django_email_host_user
    EMAIL_HOST_PASSWORD       = var.django_email_host_password
  }
  type       = "Opaque"
  depends_on = [module.db, module.valkey, module.kubernetes_cluster, kubernetes_namespace.todo]
}
resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = var.kubernetes_ingress_namespace
  }
}
resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.13.1"
  namespace  = var.kubernetes_ingress_namespace
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
  depends_on = [kubernetes_namespace.ingress_nginx, module.kubernetes_cluster]
}
