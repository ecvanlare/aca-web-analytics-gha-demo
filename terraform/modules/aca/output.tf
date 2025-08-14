output "aca_id" {
  description = "ID of the Container App"
  value       = azurerm_container_app.aca.id
}

output "aca_name" {
  description = "Name of the Container App"
  value       = azurerm_container_app.aca.name
}

output "aca_url" {
  description = "URL of the Container App"
  value       = azurerm_container_app.aca.latest_revision_fqdn
}

output "aca_environment_id" {
  description = "ID of the Container App Environment"
  value       = azurerm_container_app_environment.aca.id
}

output "aca_environment_name" {
  description = "Name of the Container App Environment"
  value       = azurerm_container_app_environment.aca.name
}

output "aca_log_analytics_workspace_id" {
  description = "ID of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.aca.id
}

output "aca_log_analytics_workspace_name" {
  description = "Name of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.aca.name
}