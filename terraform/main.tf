# =============================================================================
# FOUNDATION RESOURCES
# =============================================================================

# Resource Group Module
module "resource_group" {
  source = "./modules/resource_group"

  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# =============================================================================
# IDENTITY MANAGEMENT
# =============================================================================

# Create managed identity for ACR pull access
resource "azurerm_user_assigned_identity" "identities" {
  for_each = {
    acr_pull = "web-analytics-acr-pull"
  }

  name                = each.value
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  tags                = var.tags
}

# =============================================================================
# NETWORK INFRASTRUCTURE
# =============================================================================

# Network Infrastructure
module "network" {
  source = "./modules/network"

  # Common
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  tags                = var.tags

  # Virtual Network
  vnet_name     = var.vnet_name
  address_space = [var.vnet_address_space]

  # Subnets
  subnets = var.subnets

  # Network Security Groups
  network_security_groups = var.network_security_groups
}

# =============================================================================
# CONTAINER REGISTRY
# =============================================================================

# Azure Container Registry Module
module "acr" {
  source = "./modules/acr"

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  name                = var.acr_name
  sku                 = var.acr_sku
  admin_enabled       = var.acr_admin_enabled
  tags                = var.tags
}

# =============================================================================
# DATABASE
# =============================================================================

# PostgreSQL Flexible Server Module
module "postgresql" {
  source = "./modules/postgresql"

  name                   = var.postgresql_name
  resource_group_name    = module.resource_group.resource_group_name
  location               = module.resource_group.resource_group_location
  administrator_password = var.postgresql_administrator_password
  sku_name               = var.postgresql_sku_name
  storage_mb             = var.postgresql_storage_mb
  vnet_id                = module.network.vnet_id

  # Configurable maintenance window and firewall rules
  maintenance_window = var.postgresql_maintenance_window
  firewall_rules     = var.postgresql_firewall_rules

  tags = var.tags
}

# =============================================================================
# ROLE ASSIGNMENTS & PERMISSIONS
# =============================================================================

# Identity assignment for ACR pull operations (for ACA)
module "acr_pull" {
  source = "./modules/identity"

  scope                = module.acr.acr_id
  role_definition_name = var.acr_pull_role_name
  principal_id         = azurerm_user_assigned_identity.identities["acr_pull"].principal_id
  description          = var.role_assignment_defaults.description
}

# =============================================================================
# CONTAINER APP
# =============================================================================

module "aca" {
  source = "./modules/aca"

  # Basic configuration
  name                = var.aca_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  depends_on = [module.acr_pull]

  # Container configuration
  image         = "${module.acr.acr_login_server}/${var.aca_image_name}:${var.aca_image_tag}"
  cpu           = var.aca_cpu
  memory        = var.aca_memory
  revision_mode = var.aca_revision_mode
  min_replicas  = var.aca_min_replicas
  max_replicas  = var.aca_max_replicas

  # Registry configuration
  registry_server   = module.acr.acr_login_server
  registry_identity = azurerm_user_assigned_identity.identities["acr_pull"].id

  # Environment variables
  environment_variables = {
    DATABASE_HOST = module.postgresql.database_host
    DATABASE_NAME = module.postgresql.database_name
    DATABASE_USER = module.postgresql.database_user
    NODE_ENV      = var.aca_node_env
    DATABASE_TYPE = var.aca_database_type
    DATABASE_URL  = "postgresql://${module.postgresql.database_user}:${var.postgresql_administrator_password}@${module.postgresql.database_host}:5432/${module.postgresql.database_name}?sslmode=require"
  }

  # Secrets
  secrets = {
    app_secret = {
      name  = "app-secret"
      value = var.aca_app_secret
    }
    database_password = {
      name  = "database-password"
      value = var.postgresql_administrator_password
    }
  }

  # Ingress configuration
  external_enabled           = var.aca_external_enabled
  target_port                = var.aca_target_port
  transport                  = var.aca_transport
  allow_insecure_connections = var.aca_allow_insecure_connections
  latest_revision            = var.aca_latest_revision
  percentage                 = var.aca_percentage

  # Log Analytics
  log_analytics_workspace_sku               = var.aca_log_analytics_workspace_sku
  log_analytics_workspace_retention_in_days = var.aca_log_analytics_workspace_retention_in_days

  # Tags
  tags = var.tags
}

# =============================================================================
# AZURE FRONT DOOR (CLASSIC) - CUSTOM DOMAIN
# =============================================================================

# Classic Azure Front Door for custom domain
module "frontdoor" {
  source = "./modules/frontdoor"

  name                = var.frontdoor_name
  resource_group_name = module.resource_group.resource_group_name

  endpoint_name      = var.frontdoor_endpoint_name
  origin_group_name  = var.frontdoor_origin_group_name
  origin_name        = var.frontdoor_origin_name
  custom_domain_name = var.frontdoor_custom_domain_name
  route_name         = var.frontdoor_route_name

  backend_host_header = module.aca.aca_url
  backend_address     = module.aca.aca_url
  host_name           = var.frontdoor_host_name

  tags = var.tags
}