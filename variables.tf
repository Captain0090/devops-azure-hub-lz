variable "project_name" {
  type        = string
  default     = "hub"
  description = "Name of project for which the infra will create."
}

variable "environment" {
  type        = string
  description = "Name of the environment such as dev,UAT or prod"
  default     = "connectivity"
}

variable "location" {
  type        = string
  description = <<DESCRIPTION
  The location/region where the resource group/resources is created. Changing this forces a new resource to be created.
  DESCRIPTION
}

variable "resource_groups" {
  type = map(object({
    name   = string
    region = optional(string)
  }))
  description = "map of object defines the details of the resource groups"
  default = {
    "network" = {
      name = "rg-network"
    }
    "cdn" = {
      name = "rg-cdn"
    }
    "privateDnsZones" = {
      name = "rg-dns"
    }
  }
}

variable "VirtualNetworks" {
  type = map(object({
    vnet_name        = string
    route_table_name = string
    routes = optional(map(object({
      name                   = string
      address_prefix         = string
      next_hop_type          = string
      next_hop_in_ip_address = optional(string)
    })), {})
    resource_groups_map_key       = optional(string, "network")
    virtual_network_address_space = list(string)
    subnets = map(object({
      address_prefixes                          = list(string)
      private_endpoint_network_policies_enabled = optional(bool, false)
      service_endpoints                         = optional(set(string))
      nsg_name                                  = string
      nsg_rules                                 = optional(list(any), [])
      delegations = optional(list(
        object(
          {
            name = string # (Required) A name for this delegation.
            service_delegation = object({
              name    = string                 # (Required) The name of service to delegate to. Possible values include `Microsoft.ApiManagement/service`, `Microsoft.AzureCosmosDB/clusters`, `Microsoft.BareMetal/AzureVMware`, `Microsoft.BareMetal/CrayServers`, `Microsoft.Batch/batchAccounts`, `Microsoft.ContainerInstance/containerGroups`, `Microsoft.ContainerService/managedClusters`, `Microsoft.Databricks/workspaces`, `Microsoft.DBforMySQL/flexibleServers`, `Microsoft.DBforMySQL/serversv2`, `Microsoft.DBforPostgreSQL/flexibleServers`, `Microsoft.DBforPostgreSQL/serversv2`, `Microsoft.DBforPostgreSQL/singleServers`, `Microsoft.HardwareSecurityModules/dedicatedHSMs`, `Microsoft.Kusto/clusters`, `Microsoft.Logic/integrationServiceEnvironments`, `Microsoft.MachineLearningServices/workspaces`, `Microsoft.Netapp/volumes`, `Microsoft.Network/managedResolvers`, `Microsoft.Orbital/orbitalGateways`, `Microsoft.PowerPlatform/vnetaccesslinks`, `Microsoft.ServiceFabricMesh/networks`, `Microsoft.Sql/managedInstances`, `Microsoft.Sql/servers`, `Microsoft.StoragePool/diskPools`, `Microsoft.StreamAnalytics/streamingJobs`, `Microsoft.Synapse/workspaces`, `Microsoft.Web/hostingEnvironments`, `Microsoft.Web/serverFarms`, `NGINX.NGINXPLUS/nginxDeployments` and `PaloAltoNetworks.Cloudngfw/firewalls`.
              actions = optional(list(string)) # (Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include `Microsoft.Network/networkinterfaces/*`, `Microsoft.Network/virtualNetworks/subnets/action`, `Microsoft.Network/virtualNetworks/subnets/join/action`, `Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action` and `Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action`.
            })
          }
        )
      ))
    }))
  }))
  description = "Create virtual network and subnets. In subnets map of object key is the name of the subnets."
  default     = {}
}

variable "bastion_name" {
  type        = string
  description = "(Required) Specifies the name of the Bastion Host. Changing this forces a new resource to be created"
}

variable "bastion_pip" {
  type        = string
  description = "name of the public ip that will be created for bastion host."
}

variable "private_dns_zones" {
  type        = list(string)
  description = "list of private dns zones"
  default     = []
}

variable "enable_bastion" {
  type = bool
  description = "deploy bastion inside hub network"
  default = false
}