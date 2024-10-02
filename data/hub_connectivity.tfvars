location = "germanywestcentral"

VirtualNetworks = {
  vnet_hub = {
    vnet_name                     = "vnet"
    virtual_network_address_space = ["10.68.0.0/20"]
    route_table_name              = "udr"
    subnets = {
      bastion = {
        name             = "snet-bastion"
        address_prefixes = ["10.68.0.128/26"]
        nsg_rules        = "nsg-bastion-hub-connectivity-eastus-001"
        nsg_rules        = []
      }
      vm = {
        name             = "snet-vm"
        address_prefixes = ["10.68.2.0/28"]
        nsg_rules        = "nsg-bastion-hub-connectivity-eastus-001"
        nsg_rules        = []
      }
    }
  }
}

# bastion
enable_bastion = true
bastion_name = "bastion-hub-connectivity-eastus-001"
bastion_pip  = "pip-hub-connectivity-eastus-001"

#jump server
vm_configuration = {
  nic_name                      = "az-nic-eus-001"
  nic_ip_config_name            = "az-nicip-eus-001"
  private_ip_address_allocation = "Dynamic"
  admin_username                = "cloudadmin"
  license_type                  = "Windows_Server"
  vm_name                       = "azvm-eus-001"
  vm_size                       = "Standard_D2s_v3"
  vm_zone                       = "1"
  managed_identity_type         = "SystemAssigned"
  os_disk = {
    caching              = "ReadWrite"
    disk_size_gb         = "128"
    name                 = "az001_Local_Disk"
    storage_account_type = "Premium_LRS"
  }
  source_image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }
}