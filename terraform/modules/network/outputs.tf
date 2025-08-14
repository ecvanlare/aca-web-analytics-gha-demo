# Virtual Network outputs
output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

# Subnet outputs
output "subnet_ids" {
  description = "IDs of all subnets"
  value       = { for k, v in azurerm_subnet.subnets : k => v.id }
}

# NSG outputs
output "nsg_ids" {
  description = "IDs of all network security groups"
  value       = { for k, v in azurerm_network_security_group.nsg : k => v.id }
}

