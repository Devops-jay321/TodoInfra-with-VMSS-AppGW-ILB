data "azurerm_lb" "lb" {
    name                = "jaydeep-backend-lb-1"
    resource_group_name = "jaydeep_rg1"
}