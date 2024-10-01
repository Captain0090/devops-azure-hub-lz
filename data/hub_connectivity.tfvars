location = "eastus"

VirtualNetworks = {
  vnet_hub = {
    vnet_name                     = "vnet"
    virtual_network_address_space = ["192.168.1.0/24"]
    route_table_name              = "udr"
    subnets = {
      bastion = {
        name             = "snet-bastion"
        address_prefixes = ["192.168.1.224/27"]
        nsg_rules        = "nsg-bastion-hub-connectivity-eastus2-001"
        nsg_rules        = []
      }
    }
  }
}

# bastion
enable_bastion = true
bastion_name = "bastion-hub-connectivity-eastus2-001"
bastion_pip  = "pip-hub-connectivity-eastus2-001"

#