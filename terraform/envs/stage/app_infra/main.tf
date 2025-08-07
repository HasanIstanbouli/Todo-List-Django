data "digitalocean_project" "todo_project" {
  name = var.todo_project_name
}
module "db" {
  source          = "../../../modules/pg_database"
  region          = var.region
  db_name         = var.db_name
  db_cluster_size = var.db_cluster_size
  pg_version      = var.db_pg_version
  node_count      = var.db_node_count
  project_id      = data.digitalocean_project.todo_project.id
}
module "valkey" {
  source          = "../../../modules/val_key"
  region          = var.region
  val_key_name    = var.val_key_name
  cluster_size    = var.val_key_cluster_size
  val_key_version = var.val_key_version
  node_count      = var.val_key_node_count
  project_id      = data.digitalocean_project.todo_project.id
}
module "todo_app_platform" {
  depends_on = [module.valkey, module.db]
  source                         = "../../../modules/app_platform"
  region                         = var.region
  app_name                       = var.app_name
  image_tag                      = var.image_tag
  image_repository               = var.image_repository
  auto_deploy                    = var.app_platform_auto_deploy
  instance_count                 = var.instance_count
  instance_size_slug             = var.instance_size_slug
  http_port                      = var.http_port
  celery_app_name                = var.celery_app_name
  celery_run_command             = var.celery_run_command
  celery_instance_count          = var.celery_instance_count
  celery_instance_size_slug      = var.celery_instance_size_slug
  celery_beat_app_name           = var.celery_beat_app_name
  celery_beat_run_command        = var.celery_beat_run_command
  celery_beat_instance_count     = var.celery_beat_instance_count
  celery_beat_instance_size_slug = var.celery_beat_instance_size_slug
  environment_variables = {
    "SECRET_KEY" = {
      value = var.SECRET_KEY
      scope = "RUN_TIME"
      type  = "SECRET"
    }
    "FERNET_KEY" = {
      value = var.FERNET_KEY
      scope = "RUN_TIME"
      type  = "SECRET"
    }
    "ALLOWED_HOSTS" = {
      value = var.ALLOWED_HOSTS
      scope = "RUN_TIME"
      type  = "SECRET"
    }
    "CSRF_TRUSTED_ORIGINS" = {
      value = var.CSRF_TRUSTED_ORIGINS
      scope = "RUN_TIME"
      type  = "SECRET"
    }
    "TIME_ZONE" = {
      value = var.TIME_ZONE
      scope = "RUN_TIME"
      type  = "GENERAL"
    }
    "IS_DEBUG" = {
      value = var.IS_DEBUG
      scope = "RUN_TIME"
      type  = "GENERAL"
    }
    "TODO_BACKEND_PORT" = {
      value = var.http_port
      scope = "RUN_TIME"
      type  = "GENERAL"
    }
    "DJANGO_SUPERUSER_USERNAME" = {
      value = var.DJANGO_SUPERUSER_USERNAME
      scope = "RUN_TIME"
      type  = "GENERAL"
    }
    "DJANGO_SUPERUSER_FIRST_NAME" = {
      value = var.DJANGO_SUPERUSER_FIRST_NAME
      scope = "RUN_TIME"
      type  = "GENERAL"
    }
    "DJANGO_SUPERUSER_LAST_NAME" = {
      value = var.DJANGO_SUPERUSER_LAST_NAME
      scope = "RUN_TIME"
      type  = "GENERAL"
    }
    "DJANGO_SUPERUSER_EMAIL" = {
      value = var.DJANGO_SUPERUSER_EMAIL
      scope = "RUN_TIME"
      type  = "GENERAL"
    }
    "DJANGO_SUPERUSER_PASSWORD" = {
      value = var.DJANGO_SUPERUSER_PASSWORD
      scope = "RUN_TIME"
      type  = "SECRET"
    }
    "EMAIL_BACKEND" = {
      value = var.EMAIL_BACKEND
      scope = "RUN_TIME"
      type  = "GENERAL"
    }
    "EMAIL_HOST" = {
      value = var.EMAIL_HOST
      scope = "RUN_TIME"
      type  = "GENERAL"
    }
    "EMAIL_PORT" = {
      value = var.EMAIL_PORT
      scope = "RUN_TIME"
      type  = "GENERAL"
    }
    "EMAIL_USE_TLS" = {
      value = var.EMAIL_USE_TLS
      scope = "RUN_TIME"
      type  = "GENERAL"
    }
    "EMAIL_HOST_USER" = {
      value = var.EMAIL_HOST_USER
      scope = "RUN_TIME"
      type  = "GENERAL"
    }
    "EMAIL_HOST_PASSWORD" = {
      value = var.EMAIL_HOST_PASSWORD
      scope = "RUN_TIME"
      type  = "SECRET"
    }
    "DB_USER" = {
      value = module.db.username
      scope = "RUN_TIME"
      type  = "GENERAL"
    }
    "DB_PASSWORD" = {
      value = module.db.password
      scope = "RUN_TIME"
      type  = "SECRET"
    }
    "DB_NAME" = {
      value = module.db.database_name
      scope = "RUN_TIME"
      type  = "GENERAL"
    }
    "DB_PORT" = {
      value = module.db.port
      scope = "RUN_TIME"
      type  = "GENERAL"
    }
    "DB_HOST" = {
      value = module.db.public_host
      scope = "RUN_TIME"
      type  = "GENERAL"
    }
    "DB_ENGINE" = {
      value = var.DB_ENGINE
      scope = "RUN_TIME"
      type  = "GENERAL"
    }
    "DB_SSL_MODE" = {
      value = var.DB_SSL_MODE
      scope = "RUN_TIME"
      type  = "GENERAL"
    }
    "REDIS_USE_TLS" = {
      value = var.REDIS_USE_TLS
      scope = "RUN_TIME"
      type  = "GENERAL"
    }
    "REDIS_PORT" = {
      value = module.valkey.port
      scope = "RUN_TIME"
      type  = "GENERAL"
    }
    "REDIS_HOST" = {
      value = module.valkey.host
      scope = "RUN_TIME"
      type  = "GENERAL"
    }
    "REDIS_PASSWORD" = {
      value = module.valkey.password
      scope = "RUN_TIME"
      type  = "SECRET"
    }
    CELERY_TIMEZONE = {
      value = var.CELERY_TIMEZONE
      scope = "RUN_TIME"
      type  = "GENERAL"
    }
  }
}