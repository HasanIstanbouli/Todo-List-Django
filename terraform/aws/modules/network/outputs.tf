output "vpc_id" {
  value = aws_vpc.todo_vpc.id
}
output "public_subnet_ids" {
  value = [for s in aws_subnet.public : s.id]
}
output "private_subnet_ids" {
  value = [for s in aws_subnet.private : s.id]
}
output "elastic_ip" {
  description = "Elastic public IP address"
  value       = { for k, v in aws_eip.nat : k => v.public_ip }
}
