locals {
  environment = terraform.workspace
  tags = {
    Project   = "todo-list-${terraform.workspace}"
    ManagedBy = "terraform"
  }
}

module "network" {
  source               = "../../modules/network"
  vpc_name             = "${var.vpc_name}-${local.environment}"
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  tags                 = local.tags
}

module "eks" {
  source             = "../../modules/eks"
  cluster_name       = "${var.cluster_name}-${local.environment}"
  kubernetes_version = var.kubernetes_version
  desired_size       = var.desired_size
  min_size           = var.min_size
  max_size           = var.max_size
  instance_types     = var.instance_types
  private_subnet_ids = module.network.private_subnet_ids
  tags               = local.tags
}

module "ecr" {
  source               = "../../modules/ecr"
  repository_name      = "${var.ecr_repository_name}-${local.environment}"
  image_tag_mutability = var.ecr_image_tag_mutability
  scan_on_push         = var.ecr_scan_on_push
  encryption_type      = var.ecr_encryption_type
  tags                 = local.tags
}

module "rds" {
  source                        = "../../modules/rds_postgres"
  vpc_id                        = module.network.vpc_id
  subnet_ids                    = module.network.private_subnet_ids
  db_name                       = "${var.db_name}${local.environment}"
  engine_version                = var.rds_postgres_version
  instance_class                = var.rds_instance_class
  db_port                       = var.rds_db_port
  eks_cluster_security_group_id = module.eks.cluster_security_group_id
  db_username                   = var.rds_db_username
  db_password                   = var.rds_db_password
  allocated_storage             = var.rds_allocated_storage
  max_allocated_storage         = var.rds_max_allocated_storage
  multi_az                      = var.rds_multi_az
  publicly_accessible           = var.rds_publicly_accessible
  backup_retention_period       = var.rds_backup_retention_period
  deletion_protection           = var.rds_deletion_protection
  tags                          = local.tags
  # RDS secret manager vars
  rds_secret_name        = "${var.rds_secret_name}-${local.environment}"
  rds_secret_description = "${var.rds_secret_description}-${local.environment}"
}


module "valkey" {
  source                        = "../../modules/elasticache_valkey"
  vpc_id                        = module.network.vpc_id
  description                   = var.valkey_description
  replication_group_id          = "${var.valkey_replication_group_id}-${local.environment}"
  subnet_ids                    = module.network.private_subnet_ids
  valkey_port                   = var.valkey_port
  engine_version                = var.valkey_engine_version
  eks_cluster_security_group_id = module.eks.cluster_security_group_id
  tags                          = local.tags
  # aws_elasticache_user vars
  user_id       = var.valkey_user_id
  username      = var.valkey_user_name
  access_string = var.valkey_access_string
  password      = var.valkey_password
  # aws_elasticache_user_group vars
  user_group_id = var.valkey_user_group_id
  # aws_secretsmanager_secret vars
  valkey_secret_name        = "${var.valkey_secret_name}-${local.environment}"
  valkey_secret_description = "${var.valkey_secret_description}-${local.environment}"
}
