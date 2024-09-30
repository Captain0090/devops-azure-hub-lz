
module "cdn_frontdoor_dev" {
  source                 = "./modules/frontdoor"
  frontdoor_profile_name = "cdn-frontdoor-profile-connect-001"
  resource_group_name    = azurerm_resource_group.rg["cdn"].name
  sku_name               = "Premium_AzureFrontDoor"

  endpoints = [
  ]

  origin_groups = [
  ]

  origins = [

  ]

  custom_domains = [
  ]

  routes = [
  ]

  rule_sets = [
  ]

  firewall_policies = []

  security_policies = [
  ]
  tags = {
    "Environment" : "Connectivity"
  }
}

resource "azapi_update_resource" "dev_frontdoor_system_identity" {
  type        = "Microsoft.Cdn/profiles@2023-02-01-preview"
  resource_id = module.cdn_frontdoor_dev.profile_id
  body = jsonencode({
    "identity" : {
      "type" : "SystemAssigned"
    }
  })
}
