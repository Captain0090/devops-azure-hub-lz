resource "azurerm_private_dns_zone" "this" {
  name = var.domain_name
  #   resource_group_name = azurerm_resource_group.this.name
  resource_group_name = var.resource_group_name
  tags                = var.tags

  # create the soa_record block only if the var.soa_record is not empty
  dynamic "soa_record" {
    for_each = var.soa_record != null ? [1] : []
    content {
      email        = var.soa_record.email
      expire_time  = var.soa_record.expire_time
      minimum_ttl  = var.soa_record.minimum_ttl
      refresh_time = var.soa_record.refresh_time
      retry_time   = var.soa_record.retry_time
      ttl          = var.soa_record.ttl
    }
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = var.virtual_network_links

  name                  = each.value.vnetlinkname
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = each.value.vnetid
  registration_enabled  = lookup(each.value, "autoregistration", false)
  tags                  = lookup(each.value, "tags", null)
}