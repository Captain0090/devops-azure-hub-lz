# azurehub
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.90.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | 1.15.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.90.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_azure_privatednszone"></a> [azure\_privatednszone](#module\_azure\_privatednszone) | ./modules/private_dnszones | n/a |
| <a name="module_bastion"></a> [bastion](#module\_bastion) | ./modules/bastion | n/a |
| <a name="module_cdn_frontdoor_dev"></a> [cdn\_frontdoor\_dev](#module\_cdn\_frontdoor\_dev) | ./modules/frontdoor | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |
| <a name="module_virtual_machine"></a> [virtual\_machine](#module\_virtual\_machine) | ./modules/windows_vm | n/a |

## Resources

| Name | Type |
|------|------|
| [azapi_update_resource.dev_frontdoor_system_identity](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/update_resource) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_VirtualNetworks"></a> [VirtualNetworks](#input\_VirtualNetworks) | Create virtual network and subnets. In subnets map of object key is the name of the subnets. | <pre>map(object({<br>    vnet_name        = string<br>    route_table_name = string<br>    routes = optional(map(object({<br>      name                   = string<br>      address_prefix         = string<br>      next_hop_type          = string<br>      next_hop_in_ip_address = optional(string)<br>    })), {})<br>    resource_groups_map_key       = optional(string, "network")<br>    virtual_network_address_space = list(string)<br>    subnets = map(object({<br>      address_prefixes                          = list(string)<br>      private_endpoint_network_policies_enabled = optional(bool, false)<br>      service_endpoints                         = optional(set(string))<br>      nsg_name                                  = string<br>      nsg_rules                                 = optional(list(any), [])<br>      delegations = optional(list(<br>        object(<br>          {<br>            name = string # (Required) A name for this delegation.<br>            service_delegation = object({<br>              name    = string                 # (Required) The name of service to delegate to. Possible values include `Microsoft.ApiManagement/service`, `Microsoft.AzureCosmosDB/clusters`, `Microsoft.BareMetal/AzureVMware`, `Microsoft.BareMetal/CrayServers`, `Microsoft.Batch/batchAccounts`, `Microsoft.ContainerInstance/containerGroups`, `Microsoft.ContainerService/managedClusters`, `Microsoft.Databricks/workspaces`, `Microsoft.DBforMySQL/flexibleServers`, `Microsoft.DBforMySQL/serversv2`, `Microsoft.DBforPostgreSQL/flexibleServers`, `Microsoft.DBforPostgreSQL/serversv2`, `Microsoft.DBforPostgreSQL/singleServers`, `Microsoft.HardwareSecurityModules/dedicatedHSMs`, `Microsoft.Kusto/clusters`, `Microsoft.Logic/integrationServiceEnvironments`, `Microsoft.MachineLearningServices/workspaces`, `Microsoft.Netapp/volumes`, `Microsoft.Network/managedResolvers`, `Microsoft.Orbital/orbitalGateways`, `Microsoft.PowerPlatform/vnetaccesslinks`, `Microsoft.ServiceFabricMesh/networks`, `Microsoft.Sql/managedInstances`, `Microsoft.Sql/servers`, `Microsoft.StoragePool/diskPools`, `Microsoft.StreamAnalytics/streamingJobs`, `Microsoft.Synapse/workspaces`, `Microsoft.Web/hostingEnvironments`, `Microsoft.Web/serverFarms`, `NGINX.NGINXPLUS/nginxDeployments` and `PaloAltoNetworks.Cloudngfw/firewalls`.<br>              actions = optional(list(string)) # (Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include `Microsoft.Network/networkinterfaces/*`, `Microsoft.Network/virtualNetworks/subnets/action`, `Microsoft.Network/virtualNetworks/subnets/join/action`, `Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action` and `Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action`.<br>            })<br>          }<br>        )<br>      ))<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_bastion_name"></a> [bastion\_name](#input\_bastion\_name) | (Required) Specifies the name of the Bastion Host. Changing this forces a new resource to be created | `string` | n/a | yes |
| <a name="input_bastion_pip"></a> [bastion\_pip](#input\_bastion\_pip) | name of the public ip that will be created for bastion host. | `string` | n/a | yes |
| <a name="input_deploy_jumpbox"></a> [deploy\_jumpbox](#input\_deploy\_jumpbox) | deploy jumpbox server. | `bool` | `false` | no |
| <a name="input_enable_bastion"></a> [enable\_bastion](#input\_enable\_bastion) | deploy bastion inside hub network | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment such as dev,UAT or prod | `string` | `"connect"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region where the resource group/resources is created. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_private_dns_zones"></a> [private\_dns\_zones](#input\_private\_dns\_zones) | list of private dns zones | `list(string)` | `[]` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of project for which the infra will create. | `string` | `"hub"` | no |
| <a name="input_resource_groups"></a> [resource\_groups](#input\_resource\_groups) | map of object defines the details of the resource groups | <pre>map(object({<br>    name   = string<br>    region = optional(string)<br>  }))</pre> | <pre>{<br>  "cdn": {<br>    "name": "rg-cdn"<br>  },<br>  "network": {<br>    "name": "rg-network"<br>  },<br>  "privateDnsZones": {<br>    "name": "rg-dns"<br>  }<br>}</pre> | no |
| <a name="input_vm_configuration"></a> [vm\_configuration](#input\_vm\_configuration) | (optional) The details of virtual machine. | <pre>object({<br>    nic_name       = optional(string)<br>    nic_ip_config_name            = optional(string)<br>    enable_ip_forwarding          = optional(bool, false)<br>    private_ip_address_allocation = optional(string)<br>    admin_username                = optional(string)<br>    enable_automatic_updates      = optional(bool, true)<br>    encryption_at_host_enabled    = optional(bool, false)<br>    license_type                  = optional(string)<br>    vm_name                       = optional(string)<br>    provision_vm_agent            = optional(bool, true)<br>    vm_size                       = optional(string)<br>    vm_zone                       = optional(string)<br>    managed_identity_type         = optional(string, "SystemAssigned")<br>    kv_disk_encryption_name       = optional(string)<br>    source_image_reference = optional(object({<br>      publisher = optional(string)<br>      offer     = optional(string)<br>      sku       = optional(string)<br>      version   = optional(string)<br>    }), {})<br>    plan = optional(object({<br>      publisher = optional(string, null)<br>      name      = optional(string, null)<br>      product   = optional(string, null)<br>    }), {})<br>    os_disk = optional(object({<br>      name                      = optional(string, null)<br>      storage_account_type      = optional(string, null)<br>      size_gb                   = optional(number, null)<br>      caching                   = optional(string, "ReadWrite")<br>      write_accelerator_enabled = optional(bool, false)<br>    }), {})<br>    data_disks = optional(map(object({<br>      name                 = optional(string, null)<br>      storage_account_type = optional(string, null)<br>      disk_size_gb         = optional(number, null)<br>      caching              = optional(string, "ReadWrite")<br>    })), {})<br>  })</pre> | `{}` | no |
| <a name="input_vm_password"></a> [vm\_password](#input\_vm\_password) | VM Password | `string` | `"P@ssword@!2024"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->