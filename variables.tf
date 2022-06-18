############################## Resource Group ##############################
variable "rg_object" {
  default = {
    "rg-hub-bckim" = {
      rg_name = "rg-hub-bckim"
      rg_location = "KoreaCentral"
    },
    "rg-prd-bckim" = {
      rg_name = "rg-prd-bckim"
      rg_location = "KoreaCentral"
    },
    "rg-dev-bckim" = {
      rg_name = "rg-dev-bckim"
      rg_location = "KoreaCentral"
    }
  }
}

############################## VNET ##############################
variable "vnet_object" {
  default = {
    "vnet-hub-bckim" = {
      rg_name    = "rg-hub-bckim"
      vnet_address = ["10.0.0.0/16"]
    },
    "vnet-prd-bckim" = {
      rg_name    = "rg-prd-bckim"
      vnet_address = ["20.0.0.0/16"]
    },
    "vnet-dev-bckim" = {
      rg_name    = "rg-dev-bckim"
      vnet_address = ["30.0.0.0/16"]
    }
  }
}

############################## Subnet ##############################
variable "subnet_object" {
  default = {
    "snet-hub-bckim-agw-10.0.1.0-24" = {
      subnet_address = ["10.0.1.0-24"]
      vnet_name      = "snet-hub-bckim-agw-10.0.1.0-24"
    },
    "snet-hub-bckim-mgt-10.0.2.0-24" = {
      subnet_address = ["10.0.2.0-24"]
      vnet_name      = "snet-hub-bckim-mgt-10.0.2.0-24"
    },
    "snet-prd-bckim-web-20.0.1.0-24" = {
      subnet_address = ["20.0.1.0/24"]
      vnet_name      = "snet-prd-bckim-web-20.0.1.0-24"
    },
    "snet-prd-bckim-db-20.0.2.0-24" = {
      subnet_address = ["20.0.2.0/24"]
      vnet_name      = "snet-prd-bckim-db-20.0.2.0-24"
    },
    "snet-dev-bckim-web-30.0.1.0-24" = {
      subnet_address = ["30.0.1.0/24"]
      vnet_name      = "snet-dev-bckim-web-30.0.1.0-24"
    },
    "snet-dev-bckim-db-30.0.2.0-24" = {
      subnet_address = ["30.0.2.0/24"]
      vnet_name      = "snet-dev-bckim-db-30.0.2.0-24"
    }
  }
}

############################## NSG ##############################
variable "nsg_object" {
  default = {
    "nsg-prd-bckim-web01" = {
      nsg_name    = "nsg-prd-bckim-web01"
      subnet_name = "snet-prd-bckim-web-172.27.0.0-26"
    },
    "nsg-prd-bckim-was01" = {
      nsg_name    = "nsg-prd-bckim-was01"
      subnet_name = "snet-prd-bckim-was-172.27.0.64-26"
    },
    "nsg-prd-bckim-brdb01" = {
      nsg_name    = "nsg-prd-bckim-brdb01"
      subnet_name = "snet-prd-bckim-brdb-172.27.0.128-26"
    },
    "nsg-dev-bckim-web01" = {
      nsg_name    = "nsg-dev-bckim-brdb01"
      subnet_name = "snet-dev-bckim-web-192.168.0.0-26"
    }
  }
}

