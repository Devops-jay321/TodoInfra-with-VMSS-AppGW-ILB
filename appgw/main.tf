resource "azurerm_application_gateway" "appgw" {
    for_each = var.appgw_lb
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appgw-ipcfg"
    subnet_id = data.azurerm_subnet.appgw_subnet.id
  }

  frontend_port {
    name = "frontend-port-80"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = data.azurerm_public_ip.appgw_pip.id
  }

  backend_address_pool {
    name = "backend-pool"

  }

  backend_http_settings {
    name                  = "http-setting"
    port                  = 80
    protocol              = "Http"
    cookie_based_affinity = "Disabled"
    request_timeout       = 30
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "frontend-ip"
    frontend_port_name             = "frontend-port-80"
    protocol                       = "Http"
    host_name = "todoapp.jaydeep.shop"
  }

  request_routing_rule {
    name                       = "rule-1"
    rule_type                 = "Basic"
    http_listener_name        = "http-listener"
    backend_address_pool_name = "backend-pool"
    backend_http_settings_name = "http-setting"
    priority                   = 100
  }
}

output "backend_pool_id" {
  value = {
    for k, appgw in azurerm_application_gateway.appgw :
    k => one([
      for p in appgw.backend_address_pool :
      p.id
      if p.name == "backend-pool"
    ])
  }
}
