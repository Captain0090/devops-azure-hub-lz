resource "azurerm_managed_disk" "this" {
  for_each                      = var.data_disks
  name                          = each.value.name
  resource_group_name           = var.resource_group_name
  public_network_access_enabled = true
  network_access_policy         = "DenyAll"
  location                      = var.location
  zone                          = var.zone
  storage_account_type          = each.value.storage_account_type
  create_option                 = "Empty"
  disk_size_gb                  = each.value.disk_size_gb
  disk_encryption_set_id        = var.disk_encryption_set_id
  tags                          = var.tags

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk" {
  for_each           = var.data_disks
  managed_disk_id    = azurerm_managed_disk.this[each.key].id
  virtual_machine_id = azurerm_windows_virtual_machine.this.id
  lun                = each.value.lun
  caching            = each.value.caching

  depends_on = [azurerm_windows_virtual_machine.this]
}
 