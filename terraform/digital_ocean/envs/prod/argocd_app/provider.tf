terraform {
  required_version = ">=1.2"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 3.0"
    }
  }
}
provider "digitalocean" {
  token = var.do_token
}
# Data source to get cluster info
data "digitalocean_kubernetes_cluster" "todo_cluster" {
  name = var.kubernetes_cluster_name
}
provider "kubernetes" {
  host                   = data.digitalocean_kubernetes_cluster.todo_cluster.endpoint
  token                  = data.digitalocean_kubernetes_cluster.todo_cluster.kube_config[0].token
  cluster_ca_certificate = base64decode(data.digitalocean_kubernetes_cluster.todo_cluster.kube_config[0].cluster_ca_certificate)
}
provider "helm" {
  kubernetes = {
    host                   = data.digitalocean_kubernetes_cluster.todo_cluster.endpoint
    token                  = data.digitalocean_kubernetes_cluster.todo_cluster.kube_config[0].token
    cluster_ca_certificate = base64decode(data.digitalocean_kubernetes_cluster.todo_cluster.kube_config[0].cluster_ca_certificate)
  }
}
