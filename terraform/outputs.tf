# Resource Group Outputs
output "resource_group_name" {
  description = "The name of the resource group"
  value       = module.resource_group.resource_group_name
}

# Network Outputs
output "vnet_id" {
  description = "The ID of the virtual network"
  value       = module.network.vnet_id
}

output "vnet_name" {
  description = "The name of the virtual network"
  value       = module.network.vnet_name
}

output "private_subnet_id" {
  description = "The ID of the private subnet (for PostgreSQL)"
  value       = module.network.subnet_ids["private"]
}

# ACR Outputs
output "acr_name" {
  description = "The name of the container registry"
  value       = module.acr.acr_name
}

output "acr_login_server" {
  description = "The login server of the container registry"
  value       = module.acr.acr_login_server
}

# PostgreSQL Outputs
output "postgresql_server_name" {
  description = "The name of the PostgreSQL Flexible Server"
  value       = module.postgresql.server_name
}

output "postgresql_server_fqdn" {
  description = "The fully qualified domain name of the PostgreSQL Flexible Server"
  value       = module.postgresql.server_fqdn
}

output "postgresql_connection_string" {
  description = "Connection string for PostgreSQL"
  value       = module.postgresql.connection_string
  sensitive   = true
}

# Managed Identity Outputs
output "acr_pull_identity_principal_id" {
  description = "Principal ID of the ACR pull managed identity"
  value       = azurerm_user_assigned_identity.identities["acr_pull"].principal_id
}

output "acr_pull_identity_client_id" {
  description = "Client ID of the ACR pull managed identity"
  value       = azurerm_user_assigned_identity.identities["acr_pull"].client_id
}

# ACA Outputs
output "aca_url" {
  description = "URL of the Container App (Web Analytics)"
  value       = module.aca.aca_url
}

output "aca_name" {
  description = "Name of the Container App"
  value       = module.aca.aca_name
}

output "aca_environment_name" {
  description = "Name of the Container App Environment"
  value       = module.aca.aca_environment_name
}