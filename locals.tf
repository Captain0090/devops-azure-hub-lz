locals {
  resource_name_suffix = "${var.project_name}-${var.environment}-${var.location}-001"

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }

  private_dns_zones = [
    "privatelink.mysql.database.azure.com",
    "privatelink.vaultcore.azure.net",
    "privatelink.blob.core.windows.net",
    "privatelink.table.core.windows.net",
    "privatelink.queue.core.windows.net",
    "privatelink.file.core.windows.net",
    "privatelink.azurewebsites.net",
    "scm.privatelink.azurewebsites.net"
  ]
}
