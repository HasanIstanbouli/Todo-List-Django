output "kube_config" {
  value     = digitalocean_kubernetes_cluster.k8s.kube_config
  sensitive = true
}
output "endpoint" {
  value = digitalocean_kubernetes_cluster.k8s.endpoint
}
