locals {
  upper-resource-prefix = upper("${var.name-unit}-${var.name-app}-${var.name-env}")
  lower-resource-prefix = lower("${var.name-unit}${var.name-app}${var.name-env}")
}

resource "azurerm_resource_group" "rgp-loop" {
  location = var.location
  name     = upper("${local.upper-resource-prefix}-RGP-LOOP")
}

resource "azurerm_storage_account" "stg-count" {
  count                    = length(var.list)
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = var.location
  name                     = "ct${var.list[count.index].fn}${var.list[count.index].ln}"
  resource_group_name      = azurerm_resource_group.rgp-loop.name
}

resource "azurerm_storage_account" "stg-for" {
  for_each                 = { for name in var.list : name.ln => name }
  location                 = var.location
  name                     = "for${each.value.fn}${each.value.ln}"
  resource_group_name      = azurerm_resource_group.rgp-loop.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
