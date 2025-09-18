resource "aws_elasticache_subnet_group" "this" {
  name       = "${var.cluster_name}-subnets"
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

resource "aws_security_group" "valkey" {
  name        = "${var.cluster_name}-valkey-sg"
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

resource "aws_security_group_rule" "eks_ingress_private" {
  type                     = "ingress"
  from_port                = var.valkey_port
  to_port                  = var.valkey_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.valkey.id
  description              = "Allow access to the database from EKS only"
  source_security_group_id = var.eks_cluster_security_group_id
}

resource "aws_elasticache_cluster" "this" {
  cluster_id                 = var.cluster_name
  engine                     = "valkey"
  port                       = var.valkey_port
  engine_version             = var.engine_version
  node_type                  = var.node_type
  num_cache_nodes            = var.num_cache_nodes
  subnet_group_name          = aws_elasticache_subnet_group.this.name
  security_group_ids         = [aws_security_group.valkey.id]
  parameter_group_name       = var.parameter_group_name
  maintenance_window         = var.maintenance_window
  apply_immediately          = true
  auto_minor_version_upgrade = true

  tags = var.tags
}
