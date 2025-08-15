output "aca_id" {
  description = "ID of the Container App"
  value       = azurerm_container_app.app.id
}

output "aca_name" {
  description = "Name of the Container App"
  value       = azurerm_container_app.app.name
}

output "aca_url" {
  description = "URL of the Container App"
  value       = azurerm_container_app.app.latest_revision_fqdn
}

output "aca_environment_id" {
  description = "ID of the Container App Environment"
  value       = azurerm_container_app_environment.environment.id
}

output "aca_environment_name" {
  description = "Name of the Container App Environment"
  value       = azurerm_container_app_environment.environment.name
}

output "aca_log_analytics_workspace_id" {
  description = "ID of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.workspace.id
}

output "aca_log_analytics_workspace_name" {
  description = "Name of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.workspace.name
}