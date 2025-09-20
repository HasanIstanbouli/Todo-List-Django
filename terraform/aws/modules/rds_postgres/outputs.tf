output "db_endpoint" {
  value = aws_db_instance.this.address
}
output "db_port" {
  value = aws_db_instance.this.port
}
output "db_identifier" {
  value = aws_db_instance.this.id
}
output "db_name" {
  value = aws_db_instance.this.db_name
}
output "db_username" {
  value = aws_db_instance.this.username
}
output "db_password" {
  value     = aws_db_instance.this.password
  sensitive = true
}
