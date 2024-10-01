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
| <a name="input_enable_bastion"></a> [enable\_bastion](#input\_enable\_bastion) | deploy bastion inside hub network | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment such as dev,UAT or prod | `string` | `"connect"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region where the resource group/resources is created. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_private_dns_zones"></a> [private\_dns\_zones](#input\_private\_dns\_zones) | list of private dns zones | `list(string)` | `[]` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of project for which the infra will create. | `string` | `"hub"` | no |
| <a name="input_resource_groups"></a> [resource\_groups](#input\_resource\_groups) | map of object defines the details of the resource groups | <pre>map(object({<br>    name   = string<br>    region = optional(string)<br>  }))</pre> | <pre>{<br>  "cdn": {<br>    "name": "rg-cdn"<br>  },<br>  "network": {<br>    "name": "rg-network"<br>  },<br>  "privateDnsZones": {<br>    "name": "rg-dns"<br>  }<br>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->