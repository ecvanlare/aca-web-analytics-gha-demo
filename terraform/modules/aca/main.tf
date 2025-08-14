resource "azurerm_log_analytics_workspace" "aca" {
  name                = "${var.name}-log-analytics-workspace"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.log_analytics_workspace_sku
  retention_in_days   = var.log_analytics_workspace_retention_in_days

  tags = var.tags
}

resource "azurerm_container_app_environment" "aca" {
  name                       = "${var.name}-container-app-environment"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.aca.id
}

resource "azurerm_container_app" "aca" {
  name                         = "${var.name}-container-app"
  container_app_environment_id = azurerm_container_app_environment.aca.id
  resource_group_name          = var.resource_group_name
  revision_mode                = var.revision_mode

  template {
    container {
      name   = "${var.name}-container"
      image  = var.image
      cpu    = var.cpu
      memory = var.memory

      dynamic "env" {
        for_each = var.environment_variables
        content {
          name  = env.key
          value = env.value
        }
      }

      dynamic "env" {
        for_each = var.secrets
        content {
          name        = upper(replace(env.value.name, "-", "_"))
          secret_name = env.value.name
        }
      }
    }
  }

  dynamic "secret" {
    for_each = var.secrets
    content {
      name  = secret.value.name
      value = secret.value.value
    }
  }

  registry {
    server   = var.registry_server
    identity = var.registry_identity
  }

  ingress {
    allow_insecure_connections = var.allow_insecure_connections
    external_enabled           = var.external_enabled
    target_port                = var.target_port
    transport                  = var.transport
    traffic_weight {
      latest_revision = var.latest_revision
      percentage      = var.percentage
    }
  }
}