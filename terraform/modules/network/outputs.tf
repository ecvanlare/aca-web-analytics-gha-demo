output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.this.name
}

output "subnet_ids" {
  description = "IDs of all subnets"
  value       = { for k, v in azurerm_subnet.this : k => v.id }
}

output "nsg_ids" {
  description = "IDs of all network security groups"
  value       = { for k, v in azurerm_network_security_group.this : k => v.id }
}

