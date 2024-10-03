variable "domain_name" {
  type        = string
  description = "The name of the private dns zone."
}

# This assumes resource group is already created and its name passed to this module
variable "resource_group_name" {
  type        = string
  description = "The resource group where the resources will be deployed."
}

variable "soa_record" {
  type = object({
    email        = string
    expire_time  = optional(number, 2419200)
    minimum_ttl  = optional(number, 10)
    refresh_time = optional(number, 3600)
    retry_time   = optional(number, 300)
    ttl          = optional(number, 3600)
    tags         = optional(map(string), null)
  })
  default     = null
  description = "optional soa_record variable, if included only email is required, rest are optional. Email must use username.corp.com and not username@corp.com"
}

variable "virtual_network_links" {
  type = map(object({
    vnetlinkname     = string
    vnetid           = string
    autoregistration = optional(bool, false)
    tags             = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a virtual network link."
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}