variable "resource_group_name" {
  type        = string
  description = "(Required) The resource group where the resource is created. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "(Required) The location/region where the virtual network is created. Changing this forces a new resource to be created."
}

variable "pup_ip_name" {
  type        = string
  description = "name of the public ip that will be created for bastion host."
}

variable "bastion_name" {
  type        = string
  description = "(Required) Specifies the name of the Bastion Host. Changing this forces a new resource to be created"
}

variable "subnet_id" {
  type        = string
  description = "(Required) Reference to a subnet in which this Bastion Host has been created. Changing this forces a new resource to be created."
}

variable "tags" {
  type        = map(string)
  description = " (Optional) A mapping of tags to assign to the resource."
  default     = {}
}