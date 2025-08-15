variable "name" {
  description = "Name of the Container App Environment"
  type        = string
}

variable "location" {
  description = "Location of the Container App Environment"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Container App"
  type        = map(string)
}

variable "image" {
  description = "Image of the Container App"
  type        = string
}

variable "cpu" {
  description = "CPU of the Container App"
  type        = number
}

variable "memory" {
  description = "Memory of the Container App"
  type        = string
}

variable "revision_mode" {
  description = "Revision mode of the Container App"
  type        = string
}

variable "registry_server" {
  description = "Container registry server (ACR login server)"
  type        = string
}

variable "registry_identity" {
  description = "Managed identity for registry access"
  type        = string
}

variable "environment_variables" {
  description = "Environment variables for the container app"
  type        = map(string)
  default     = {}
}

variable "secrets" {
  description = "Secrets from Key Vault"
  type = map(object({
    name  = string
    value = string
  }))
  default = {}
}

variable "external_enabled" {
  description = "Enable external access"
  type        = bool
}

variable "target_port" {
  description = "Target port for ingress"
  type        = number
}

variable "transport" {
  description = "Transport protocol (http/https)"
  type        = string
}

variable "allow_insecure_connections" {
  description = "Allow insecure connections"
  type        = bool
}

variable "latest_revision" {
  description = "Use latest revision for traffic"
  type        = bool
}

variable "percentage" {
  description = "Traffic percentage for this revision"
  type        = number
}

variable "log_analytics_workspace_sku" {
  description = "SKU of the Log Analytics Workspace"
  type        = string
}

variable "log_analytics_workspace_retention_in_days" {
  description = "Retention in days of the Log Analytics Workspace"
  type        = number
}

variable "min_replicas" {
  description = "Minimum number of replicas for the container app"
  type        = number
  default     = 0
}

variable "max_replicas" {
  description = "Maximum number of replicas for the container app"
  type        = number
  default     = 10
}