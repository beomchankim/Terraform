variable "rg_name" {
  description = "The prefix used for all resources in this example"
  default     = ""
}

variable "rg_location" {
  description = "The Azure location where all resources in this example should be created"
  default     = ""
}

variable "vnet_name" {
  description = "value"
  default     = ""
}

variable "vnet_address" {
  description = "value"
  type        = list(any)
  default     = [""]
}

variable "dns_servers" {
  description = "value"
  type        = list(any)
  default     = [""]
}

# variable "subnet_name_1" {
#   default = ""
# }

# variable "subnet_address_1" {
#   default = ""
# }

# variable "subnet_name_2" {
#   default = ""
# }

# variable "subnet_address_2" {
#   default = ""
# }
