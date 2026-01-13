# data "azurerm_network_interface" "net_front" {
#   for_each = var.frontend_vmss

#   name                = each.value.network_interface_name
#   resource_group_name = each.value.resource_group_name
# }
    
data "azurerm_network_interface" "net_backend" {
  name                = "nic-backend-jay-1"
  resource_group_name = "jaydeep_rg1"

}
data "azurerm_key_vault_secret" "admin-login" {
  name                = "admin-login"
  key_vault_id        = data.azurerm_key_vault.kvi.id
}
data "azurerm_key_vault" "kvi" {
  name                = "jaydeep-key-vault"
  resource_group_name = "jaydeep_rg"
}
data "azurerm_key_vault_secret" "vm-password" {
  name                = "vm-password"
  key_vault_id        = data.azurerm_key_vault.kvi.id
}
data "azurerm_subnet" "subnets" {
  for_each = var.frontend_vmss

  name                 = each.value.subnet_name
  virtual_network_name = "JaydeepVnet"
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_subnet" "subnets_back" {
  for_each = var.backend_vmss

  name                 = each.value.subnet_name
  virtual_network_name = "JaydeepVnet"
  resource_group_name  = each.value.resource_group_name
}