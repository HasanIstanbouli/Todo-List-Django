terraform {
  required_version = ">=1.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
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
provider "aws" {
  region = var.aws_region
}

# Data source to get cluster info
# Get cluster details from AWS
data "aws_eks_cluster" "this" {
  name = var.kubernetes_cluster_name
}

# Get cluster authentication token
data "aws_eks_cluster_auth" "this" {
  name = var.kubernetes_cluster_name
}
provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  token                  = data.aws_eks_cluster_auth.this.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
}
provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.this.endpoint
    token                  = data.aws_eks_cluster_auth.this.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  }
}
