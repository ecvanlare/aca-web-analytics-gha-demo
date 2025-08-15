output "frontdoor_id" {
  description = "The ID of the Azure Front Door"
  value       = azurerm_cdn_frontdoor_profile.profile.id
}

output "frontdoor_name" {
  description = "The name of the Azure Front Door"
  value       = azurerm_cdn_frontdoor_profile.profile.name
}

output "frontdoor_url" {
  description = "The public URL of the Azure Front Door endpoint"
  value       = azurerm_cdn_frontdoor_endpoint.endpoint.host_name
}

output "frontdoor_cname" {
  description = "The CNAME record for the Front Door endpoint"
  value       = azurerm_cdn_frontdoor_endpoint.endpoint.host_name
}
