
variable "environment" {
  type        = string
  description = "Name of the environment such as dev,UAT or prod"
  default     = "hub"
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
    "jumpbox" = {
      name = "rg-jumpserver"
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
      name                                      = string
      address_prefixes                          = list(string)
      private_endpoint_network_policies_enabled = optional(bool, false)
      service_endpoints                         = optional(set(string))
      nsg_name                                  = string
      nsg_rules = optional(list(object({
        name                         = string
        priority                     = string
        direction                    = string
        access                       = string
        protocol                     = string
        source_port_range            = string
        source_port_ranges           = optional(list(string))
        destination_port_range       = optional(string)
        destination_port_ranges      = optional(list(string))
        source_address_prefix        = optional(string)
        source_address_prefixes      = optional(list(string))
        destination_address_prefix   = optional(string)
        destination_address_prefixes = optional(list(string))
      })), [])
      associate_udr = optional(bool, true)
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
  type        = bool
  description = "deploy bastion inside hub network"
  default     = false
}

variable "deploy_jumpbox" {
  type        = bool
  description = "deploy jumpbox server."
  default     = false
}

variable "vm_configuration" {
  type = object({
    nic_name                      = optional(string)
    nic_ip_config_name            = optional(string)
    enable_ip_forwarding          = optional(bool, false)
    private_ip_address_allocation = optional(string)
    admin_username                = optional(string)
    enable_automatic_updates      = optional(bool, true)
    encryption_at_host_enabled    = optional(bool, false)
    license_type                  = optional(string)
    vm_name                       = optional(string)
    provision_vm_agent            = optional(bool, true)
    vm_size                       = optional(string)
    vm_zone                       = optional(string)
    managed_identity_type         = optional(string, "SystemAssigned")
    kv_disk_encryption_name       = optional(string)
    source_image_reference = optional(object({
      publisher = optional(string)
      offer     = optional(string)
      sku       = optional(string)
      version   = optional(string)
    }), {})
    plan = optional(object({
      publisher = optional(string, null)
      name      = optional(string, null)
      product   = optional(string, null)
    }), {})
    os_disk = optional(object({
      name                      = optional(string, null)
      storage_account_type      = optional(string, null)
      size_gb                   = optional(number, null)
      caching                   = optional(string, "ReadWrite")
      write_accelerator_enabled = optional(bool, false)
    }), {})
    data_disks = optional(map(object({
      name                 = optional(string, null)
      storage_account_type = optional(string, null)
      disk_size_gb         = optional(number, null)
      caching              = optional(string, "ReadWrite")
    })), {})
  })
  description = "(optional) The details of virtual machine."
  default     = {}
}

variable "vm_password" {
  type        = string
  sensitive   = true
  description = "VM Password"
  default     = "P@ssword@!2024"
}
