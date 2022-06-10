resource "azurerm_application_gateway" "network" {
  name                = var.agw_name
  resource_group_name = var.rg_name
  location            = var.rg_location

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.capacity
  }

  gateway_ip_configuration {
    name      = var.agw_ip_name
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = var.frontend_port_name
    port = var.frontend_port
  }

  frontend_ip_configuration {
    name                 = var.frontend_ip_name
    public_ip_address_id = var.frontend_ip_id
  }

  backend_address_pool {
    name = var.backend_address_pool_name
  }

  backend_http_settings {
    name                  = var.http_setting_name
    cookie_based_affinity = var.cookie_based_affinity
    path                  = var.backend_path
    port                  = var.backend_port
    protocol              = var.backend_protocol
    request_timeout       = var.backend_request_timeout
  }

  http_listener {
    name                           = var.listener_name
    frontend_ip_configuration_name = var.frontend_ip_configuration_name
    frontend_port_name             = var.frontend_port_name
    protocol                       = var.listener_protocol
  }

  request_routing_rule {
    name                       = var.request_routing_rule_name
    rule_type                  = var.rule_type
    http_listener_name         = var.listener_name
    backend_address_pool_name  = var.backend_address_pool_name
    backend_http_settings_name = var.http_setting_name
  }
}
