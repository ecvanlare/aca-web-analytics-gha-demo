resource "azurerm_cdn_frontdoor_profile" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  tags                = var.tags
}

resource "azurerm_cdn_frontdoor_endpoint" "this" {
  name                     = var.endpoint_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
}

resource "azurerm_cdn_frontdoor_origin_group" "this" {
  name                     = var.origin_group_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
  session_affinity_enabled = var.session_affinity_enabled

  load_balancing {
    sample_size                 = var.load_balancing_sample_size
    successful_samples_required = var.load_balancing_successful_samples_required
  }

  health_probe {
    path                = var.health_probe_path
    protocol            = var.health_probe_protocol
    interval_in_seconds = var.health_probe_interval
  }
}

resource "azurerm_cdn_frontdoor_origin" "this" {
  name                          = var.origin_name
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.this.id
  enabled                       = true

  host_name          = var.backend_address
  http_port          = var.http_port
  https_port         = var.https_port
  origin_host_header = var.backend_host_header

  priority = var.origin_priority
  weight   = var.origin_weight

  certificate_name_check_enabled = true
}

resource "azurerm_cdn_frontdoor_custom_domain" "this" {
  name                     = var.custom_domain_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
  host_name                = var.host_name

  tls {
    certificate_type = var.certificate_type
  }
}

resource "azurerm_cdn_frontdoor_route" "this" {
  name                          = var.route_name
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.this.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.this.id
  enabled                       = true

  forwarding_protocol    = var.forwarding_protocol
  https_redirect_enabled = var.https_redirect_enabled
  patterns_to_match      = var.patterns_to_match
  supported_protocols    = var.accepted_protocols

  cdn_frontdoor_origin_ids = [azurerm_cdn_frontdoor_origin.this.id]

  cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.this.id]
}
