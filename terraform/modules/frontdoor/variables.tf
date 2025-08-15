# Basic Configuration
variable "name" {
  description = "Name of the Azure Front Door"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "sku_name" {
  description = "SKU name for the Front Door profile"
  type        = string
  default     = "Standard_AzureFrontDoor"
}

variable "tags" {
  description = "Tags to apply to the Front Door"
  type        = map(string)
  default     = {}
}

# Endpoint & Route Configuration
variable "endpoint_name" {
  description = "Name of the Front Door endpoint"
  type        = string
}

variable "route_name" {
  description = "Name of the route"
  type        = string
}

variable "accepted_protocols" {
  description = "Accepted protocols for the routing rule"
  type        = list(string)
  default     = ["Http", "Https"]
}

variable "patterns_to_match" {
  description = "Patterns to match for the routing rule"
  type        = list(string)
  default     = ["/*"]
}

variable "forwarding_protocol" {
  description = "Forwarding protocol for the routing rule"
  type        = string
  default     = "MatchRequest"
}

variable "https_redirect_enabled" {
  description = "Enable HTTPS redirect for routes"
  type        = bool
  default     = true
}

# Origin Group Configuration
variable "origin_group_name" {
  description = "Name of the origin group"
  type        = string
}

variable "session_affinity_enabled" {
  description = "Enable session affinity for the origin group"
  type        = bool
  default     = false
}

variable "load_balancing_sample_size" {
  description = "Sample size for load balancing"
  type        = number
  default     = 4
}

variable "load_balancing_successful_samples_required" {
  description = "Number of successful samples required for load balancing"
  type        = number
  default     = 3
}

variable "health_probe_path" {
  description = "Path for health probe"
  type        = string
  default     = "/"
}

variable "health_probe_protocol" {
  description = "Protocol for health probe"
  type        = string
  default     = "Https"
}

variable "health_probe_interval" {
  description = "Interval in seconds for health probe"
  type        = number
  default     = 100
}

# Origin Configuration
variable "origin_name" {
  description = "Name of the origin"
  type        = string
}

variable "backend_host_header" {
  description = "Host header for the backend"
  type        = string
}

variable "backend_address" {
  description = "Address of the backend"
  type        = string
}

variable "http_port" {
  description = "HTTP port for the backend"
  type        = number
  default     = 80
}

variable "https_port" {
  description = "HTTPS port for the backend"
  type        = number
  default     = 443
}

variable "origin_priority" {
  description = "Priority for the origin"
  type        = number
  default     = 1
}

variable "origin_weight" {
  description = "Weight for the origin"
  type        = number
  default     = 1000
}

# Custom Domain Configuration
variable "custom_domain_name" {
  description = "Name of the custom domain"
  type        = string
}

variable "host_name" {
  description = "Host name for the frontend endpoint"
  type        = string
}

variable "certificate_type" {
  description = "Certificate type for custom domain"
  type        = string
  default     = "ManagedCertificate"
}
