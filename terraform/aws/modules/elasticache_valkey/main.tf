resource "aws_elasticache_subnet_group" "this" {
  name       = "${var.replication_group_id}-subnets"
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

resource "aws_security_group" "valkey" {
  name        = "${var.replication_group_id}-valkey-sg"
  description = "ValKey access"
  vpc_id      = var.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags
}

# Private access from EKS SG
resource "aws_security_group_rule" "eks_ingress_private" {
  type                     = "ingress"
  from_port                = var.valkey_port
  to_port                  = var.valkey_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.valkey.id
  description              = "Allow access to the database from EKS only"
  source_security_group_id = var.eks_cluster_security_group_id
}

resource "aws_elasticache_replication_group" "this" {
  description                = var.description
  replication_group_id       = var.replication_group_id
  engine                     = "valkey"
  port                       = var.valkey_port
  engine_version             = var.engine_version
  node_type                  = var.node_type
  num_cache_clusters         = var.num_cache_clusters
  subnet_group_name          = aws_elasticache_subnet_group.this.name
  security_group_ids         = [aws_security_group.valkey.id]
  parameter_group_name       = var.parameter_group_name
  maintenance_window         = var.maintenance_window
  automatic_failover_enabled = true
  apply_immediately          = true
  auto_minor_version_upgrade = true

  tags = var.tags
}

resource "aws_elasticache_user" "this" {
  user_id       = var.user_id
  user_name     = var.username
  access_string = var.access_string
  engine        = "valkey"

  authentication_mode {
    type      = "password"
    passwords = [var.password]
  }
  depends_on = [aws_elasticache_replication_group.this]
}
