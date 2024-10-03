location = "germanywestcentral"

VirtualNetworks = {
  vnet_hub = {
    vnet_name                     = "vnet"
    virtual_network_address_space = ["10.68.0.0/20"]
    route_table_name              = "udr"
    subnets = {
      bastion = {
        name             = "AzureBastionSubnet"
        address_prefixes = ["10.68.0.128/26"]
        associate_udr    = false
        nsg_name         = "nsg-bastion-hub-connectivity-gwc-001"
        nsg_rules = [
          {
            name                       = "AllowHttpsInbound"
            priority                   = "120"
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            source_address_prefix      = "Internet"
            destination_port_range     = "443"
            destination_address_prefix = "*"
          },
          {
            name                       = "AllowGatewayManagerInbound"
            priority                   = "130"
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            source_address_prefix      = "GatewayManager"
            destination_port_range     = "443"
            destination_address_prefix = "*"
          },
          {
            name                       = "AllowAzureLoadBalancerInbound"
            priority                   = "140"
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            source_address_prefix      = "AzureLoadBalancer"
            destination_port_range     = "443"
            destination_address_prefix = "*"
          },
          {
            name                       = "AllowBastionHostCommunication"
            priority                   = "150"
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "*"
            source_port_range          = "*"
            source_address_prefix      = "VirtualNetwork"
            destination_port_ranges    = ["8080", "5701"]
            destination_address_prefix = "VirtualNetwork"
          },
          {
            name                       = "AllowSshRdpOutbound"
            priority                   = "100"
            direction                  = "Outbound"
            access                     = "Allow"
            protocol                   = "*"
            source_port_range          = "*"
            source_address_prefix      = "*"
            destination_port_ranges    = ["22", "3389"] # rdp [3389] must be open for the bastion to accept the nsg
            destination_address_prefix = "VirtualNetwork"
          },
          {
            name                       = "AllowAzureCloudOutbound"
            priority                   = "110"
            direction                  = "Outbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            source_address_prefix      = "*"
            destination_port_range     = "443"
            destination_address_prefix = "AzureCloud"
          },
          {
            name                       = "AllowBastionCommunication"
            priority                   = "120"
            direction                  = "Outbound"
            access                     = "Allow"
            protocol                   = "*"
            source_port_range          = "*"
            source_address_prefix      = "VirtualNetwork"
            destination_port_ranges    = ["8080", "5701"]
            destination_address_prefix = "VirtualNetwork"
          },
          {
            name                       = "AllowHttpOutbound"
            priority                   = "130"
            direction                  = "Outbound"
            access                     = "Allow"
            protocol                   = "*"
            source_port_range          = "*"
            source_address_prefix      = "*"
            destination_port_range     = "80"
            destination_address_prefix = "Internet"
          }
        ]
      }
      vm = {
        name             = "snet-vm"
        address_prefixes = ["10.68.2.0/28"]
        nsg_name         = "nsg-vm-hub-connectivity-gwc-001"
        nsg_rules = [{
          name                       = "AllowBastionRDPInbound"
          priority                   = "100"
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "3389"
          source_address_prefix      = "10.68.0.128/26"
          destination_port_range     = "*"
          destination_address_prefix = "10.68.2.0/28"
          },
          {
            name                       = "DenyInbound"
            priority                   = "500"
            direction                  = "Inbound"
            access                     = "Deny"
            protocol                   = "*"
            source_port_range          = "*"
            source_address_prefix      = "*"
            destination_port_range     = "*"
            destination_address_prefix = "10.68.2.0/28"
          }
        ]
      }
    }
  }
}

# bastion
enable_bastion = true
bastion_name   = "bastion-hub-connectivity-gwc-001"
bastion_pip    = "pip-hub-connectivity-gwc-001"

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
