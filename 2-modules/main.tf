locals {
  upper_resource_prefix = upper("${var.name_unit}-${var.name_app}-${var.name_env}")
  lower_resource_prefix = lower("${var.name_unit}${var.name_app}${var.name_env}")
}

resource "azurerm_resource_group" "rgp_dev" {
  location = var.location
  name     = upper("${local.upper_resource_prefix}-RGP-DEV")
}

module "virtual-machine" {
  source     = "..\\custom-modules\\virtual-machine"
  location   = var.location
  name_unit  = var.name_unit
  name_app   = var.name_app
  name_env   = var.name_env
  rgp_name   = azurerm_resource_group.rgp_dev
  vm_configs = var.vm_configs
}
