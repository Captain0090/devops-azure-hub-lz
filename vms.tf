module "virtual_machine" {
  source                     = "./modules/windows_vm"
  name                       = var.vm_configuration.vm_name
  resource_group_name        = azurerm_resource_group.rgvnet.name
  location                   = azurerm_resource_group.rgvnet.location
  use_custom_pwd             = true
  pwd                        = var.vm_password
  size                       = var.vm_configuration.vm_size
  admin_username             = var.vm_configuration.admin_username
  license_type               = var.vm_configuration.license_type
  encryption_at_host_enabled = true
  zone                       = var.vm_configuration.vm_zone
  tags                       = local.configure_connectivity_resources.tags
  source_image_reference     = var.vm_configuration.source_image_reference
  os_disk                    = var.vm_configuration.os_disk
  data_disks                 = var.vm_configuration.data_disks
  subnet_id                  = lookup(module.network["vnet_hub"].subnet_id_list, "vm")
  managed_identity_type      = var.vm_configuration.managed_identity_type
  nic_name                   = var.vm_configuration.nic_name
  nic_ip_config_name         = var.vm_configuration.nic_ip_config_name
  depends_on = [
    azurerm_network_security_group.vmsubnet
  ]
  count = var.deploy_jumpbox ? 1 : 0
}