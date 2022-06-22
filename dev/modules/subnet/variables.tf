variable "rg_name" {
  default = ""
}

variable "rg_location" {
  default = ""
}

variable "subnet_name" {
  default = ""
}

variable "subnet_address" {
  type    = list(any)
  default = [""]
}

variable "vnet_name" {
  default = ""
}

