module "bastion" {
  source              = "./modules/bastion"
  bastion_name        = var.bastion_name
  resource_group_name = azurerm_resource_group.rg["network"].name
  location            = azurerm_resource_group.rg["network"].location
  pup_ip_name         = var.bastion_pip
  subnet_id           = lookup(module.network["vnet_hub"].subnet_id_list, "bastion")
  tags                = local.tags
  count               = var.enable_bastion ? 1 : 0
}