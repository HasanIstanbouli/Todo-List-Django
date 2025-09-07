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
provider "kubernetes" {
  host                   = module.kubernetes_cluster.endpoint
  token                  = module.kubernetes_cluster.kube_config[0].token
  cluster_ca_certificate = base64decode(module.kubernetes_cluster.kube_config[0].cluster_ca_certificate)
}
provider "helm" {
  kubernetes = {
    host                   = module.kubernetes_cluster.endpoint
    token                  = module.kubernetes_cluster.kube_config[0].token
    cluster_ca_certificate = base64decode(module.kubernetes_cluster.kube_config[0].cluster_ca_certificate)
  }
}
