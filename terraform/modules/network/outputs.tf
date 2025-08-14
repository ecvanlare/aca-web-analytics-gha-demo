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

# NAT Gateway outputs
output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = azurerm_nat_gateway.main.id
}

output "nat_gateway_public_ip" {
  description = "Public IP address of the NAT Gateway"
  value       = azurerm_public_ip.nat_gateway.ip_address
}