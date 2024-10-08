locals {
  locationshortname = {
    germanywestcentral = "gwc"
  }
  resource_name_suffix = "${var.environment}-${try(local.locationshortname["germanywestcentral"], "${var.location}")}-001"

  tags = {
    Environment = var.environment
    Project     = "Platform"
  }

  private_dns_zones = [
    "privatelink.mysql.database.azure.com",
    "privatelink.vaultcore.azure.net",
    "privatelink.blob.core.windows.net",
    "privatelink.table.core.windows.net",
    "privatelink.queue.core.windows.net",
    "privatelink.file.core.windows.net",
    "privatelink.azurewebsites.net",
    "scm.privatelink.azurewebsites.net",
    "privatelink.redis.cache.windows.net"
  ]
}
