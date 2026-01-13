data "azurerm_subnet" "subnets_back" {

  name                 = "backend_jay"
  virtual_network_name = "JaydeepVnet"
  resource_group_name  = "jaydeep_rg1"
  
}