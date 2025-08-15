# Resource Group Variables
variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "prod"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "web-analytics"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-web-analytics"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "uksouth"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default = {
    environment = "prod"
    project     = "web-analytics"
    managed_by  = "terraform"
    application = "umami"
  }
}

# ACA Variables
variable "aca_name" {
  description = "Name for the Container App"
  type        = string
  default     = "web-analytics"
}

variable "aca_cpu" {
  description = "CPU allocation for the container app"
  type        = number
  default     = 0.5
}

variable "aca_memory" {
  description = "Memory allocation for the container app"
  type        = string
  default     = "1Gi"
}

variable "aca_image_name" {
  description = "Docker image name for the container app"
  type        = string
  default     = "web-analytics-app"
}

variable "aca_image_tag" {
  description = "Docker image tag for the container app"
  type        = string
  default     = "latest"
}

variable "aca_revision_mode" {
  description = "Revision mode for the container app"
  type        = string
  default     = "Single"
}

variable "aca_min_replicas" {
  description = "Minimum number of replicas for the container app"
  type        = number
  default     = 0
}

variable "aca_max_replicas" {
  description = "Maximum number of replicas for the container app"
  type        = number
  default     = 10
}

variable "aca_node_env" {
  description = "Node.js environment for the application"
  type        = string
  default     = "production"
}

variable "aca_database_type" {
  description = "Database type for the application"
  type        = string
  default     = "postgresql"
}

variable "aca_app_secret" {
  description = "Application secret for the web analytics app"
  type        = string
  default     = "your-secret-value"
  sensitive   = true
}

variable "aca_external_enabled" {
  description = "Enable external access for the container app"
  type        = bool
  default     = true
}

variable "aca_target_port" {
  description = "Target port for the container app"
  type        = number
  default     = 3000
}

variable "aca_transport" {
  description = "Transport protocol for the container app"
  type        = string
  default     = "http"
}

variable "aca_allow_insecure_connections" {
  description = "Allow insecure connections for the container app"
  type        = bool
  default     = false
}

variable "aca_latest_revision" {
  description = "Use latest revision for traffic"
  type        = bool
  default     = true
}

variable "aca_percentage" {
  description = "Traffic percentage for this revision"
  type        = number
  default     = 100
}

variable "aca_log_analytics_workspace_sku" {
  description = "SKU for Log Analytics workspace"
  type        = string
  default     = "PerGB2018"
}

variable "aca_log_analytics_workspace_retention_in_days" {
  description = "Retention days for Log Analytics workspace"
  type        = number
  default     = 30
}

# Network Variables
variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
  default     = "vnet-web-analytics"
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnets" {
  description = "Subnet configuration for the application"
  type = map(object({
    name              = string
    address_prefixes  = list(string)
    service_endpoints = list(string)
  }))
  default = {
    app = {
      name              = "snet-app"
      address_prefixes  = ["10.0.17.0/24"]
      service_endpoints = ["Microsoft.ContainerRegistry"]
    }
  }
}

# NSG Configuration
variable "network_security_groups" {
  description = "Network security group for application subnet"
  type = map(object({
    name = string
    rules = map(object({
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
      description                = string
    }))
  }))
  default = {
    app = {
      name = "nsg-app"
      rules = {
        allow_outbound_acr = {
          priority                   = 100
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "VirtualNetwork"
          destination_address_prefix = "AzureContainerRegistry"
          description                = "Allow outbound HTTPS to ACR"
        }

        allow_postgresql_outbound = {
          priority                   = 200
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "5432"
          source_address_prefix      = "VirtualNetwork"
          destination_address_prefix = "Internet"
          description                = "Allow outbound PostgreSQL access to public database"
        }
      }
    }
  }
}

# ACR Variables
variable "acr_name" {
  description = "Name of the container registry"
  type        = string
  default     = "acrwebanalytics"
}

variable "acr_sku" {
  description = "SKU of the container registry"
  type        = string
  default     = "Standard"
}

variable "acr_admin_enabled" {
  description = "Enable admin access to the container registry"
  type        = bool
  default     = false
}

# PostgreSQL Variables
variable "postgresql_name" {
  description = "Name of the PostgreSQL Flexible Server"
  type        = string
  default     = "psql-web-analytics"
}

variable "postgresql_administrator_password" {
  description = "Administrator password for PostgreSQL"
  type        = string
  sensitive   = true
}

variable "postgresql_sku_name" {
  description = "SKU name for PostgreSQL Flexible Server"
  type        = string
  default     = "B_Standard_B1ms"
}

variable "postgresql_storage_mb" {
  description = "Storage size in MB for PostgreSQL"
  type        = number
  default     = 32768
}

variable "postgresql_maintenance_window" {
  description = "Maintenance window configuration for PostgreSQL"
  type = object({
    day_of_week  = number
    start_hour   = number
    start_minute = number
  })
  default = {
    day_of_week  = 0 # Sunday
    start_hour   = 2 # 2 AM
    start_minute = 0
  }
}

variable "postgresql_firewall_rules" {
  description = "Firewall rules for PostgreSQL"
  type = list(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))
  default = [
    {
      name             = "allow-azure-services"
      start_ip_address = "0.0.0.0"
      end_ip_address   = "0.0.0.0"
    }
  ]
}

# Identity Role Names
variable "acr_pull_role_name" {
  description = "Azure RBAC role name for ACR pull access"
  type        = string
  default     = "AcrPull"
}

# Role Assignment Defaults
variable "role_assignment_defaults" {
  description = "Default values for role assignments"
  type = object({
    description = string
  })
  default = {
    description = null
  }
}

# Front Door Variables
variable "frontdoor_host_name" {
  description = "Host name for the Azure Front Door endpoint (e.g., analytics.yourdomain.com)"
  type        = string
  default     = null
}

variable "frontdoor_name" {
  description = "Name of the Azure Front Door"
  type        = string
  default     = "fd-web-analytics"
}

variable "frontdoor_endpoint_name" {
  description = "Name of the Front Door endpoint"
  type        = string
  default     = "web-analytics"
}

variable "frontdoor_origin_group_name" {
  description = "Name of the origin group"
  type        = string
  default     = "og-web-analytics"
}

variable "frontdoor_origin_name" {
  description = "Name of the origin"
  type        = string
  default     = "origin-web-analytics"
}

variable "frontdoor_custom_domain_name" {
  description = "Name of the custom domain"
  type        = string
  default     = "cd-web-analytics"
}

variable "frontdoor_route_name" {
  description = "Name of the route"
  type        = string
  default     = "route-web-analytics"
}

