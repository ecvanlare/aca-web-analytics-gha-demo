output "server_id" {
  description = "The ID of the PostgreSQL Flexible Server"
  value       = azurerm_postgresql_flexible_server.main.id
}

output "server_name" {
  description = "The name of the PostgreSQL Flexible Server"
  value       = azurerm_postgresql_flexible_server.main.name
}

output "server_fqdn" {
  description = "The fully qualified domain name of the PostgreSQL Flexible Server"
  value       = azurerm_postgresql_flexible_server.main.fqdn
}

output "administrator_login" {
  description = "The administrator login of the PostgreSQL Flexible Server"
  value       = azurerm_postgresql_flexible_server.main.administrator_login
}

output "private_endpoint_ip" {
  description = "The private IP address of the PostgreSQL private endpoint"
  value       = azurerm_private_endpoint.postgresql.private_service_connection[0].private_ip_address
}

output "connection_string" {
  description = "Connection string for PostgreSQL (without password)"
  value       = "postgresql://${azurerm_postgresql_flexible_server.main.administrator_login}@${azurerm_postgresql_flexible_server.main.fqdn}:5432/postgres"
  sensitive   = false
}

output "database_host" {
  description = "PostgreSQL server hostname"
  value       = azurerm_postgresql_flexible_server.main.fqdn
}

output "database_name" {
  description = "PostgreSQL database name"
  value       = "postgres"
}

output "database_user" {
  description = "PostgreSQL administrator username"
  value       = azurerm_postgresql_flexible_server.main.administrator_login
}
