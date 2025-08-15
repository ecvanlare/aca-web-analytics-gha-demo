
output "resource_group_name" {
  description = "The name of the bootstrap resource group"
  value       = azurerm_resource_group.infrastructure.name
}

output "storage_account_name" {
  description = "The name of the storage account used for Terraform state"
  value       = azurerm_storage_account.tfstate.name
}

output "storage_container_name" {
  description = "The name of the storage container used for Terraform state"
  value       = azurerm_storage_container.tfstate.name
}

output "backend_config" {
  description = "Backend configuration for use in main Terraform configuration"
  value = {
    resource_group_name  = azurerm_resource_group.infrastructure.name
    storage_account_name = azurerm_storage_account.tfstate.name
    container_name       = azurerm_storage_container.tfstate.name
    key                  = "web-analytics.tfstate"
  }
}
