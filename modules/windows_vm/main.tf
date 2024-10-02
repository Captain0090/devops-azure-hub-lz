resource "random_password" "this" {
  length           = 10
  min_upper        = 2
  min_lower        = 2
  min_special      = 2
  numeric          = true
  special          = true
  override_special = "!@#$%&"
}

#Azure Windows VM 
resource "azurerm_windows_virtual_machine" "this" {
  name                       = var.name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  size                       = var.size
  admin_username             = var.admin_username
  admin_password             = var.use_custom_pwd == true ? var.pwd : random_password.this.result
  network_interface_ids      = [azurerm_network_interface.this.id]
  provision_vm_agent         = var.provision_vm_agent
  enable_automatic_updates   = var.enable_automatic_updates
  license_type               = var.license_type
  encryption_at_host_enabled = var.encryption_at_host_enabled
  patch_mode                 = var.patch_mode
  zone                       = var.zone
  tags                       = var.tags

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }

 dynamic "plan" {
  for_each = var.plan != null ? ["plan"] : []
  content {
    name      = plan.value.name
    product   = plan.value.product
    publisher = plan.value.publisher
  }
 }

  os_disk {
    storage_account_type      = var.os_disk.storage_account_type
    caching                   = var.os_disk.caching
    disk_encryption_set_id    = var.os_disk_encryption_set_id
    disk_size_gb              = var.os_disk.size_gb
    write_accelerator_enabled = var.os_disk.write_accelerator_enabled
    name                      = var.os_disk.name
  }

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_account_uri
  }

  additional_capabilities {
    ultra_ssd_enabled = var.enable_ultra_ssd_data_disk_storage_support
  }

  dynamic "identity" {
    for_each = var.managed_identity_type != null ? [1] : []
    content {
      type         = var.managed_identity_type
      identity_ids = var.managed_identity_type == "UserAssigned" || var.managed_identity_type == "SystemAssigned, UserAssigned" ? var.managed_identity_ids : null
    }
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  depends_on = [azurerm_marketplace_agreement.this]
}

resource "azurerm_marketplace_agreement" "this" {
  count     = var.enable_marketplace_agreement == true ? 1 : 0
  publisher = try(var.plan.publisher, var.source_image_reference.publisher)
  offer     = try(var.plan.product, var.source_image_reference.offer)
  plan      = try(var.plan.name, var.source_image_reference.sku)
}

resource "azurerm_virtual_machine_extension" "aad_login" {
  name                 = "AADLogin"
  virtual_machine_id   =  azurerm_windows_virtual_machine.this.id
  publisher            = "Microsoft.Azure.ActiveDirectory"
  type                 = "AADLoginForWindows" 
  type_handler_version = "1.3" 
}