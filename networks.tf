#-------------------------------------------------
# Using Azure verified module for network creation and subnets.
#--------------------------------------------------

module "network" {
  source              = "./modules/network"
  for_each            = var.VirtualNetworks
  name                = "${each.value.vnet_name}-${local.resource_name_suffix}"
  resource_group_name = azurerm_resource_group.rg[each.value.resource_groups_map_key].name
  location            = azurerm_resource_group.rg[each.value.resource_groups_map_key].location
  address_space       = each.value.virtual_network_address_space
  subnets             = each.value.subnets
  route_table_name    = "${each.value.route_table_name}-${local.resource_name_suffix}"
  routes              = each.value.routes
  tags                = local.tags
}