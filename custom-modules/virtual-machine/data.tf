data "azuread_client_config" "current" {}

data "azurerm_resource_group" "rgp_net" {
  name = upper("${var.name_unit}-${var.name_app}-${var.name_env}-RGP-NET")

}
data "azurerm_virtual_network" "vnet" {
  name                = upper("${var.name_unit}-${var.name_app}-${var.name_env}-VNT")
  resource_group_name = data.azurerm_resource_group.rgp_net.name
}

data "azurerm_subnet" "snt_dev" {
  name                 = upper("${var.name_unit}-${var.name_app}-${var.name_env}-SNT-DEV")
  resource_group_name  = data.azurerm_resource_group.rgp_net.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name

}
