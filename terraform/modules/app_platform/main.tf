resource "digitalocean_app" "todo" {
  spec {
    name   = var.app_name
    region = var.region
    service {
      name               = var.app_name
      run_command        = null
      instance_count     = var.instance_count
      instance_size_slug = var.instance_size_slug
      http_port          = var.http_port
      image {
        registry_type = "DOCR"
        repository    = var.image_repository
        tag           = var.image_tag
        deploy_on_push {
          enabled = var.auto_deploy
        }
      }
      dynamic "env" {
        for_each = var.environment_variables
        content {
          key   = env.key
          value = env.value.value
          scope = env.value.scope
          type  = env.value.type
        }
      }
    }
    worker {
      name               = var.celery_app_name
      run_command        = var.celery_run_command
      instance_count     = var.celery_instance_count
      instance_size_slug = var.celery_instance_size_slug
      image {
        registry_type = "DOCR"
        repository    = var.image_repository
        tag           = var.image_tag
        deploy_on_push {
          enabled = var.auto_deploy
        }
      }
      dynamic "env" {
        for_each = var.environment_variables
        content {
          key   = env.key
          value = env.value.value
          scope = env.value.scope
          type  = env.value.type
        }
      }
    }
    worker {
      name               = var.celery_beat_app_name
      run_command        = var.celery_beat_run_command
      instance_count     = var.celery_beat_instance_count
      instance_size_slug = var.celery_beat_instance_size_slug
      image {
        registry_type = "DOCR"
        repository    = var.image_repository
        tag           = var.image_tag
        deploy_on_push {
          enabled = var.auto_deploy
        }
      }
      dynamic "env" {
        for_each = var.environment_variables
        content {
          key   = env.key
          value = env.value.value
          scope = env.value.scope
          type  = env.value.type
        }
      }
    }
    ingress {
      rule {
        component {
          name = var.app_name
        }
        match {
          path {
            prefix = "/"
          }
        }
      }
    }
  }
}
