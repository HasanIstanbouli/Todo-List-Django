terraform {
  required_version = ">= 1.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
# Data source to get cluster info
data "aws_eks_cluster" "todo_cluster" {
  name = var.kubernetes_cluster_name
}
data "aws_eks_cluster_auth" "todo_cluster" {
  name = var.kubernetes_cluster_name
}
provider "kubernetes" {
  host                   = data.aws_eks_cluster.todo_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.todo_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.todo_cluster.token
}
provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.todo_cluster.endpoint
    token                  = data.aws_eks_cluster_auth.todo_cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.todo_cluster.certificate_authority[0].data)
  }
}
