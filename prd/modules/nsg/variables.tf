variable "rg_name" {
  description = "The prefix used for all resources in this example"
  default     = ""
}

variable "rg_location" {
  description = "The Azure location where all resources in this example should be created"
  default     = ""
}

variable "nsg_name" {
  default = ""
}

variable "subnet_name" {
  default = ""
}

variable "subnet_id" {
  default = ""
}
