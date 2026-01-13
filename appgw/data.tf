data "azurerm_subnet" "appgw_subnet" {
  name                 = "AppGwSubnet"
  resource_group_name  = "jaydeep_rg1"
  virtual_network_name = "JaydeepVnet"
}

data "azurerm_public_ip" "appgw_pip" {
  name                = "appgw-public-ip"
  resource_group_name = "jaydeep_rg1"
  
}