resource "azurerm_lb_backend_address_pool" "lb_pool" {
    for_each = var.backend_pool
  loadbalancer_id = var.lb_id
  name            = each.value.name
}

output "backend_pool_id" {
  value = { for k, v in azurerm_lb_backend_address_pool.lb_pool : k => v.id }
  description = "Map of backend pool IDs"
}