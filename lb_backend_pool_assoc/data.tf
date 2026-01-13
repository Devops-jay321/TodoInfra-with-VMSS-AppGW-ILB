

data "azurerm_lb_backend_address_pool" "pool" {
  name            = "backend-backend-pool"
  loadbalancer_id = data.azurerm_lb.lb.id
}

data "azurerm_lb" "lb" {
    name                = "jaydeep-backend-lb-1"
    resource_group_name = "jaydeep_rg1"
}
data "azurerm_network_interface" "net_backend" {
  name                = "nic-backend-jay-1"
  resource_group_name = "jaydeep_rg1"

}