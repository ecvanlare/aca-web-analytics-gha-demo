variable "name" {
  description = "Name of the PostgreSQL Flexible Server"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "postgresql_version" {
  description = "PostgreSQL version"
  type        = string
  default     = "14"
}

variable "administrator_login" {
  description = "Administrator login for PostgreSQL"
  type        = string
  default     = "psqladmin"
}

variable "administrator_password" {
  description = "Administrator password for PostgreSQL"
  type        = string
  sensitive   = true
}

variable "storage_mb" {
  description = "Storage size in MB"
  type        = number
  default     = 32768
}

variable "sku_name" {
  description = "SKU name for PostgreSQL Flexible Server"
  type        = string
  default     = "B_Standard_B1ms"
}

variable "zone" {
  description = "Availability zone"
  type        = string
  default     = "1"
}

variable "backup_retention_days" {
  description = "Backup retention days"
  type        = number
  default     = 7
}

variable "geo_redundant_backup_enabled" {
  description = "Enable geo-redundant backups"
  type        = bool
  default     = false
}

variable "vnet_id" {
  description = "Virtual network ID"
  type        = string
}

variable "use_private_endpoint" {
  description = "Use private endpoint for PostgreSQL (false = public access with firewall)"
  type        = bool
  default     = false
}

variable "server_configurations" {
  description = "PostgreSQL server configurations"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "maintenance_window" {
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

variable "firewall_rules" {
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
