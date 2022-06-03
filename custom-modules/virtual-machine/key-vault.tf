resource "azurerm_key_vault" "kvt-dev" {
  location                    = var.location
  name                        = upper("${var.name_unit}${var.name_app}${var.name_env}KVTDEV")
  resource_group_name         = var.rgp_name
  enabled_for_deployment      = true
  enabled_for_disk_encryption = true
  purge_protection_enabled    = false
  sku_name                    = "standard"
  tenant_id                   = "value"

}

resource "random_password" "pwd-dev-adm" {
  for_each         = { for vm in var.vm_configs : vm.user_last_name => vm }
  length           = 16
  special          = true
  min_upper        = 3
  min_lower        = 3
  min_numeric      = 3
  min_special      = 3
  override_special = "!-_?:*"
}

resource "azurerm_key_vault_secret" "sct-dev-adm" {
  for_each         = { for vm in var.vm_configs : vm.user_last_name => vm }
    key_vault_id = azurerm_key_vault.kvt-dev.id
    name = "${vm.user_first_name}-${vm.user_last_name}"
    value = random_password.pwd-dev-adm.result
    
  depends_on = [
    azurerm_key_vault_access_policy.ply-kvt-dev
  ]
}

resource "azurerm_key_vault_access_policy" "ply-kvt-dev" {
  key_vault_id = azurerm_key_vault.kvt-dev.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "get",
    "list",
    "set",
    "delete",
    "recover",
    "purge"
  ]
}