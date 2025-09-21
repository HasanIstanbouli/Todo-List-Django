resource "aws_db_subnet_group" "this" {
  name       = "${var.db_name}-subnets"
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

resource "aws_security_group" "rds" {
  name        = "${var.db_name}-rds-sg"
  description = "RDS access"
  vpc_id      = var.vpc_id
  egress {
    description = "allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags
}
# TODO: Use VPN instead of public access
resource "aws_security_group_rule" "public_access" {
  count             = var.publicly_accessible ? 1 : 0
  type              = "ingress"
  from_port         = var.db_port
  to_port           = var.db_port
  protocol          = "tcp"
  security_group_id = aws_security_group.rds.id
  description       = "Allow external access to the database"
  cidr_blocks       = ["0.0.0.0/0"]
}
# Private access (from EKS SG only) if publicly_accessible = false
resource "aws_security_group_rule" "eks_private_access" {
  count                    = var.publicly_accessible ? 0 : 1
  type                     = "ingress"
  from_port                = var.db_port
  to_port                  = var.db_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds.id
  description              = "Allow access to the database from EKS only"
  source_security_group_id = var.eks_cluster_security_group_id
}

# Optional: A KMS key for encryption. Using the default RDS key is fine, but this is more secure and flexible.
resource "aws_kms_key" "rds_kms_key" {
  description             = "KMS key for RDS encryption and backups"
  is_enabled              = true
  enable_key_rotation     = true
  rotation_period_in_days = var.kms_rotation_period_in_days
  deletion_window_in_days = var.kms_deletion_window_in_days
}

resource "aws_db_instance" "this" {
  identifier     = var.db_name
  engine         = "postgres"
  engine_version = var.engine_version
  instance_class = var.instance_class
  db_name        = var.db_name
  username       = var.db_username
  password       = var.db_password
  # TODO: enable this option and make the related changes accordingly
  # manage_master_user_password = true
  port                      = var.db_port
  allocated_storage         = var.allocated_storage
  max_allocated_storage     = var.max_allocated_storage
  db_subnet_group_name      = aws_db_subnet_group.this.name
  vpc_security_group_ids    = [aws_security_group.rds.id]
  multi_az                  = var.multi_az
  publicly_accessible       = var.publicly_accessible
  backup_window             = var.db_backup_window
  backup_retention_period   = var.backup_retention_period
  maintenance_window        = var.maintenance_window
  deletion_protection       = var.deletion_protection
  skip_final_snapshot       = false
  final_snapshot_identifier = "${var.db_name}-final-snapshot"
  apply_immediately         = true
  storage_encrypted         = true
  kms_key_id                = aws_kms_key.rds_kms_key.arn
  # Enable Performance Insights for monitoring
  performance_insights_enabled          = true
  performance_insights_kms_key_id       = aws_kms_key.rds_kms_key.arn
  performance_insights_retention_period = var.performance_insights_retention_period
  auto_minor_version_upgrade            = true

  tags = var.tags
}

resource "aws_secretsmanager_secret" "rds_credentials" {
  name        = var.rds_secret_name
  description = var.rds_secret_description
  tags        = var.tags
}
resource "aws_secretsmanager_secret_version" "rds_credentials" {
  secret_id = aws_secretsmanager_secret.rds_credentials.id
  secret_string = jsonencode({
    username = aws_db_instance.this.username
    password = aws_db_instance.this.password
    host     = aws_db_instance.this.endpoint
    port     = aws_db_instance.this.port
    db_name  = aws_db_instance.this.db_name
  })
}
