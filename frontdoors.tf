
module "cdn_frontdoor_dev" {
  source                 = "./modules/frontdoor"
  frontdoor_profile_name = "cdn-frontdoor-profile-connect-001"
  resource_group_name    = azurerm_resource_group.rg["cdn"].name
  sku_name               = "Premium_AzureFrontDoor"

  endpoints = [
    {
      custom_resource_name = "cityagenda-dev"
      name                 = "cityagenda-dev"
      enabled              = true
    }
  ]

  origin_groups = [
    {
      custom_resource_name = "cityagenda-dev"
      name                 = "cityagenda-dev"
    }
  ]

  origins = [
    {
      custom_resource_name           = "app-cityagenda-dev-eastus-001"
      name                           = "cityagenda-dev-origin"
      origin_group_name              = "cityagenda-dev"
      certificate_name_check_enabled = true
      host_name                      = "app-cityagenda-dev-gwc-001.azurewebsites.net"
      origin_host_header             = "app-cityagenda-dev-gwc-001.azurewebsites.net"
      http_port                      = 80
      https_port                     = 443
      private_link = {
        request_message        = "request from frontdoor"
        target_type            = "sites"
        location               = "germanywestcentral"
        private_link_target_id = data.azurerm_app_service.cityagenda-dev.id
      }
    }
  ]

  custom_domains = [
  ]

  routes = [
    {
      enabled              = true
      custom_resource_name = "cityagenda-dev-route"
      name                 = "cityagenda"
      endpoint_name        = "cityagenda-dev"
      origin_group_name    = "cityagenda-dev"
      origins_names        = ["cityagenda-dev-origin"]
      forwarding_protocol  = "MatchRequest"
      patterns_to_match    = ["/*"]
      supported_protocols  = ["Http", "Https"]
      rule_sets_names      = ["my_rule_set"]
      #   custom_domains_names = [""]
    }
  ]

  rule_sets = [
    {
      name                 = "my_rule_set"
      custom_resource_name = "cityagendaRuleset001"
    }
  ]

  firewall_policies = [
    {
      custom_resource_name = "cdnfrontdoorwafpolicydevconnect001"
      name                 = "wafpolicy-cityagenda-001"
      enabled              = true
      mode                 = "Prevention"
      #redirect_url                      = ""
      custom_block_response_status_code = 403
      custom_block_response_body        = "PGh0bWw+PGhlYWQ+PHRpdGxlPkZvcmJpZGRlbjwvdGl0bGU+PC9oZWFkPjxib2R5Pnt7YXp1cmUtcmVmfX0="


      managed_rules = [
        {
          type       = "Microsoft_DefaultRuleSet"
          version    = "2.1"
          action     = "Log"
          exclusions = []
          overrides  = []
        },
        {
          type    = "Microsoft_BotManagerRuleSet"
          version = "1.0"
          action  = "Log"
        },
      ]
    }
  ]

  security_policies = [
    {
      name                 = "secpolicy-tk-001"
      custom_resource_name = "cdn-frontdoor-secpolicy-cityagenda-dev-001"
      firewall_policy_name = "wafpolicy-cityagenda-001"
      patterns_to_match    = ["/*"]
      #   custom_domain_names  = []
      endpoint_names = ["cityagenda-dev"]
    }
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

data "azurerm_app_service" "cityagenda-dev" {
  name                = "app-cityagenda-dev-gwc-001"
  resource_group_name = "rg-cityagenda-dev-gwc-001"
  provider            = azurerm.app_dev
}
