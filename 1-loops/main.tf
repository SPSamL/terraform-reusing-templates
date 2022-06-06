locals {
  upper_resource_prefix = upper("${var.name_unit}-${var.name_app}-${var.name_env}")
  lower_resource_prefix = lower("${var.name_unit}${var.name_app}${var.name_env}")
}

resource "azurerm_resource_group" "rgp_loop" {
  location = var.location
  name     = upper("${local.upper_resource_prefix}-RGP-LOOP")
}

resource "azurerm_storage_account" "stg_count" {
  count                    = length(var.list)
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = var.location
  name                     = "ct${var.list[count.index].fn}${var.list[count.index].ln}"
  resource_group_name      = azurerm_resource_group.rgp_loop.name
}

resource "azurerm_storage_account" "stg_for" {
  for_each                 = { for name in var.list : name.ln => name }
  location                 = var.location
  name                     = "for${each.value.fn}${each.value.ln}"
  resource_group_name      = azurerm_resource_group.rgp_loop.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
