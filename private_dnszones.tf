module "azure_privatednszone" {
  source              = "./modules/private_dnszones"
  for_each            = { for idx, value in concat(local.private_dns_zones, var.private_dns_zones) : "${idx}" => value }
  domain_name         = each.value
  resource_group_name = azurerm_resource_group.rg["privateDnsZones"].name
  tags                = local.tags
  virtual_network_links = {
    hubvnetlink = {
      vnetlinkname = "${module.network["vnet_hub"].vnet_name}-link"
      vnetid       = module.network["vnet_hub"].vnet_id
    }
  }
}