############################## NSG Rule ##############################
variable "nsg_rule_object" {
  default = {
    "nsg-prd-bckim-web01-ssh" = {
      nsg_name                   = "nsg-prd-bckim-web01"
      nsg_rule_name              = "nsg-prd-bckim-web01-ssh"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    "nsg-prd-bckim-web01-http" = {
      nsg_name                   = "nsg-prd-bckim-was01"
      nsg_rule_name              = "nsg-prd-bckim-was01-http"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    "nsg-prd-bckim-brdb01-http" = {
      nsg_name                   = "nsg-prd-bckim-brdb01"
      nsg_rule_name              = "nsg-prd-bckim-brdb01-http"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    "nsg-dev-bckim-web01-http" = {
      nsg_name                   = "nsg-dev-bckim-web01"
      nsg_rule_name              = "nsg-dev-bckim-web01-http"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

############################## PIP ############################
variable "pip_object" {
  default = {
    "pip-agw-bckim-prd-01" = {
      pip_name          = "pip-agw-bckim-prd-01"
      allocation_method = "Static"
      pip_sku           = "Standard"
    }
  }
}

############################## VM ##############################
variable "vm_object" {
  default = {
    "vm-prd-bckim-web-01" = {
      nic_name                      = "nic-bckim-test-01"
      subnet_name                   = "snet-prd-bckim-web-172.27.0.0-26"
      ip_name                       = "pip01"
      private_ip_address_allocation = "Static"
      private_ip_address            = "172.27.0.6"

      vm_name = "vm-prd-bckim-web-01"
      vm_size = "Standard_B1s"

      storage_image_publisher = "OpenLogic"
      storage_image_offer     = "CentOS"
      storage_image_sku       = "7_6-gen2"
      storage_image_version   = "latest"

      storage_os_disk_name          = "ssd01"
      storage_os_disk_caching       = "ReadWrite"
      storage_os_disk_create_option = "FromImage"
      storage_os_disk_type          = "Premium_LRS"
      storage_os_disk_size_gb       = "50"

      os_profile_computer_name  = "vm-prd-bckim-web-01"
      os_profile_admin_username = "bckim"
      os_profile_admin_password = "qwer1234!@#$"
    },
    "vm-prd-bckim-web-02" = {
      nic_name                      = "nic02"
      subnet_name                   = "snet-prd-bckim-web-172.27.0.0-26"
      ip_name                       = "nic02"
      private_ip_address_allocation = "Static"
      private_ip_address            = "172.27.0.7"

      vm_name = "vm-prd-bckim-web-02"
      vm_size = "Standard_B1s"

      storage_image_publisher = "OpenLogic"
      storage_image_offer     = "CentOS"
      storage_image_sku       = "7_6-gen2"
      storage_image_version   = "latest"

      storage_os_disk_name          = "ssd02"
      storage_os_disk_caching       = "ReadWrite"
      storage_os_disk_create_option = "FromImage"
      storage_os_disk_type          = "Standard_LRS"
      storage_os_disk_size_gb       = null

      os_profile_computer_name  = "vm-prd-bckim-web-02"
      os_profile_admin_username = "bckim"
      os_profile_admin_password = "qwer1234!@#$"
    },
    "vm-prd-bckim-web-03" = {
      nic_name                      = "nic03"
      subnet_name                   = "snet-dev-bckim-web-192.168.0.0-26"
      ip_name                       = "nic03"
      private_ip_address_allocation = "Static"
      private_ip_address            = "192.168.0.5"

      vm_name = "vm-prd-bckim-web-03"
      vm_size = "Standard_B1s"

      storage_image_publisher = "OpenLogic"
      storage_image_offer     = "CentOS"
      storage_image_sku       = "7_6-gen2"
      storage_image_version   = "latest"

      storage_os_disk_name          = "ssd03"
      storage_os_disk_caching       = "ReadWrite"
      storage_os_disk_create_option = "FromImage"
      storage_os_disk_type          = "Standard_LRS"
      storage_os_disk_size_gb       = null

      os_profile_computer_name  = "vm-prd-bckim-web-03"
      os_profile_admin_username = "bckim"
      os_profile_admin_password = "qwer1234!@#$"
    },
    "vm-prd-bckim-web-04" = {
      nic_name                      = "nic04"
      subnet_name                   = "snet-dev-bckim-web-192.168.0.0-26"
      ip_name                       = "nic04"
      private_ip_address_allocation = "Static"
      private_ip_address            = "192.168.0.4"

      vm_name = "vm-prd-bckim-web-04"
      vm_size = "Standard_B1s"

      storage_image_publisher = "OpenLogic"
      storage_image_offer     = "CentOS"
      storage_image_sku       = "7_6-gen2"
      storage_image_version   = "latest"

      storage_os_disk_name          = "ssd04"
      storage_os_disk_caching       = "ReadWrite"
      storage_os_disk_create_option = "FromImage"
      storage_os_disk_type          = "Standard_LRS"
      storage_os_disk_size_gb       = null

      os_profile_computer_name  = "vm-prd-bckim-web-04"
      os_profile_admin_username = "bckim"
      os_profile_admin_password = "qwer1234!@#$"
    },
    "vm-prd-bckim-web-05" = {
      nic_name                      = "nic05"
      subnet_name                   = "snet-prd-bckim-web-172.27.0.0-26"
      ip_name                       = "nic05"
      private_ip_address_allocation = "Static"
      private_ip_address            = "172.27.0.5"

      vm_name = "vm-prd-bckim-web-05"
      vm_size = "Standard_B1s"

      storage_image_publisher = "OpenLogic"
      storage_image_offer     = "CentOS"
      storage_image_sku       = "7_6-gen2"
      storage_image_version   = "latest"

      storage_os_disk_name          = "ssd05"
      storage_os_disk_caching       = "ReadWrite"
      storage_os_disk_create_option = "FromImage"
      storage_os_disk_type          = "Standard_LRS"
      storage_os_disk_size_gb       = null

      os_profile_computer_name  = "vm-prd-bckim-web-05"
      os_profile_admin_username = "bckim"
      os_profile_admin_password = "qwer1234!@#$"
    }
  }
}

############################## Vnet Peering ##############################
variable "peering_object" {
  default = {
    "prd-peer-dev" = {
      vnet_name        = "vnet-prd-bckim"
      remote_vnet_name = "vnet-dev-bckim"
    },
    "dev-peer-prd" = {
      vnet_name        = "vnet-dev-bckim"
      remote_vnet_name = "vnet-prd-bckim"
    }
  }
}

############################## AGW ##############################
variable "agw_object" {
  default = {
    "agw-bckim-prd-01" = {
      sku_name = "Standard_v2"
      sku_tier = "Standard_v2"
      capacity = "2"

      agw_ip_name = "pip-agw-bckim-prd-01"
      subnet_name = "snet-prd-bckim-agw-172.27.1.0-24"

      frontend_port_name = "agw-frontend-prd-01"
      frontend_port      = "80"
      frontend_ip_name   = "pip-agw-bckim-prd-01"

      backend_address_pool_name = "agw-backend-prd-01"

      http_setting_name     = "agw-http-prd-01"
      cookie_based_affinity = "Disabled"

      backend_path            = "/"
      backend_port            = "80"
      backend_protocol        = "Http"
      backend_request_timeout = "60"

      listener_name                  = "agw-listen-prd-01"
      frontend_ip_configuration_name = "pip-agw-bckim-prd-01"
      listener_protocol              = "Http"
      request_routing_rule_name      = "agw-routing-rule-prd-01"
      rule_type                      = "Basic"
    }
  }
}
