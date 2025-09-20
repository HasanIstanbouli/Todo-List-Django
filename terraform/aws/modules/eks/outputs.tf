output "cluster_name" {
  value = aws_eks_cluster.todo_eks_cluster.name
}
output "cluster_endpoint" {
  value = aws_eks_cluster.todo_eks_cluster.endpoint
}
output "cluster_ca_certificate" {
  value = aws_eks_cluster.todo_eks_cluster.certificate_authority[0].data
}
output "node_group_name" {
  value = aws_eks_node_group.general.node_group_name
}
output "cluster_security_group_id" {
  value = aws_eks_cluster.todo_eks_cluster.vpc_config[0].cluster_security_group_id
}
