resource "azurerm_network_interface" "nic-dev" {
  for_each            = { for vm in var.vm_configs : vm.user_last_name => vm }
  location            = var.location
  name                = upper("${var.name_unit}-${var.name_app}-${var.name_env}-NIC-${vm.user_initials}")
  resource_group_name = var.rgp-name

  ip_configuration {
    name                          = "ipconfig"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = data.azurerm_subnet.snt-dev.id
  }

  tags = {
    "User" = "${vm.user_first_name} ${vm.user_last_name}"
  }
}

resource "azurerm_windows_virtual_machine" "vm-dev" {
  for_each              = { for vm in var.vm_configs : vm.user_last_name => vm }
  admin_password        = azurerm_key_vault_secret.sct-dev-adm[vm.user_last_name].value
  admin_username        = "${vm.user_first_name}.${vm.user_last_name}"
  location              = var.location
  name                  = upper("${var.name_unit}${var.name_app}${var.name_env}${vm.user_initials}")
  network_interface_ids = [azurerm_network_interface.nic-dev.id]
  resource_group_name   = var.rgp_name
  size                  = vm.vm_size

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "shutdown_schedule" {
  for_each              = { for vm in var.vm_configs : vm.user_last_name => vm }
  daily_recurrence_time = "1800"
  location              = var.location_va
  timezone              = "Central Standard Time"
  virtual_machine_id    = azurerm_windows_virtual_machine.vm-dev["${vm.user_last_name}"].id
  notification_settings {
    enabled = false
  }
}
