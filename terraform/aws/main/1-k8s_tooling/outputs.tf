# Data source to get the LoadBalancer's external IP/Hostname
data "kubernetes_service" "ingress_nginx_controller" {
  metadata {
    name      = "${helm_release.ingress_nginx.name}-controller" # Default service name
    namespace = kubernetes_namespace_v1.ingress_nginx.metadata[0].name
  }
  depends_on = [helm_release.ingress_nginx] # Ensure the service exists
}
# Output the Load Balancer URL
output "load_balancer_url" {
  value = "http://${coalesce(
    data.kubernetes_service.ingress_nginx_controller.status[0].load_balancer[0].ingress[0].hostname,
    data.kubernetes_service.ingress_nginx_controller.status[0].load_balancer[0].ingress[0].ip
  )}"
}
