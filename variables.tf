variable "rg_name" {
  description = "The prefix used for all resources in this example"
  default     = "rg-bckim"
}

variable "rg_location" {
  description = "The Azure location where all resources in this example should be created"
  default     = "koreacentral"
}

variable "vnet_name" {
  default = "vnet-bckim-01"
}

variable "vnet_address" {
  type    = list(any)
  default = ["10.0.0.0/16"]
}

variable "dns_servers" {
  type    = list(any)
  default = ["10.0.0.4", "10.0.0.5"]
}

variable "subnet_name_1" {
  default = "snet-bckim-01"
}

variable "subnet_address_1" {
  type    = list(any)
  default = ["10.0.1.0/24"]
}

variable "subnet_name_2" {
  default = "snet-bckim-02"
}

variable "subnet_address_2" {
  default = "10.0.2.0/24"
}
