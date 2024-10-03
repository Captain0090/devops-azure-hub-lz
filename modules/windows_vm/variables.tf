variable "resource_group_name" {
  type        = string
  description = "Name of the VM resource group."
  default     = ""
}

variable "location" {
  type        = string
  description = "The Azure Region where the Azure VM should exist."
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet to use in VM"
  default     = ""
}

variable "enable_ip_forwarding" {
  type        = bool
  description = "Should IP Forwarding be enabled? Defaults to false"
  default     = false
}

variable "enable_accelerated_networking" {
  type        = bool
  description = "Should Accelerated Networking be enabled? Defaults to false."
  default     = false
}

variable "private_ip_address_allocation_type" {
  type        = string
  description = "The allocation method used for the Private IP Address. Possible values are Dynamic and Static."
  default     = "Dynamic"
}

variable "boot_diagnostics_storage_account_uri" {
  type        = string
  description = "(Optional) The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics, i"
  default     = null
}

variable "name" {
  type        = string
  description = "The name of the virtual machine."
  default     = ""
}
variable "provision_vm_agent" {
  type        = bool
  description = "Should the Azure VM Agent be provisioned on this Virtual Machine?"
  default     = true
}

variable "size" {
  type        = string
  description = "The Virtual Machine SKU for the Virtual Machine, Default is Standard_A2_V2"
  default     = "Standard_A2_v2"
}

variable "admin_username" {
  type        = string
  description = "(Optional) The username of the local administrator used for the Virtual Machine."
  default     = "adminuser"
}

variable "source_image_reference" {
  type = object({
    publisher = optional(string)
    offer     = optional(string)
    sku       = optional(string)
    version   = optional(string)
  })
  description = "(optional) The details of VM deployment image."
  default     = {}
}

variable "plan" {
  type = object({
    publisher = string
    name      = string
    product   = string
  })
  description = "(Optional) The details of VM deployment plan."
  default     = null
}

variable "enable_automatic_updates" {
  type        = bool
  description = "Specifies if Automatic Updates are Enabled for the Windows Virtual Machine."
  default     = true
}

variable "encryption_at_host_enabled" {
  type        = bool
  description = "Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?"
  default     = true
}

variable "zone" {
  type        = string
  description = "The Zone in which this Virtual Machine should be created. Conflicts with availability set and shouldn't use both"
  default     = null
}

variable "patch_mode" {
  type        = string
  description = "Specifies the mode of in-guest patching to this Windows Virtual Machine. Possible values are `Manual`, `AutomaticByOS` and `AutomaticByPlatform`"
  default     = "AutomaticByOS"
}

variable "license_type" {
  type        = string
  description = "Specifies the type of on-premise license which should be used for this Virtual Machine. Possible values are None, Windows_Client and Windows_Server."
  default     = "Windows_Server"
}

variable "enable_ultra_ssd_data_disk_storage_support" {
  type        = bool
  description = "Should the capacity to enable Data Disks of the UltraSSD_LRS storage account type be supported on this Virtual Machine"
  default     = false
}

variable "managed_identity_type" {
  type        = string
  description = "The type of Managed Identity which should be assigned to the VM. Possible values are `SystemAssigned`, `UserAssigned` and `SystemAssigned, UserAssigned`"
  default     = null
}

variable "managed_identity_ids" {
  type        = list(string)
  description = "A list of User Managed Identity ID's which should be assigned to the VM."
  default     = null
}

variable "os_disk" {
  description = "OS Disk for azure virtual machine"
  type = object({
    name                      = string
    storage_account_type      = string
    size_gb                   = number
    caching                   = optional(string, "ReadWrite")
    write_accelerator_enabled = optional(bool, false)
  })
}

variable "data_disks" {
  description = "Managed Data Disks for azure virtual machine"
  type = map(object({
    name                 = optional(string, null)
    storage_account_type = optional(string, null)
    disk_size_gb         = optional(string, null)
    caching              = optional(string, "ReadWrite")
    lun                  = optional(number, 10)
  }))
  default = {}
}

variable "disk_encryption_set_id" {
  type        = string
  description = "(Optional) The ID of a Disk Encryption Set which should be used to encrypt Managed Disk"
  default     = null

}

variable "os_disk_encryption_set_id" {
  type        = string
  description = "(Optional) The ID of a Disk Encryption Set which should be used to encrypt Managed Disk"
  default     = null

}


variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}


variable "is_jit_enable" {
  type        = bool
  default     = false
  description = "(Optional) To enable JIT on virtual machine."
}

variable "jit_name" {
  type        = string
  default     = ""
  description = "Name of the JIT resource."
}


variable "use_custom_pwd" {
  type        = bool
  default     = false
  description = "Flag to use any custom pwd."
}

variable "pwd" {
  type        = string
  sensitive   = true
  description = "VM Password"
  default     = ""
}

variable "enable_marketplace_agreement" {
  type        = bool
  default     = false
  description = "Enableing MS agreement."
}

variable "nic_name" {
  type        = string
  description = "Name of the n/w interface card."
}

variable "nic_ip_config_name" {
  type        = string
  description = "Name of the n/w interface card."
}