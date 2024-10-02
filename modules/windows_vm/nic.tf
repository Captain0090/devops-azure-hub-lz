resource "azurerm_network_interface" "this" {
  name                          = var.nic_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  enable_ip_forwarding          = var.enable_ip_forwarding
  enable_accelerated_networking = var.enable_accelerated_networking

  tags = var.tags

  ip_configuration {
    name                          = var.nic_ip_config_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation_type
  }

  lifecycle {
    ignore_changes = [tags]
  }
}