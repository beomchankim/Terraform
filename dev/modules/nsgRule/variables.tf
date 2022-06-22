variable "rg_name" {
  description = "The prefix used for all resources in this example"
  default     = ""
}

variable "nsg_name" {
  default = ""
}

variable "nsg_rule_name" {
  default = ""
}

variable "priority" {
  default = ""
}

variable "direction" {
  default = ""
}

variable "access" {
  default = ""
}

variable "protocol" {
  default = ""
}

variable "source_port_range" {
  default = ""
}

variable "destination_port_range" {
  default = ""
}

variable "source_address_prefix" {
  default = ""
}

variable "destination_address_prefix" {
  default = ""
}
