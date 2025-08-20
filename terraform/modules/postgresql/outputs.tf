output "server_id" {
  description = "The ID of the PostgreSQL Flexible Server"
  value       = azurerm_postgresql_flexible_server.this.id
}

output "server_name" {
  description = "The name of the PostgreSQL Flexible Server"
  value       = azurerm_postgresql_flexible_server.this.name
}

output "server_fqdn" {
  description = "The fully qualified domain name of the PostgreSQL Flexible Server"
  value       = azurerm_postgresql_flexible_server.this.fqdn
}

output "administrator_login" {
  description = "The administrator login of the PostgreSQL Flexible Server"
  value       = azurerm_postgresql_flexible_server.this.administrator_login
}

output "connection_string" {
  description = "Connection string for PostgreSQL (without password)"
  value       = "postgresql://${azurerm_postgresql_flexible_server.this.administrator_login}@${azurerm_postgresql_flexible_server.this.fqdn}:5432/postgres"
  sensitive   = false
}

output "database_host" {
  description = "PostgreSQL server hostname"
  value       = azurerm_postgresql_flexible_server.this.fqdn
}

output "database_name" {
  description = "PostgreSQL database name"
  value       = "postgres"
}

output "database_user" {
  description = "PostgreSQL administrator username"
  value       = azurerm_postgresql_flexible_server.this.administrator_login
}
