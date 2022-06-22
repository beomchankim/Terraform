variable "rg_name" {
  description = "The prefix used for all resources in this example"
  default     = ""
}

variable "rg_location" {
  description = "The Azure location where all resources in this example should be created"
  default     = ""
}

variable "nic_name" {
  default = ""
}

variable "private_ip_address_allocation" {
  default = ""
}

variable "private_ip_address" {
  default = ""
}

variable "subnet_name" {
  default = ""
}

variable "subnet_id" {
  default = ""
}

variable "ip_name" {
  default = ""
}

################ VM ################
variable "vm_name" {
  default = ""
}

variable "vm_size" {
  default = ""
}

variable "storage_image_publisher" {
  default = ""
}

variable "storage_image_offer" {
  default = ""
}

variable "storage_image_sku" {
  default = ""
}

variable "storage_image_version" {
  default = ""
}

variable "storage_os_disk_name" {
  default = ""
}

variable "storage_os_disk_caching" {
  default = ""
}

variable "storage_os_disk_create_option" {
  default = ""
}

variable "storage_os_disk_type" {
  default = ""
}

variable "storage_os_disk_size_gb" {
  default = ""
}

variable "os_profile_computer_name" {
  default = ""
}

variable "os_profile_admin_username" {
  default = ""
}

variable "os_profile_admin_password" {
  default = ""
}





