resource "azurerm_public_ip" "public_ip" {
    for_each = var.public_ip
    name                = each.value.name
    location            = each.value.location
    resource_group_name = each.value.resource_group_name
    allocation_method   = each.value.allocation_method
    sku                 = each.value.sku
}

output "public_ip_id" {
  value = { for k, v in azurerm_public_ip.public_ip : k => v.id }
  description = "Map of public IP IDs"
}