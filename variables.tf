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
      rg_name        = "rg-hub-bckim"
      subnet_address = ["10.0.1.0-24"]
      vnet_name      = "vnet-hub-bckim"
    },
    "snet-hub-bckim-mgt-10.0.2.0-24" = {
      rg_name        = "rg-hub-bckim"
      subnet_address = ["10.0.2.0-24"]
      vnet_name      = "vnet-hub-bckim"
    },
    "snet-prd-bckim-web-20.0.1.0-24" = {
      rg_name        = "rg-prd-bckim"
      subnet_address = ["20.0.1.0/24"]
      vnet_name      = "vnet-prd-bckim"
    },
    "snet-prd-bckim-db-20.0.2.0-24" = {
      rg_name        = "rg-prd-bckim"
      subnet_address = ["20.0.2.0/24"]
      vnet_name      = "vnet-prd-bckim"
    },
    "snet-dev-bckim-web-30.0.1.0-24" = {
      rg_name        = "rg-dev-bckim"
      subnet_address = ["30.0.1.0/24"]
      vnet_name      = "vnet-dev-bckim"
    },
    "snet-dev-bckim-db-30.0.2.0-24" = {
      rg_name        = "rg-dev-bckim"
      subnet_address = ["30.0.2.0/24"]
      vnet_name      = "vnet-dev-bckim"
    }
  }
}

############################## NSG ##############################
variable "nsg_object" {
  default = {
    "nsg-hub-mgt" = {

      subnet_name = "snet-hub-mgt-bckim-10.0.2.0-24"
    },
    "nsg-prd-web" = {
      subnet_name = "snet-prd-web-bckim-20.0.1.0-24"
    },
    "nsg-dev-web" = {
      subnet_name = "snet-dev-bckim-web-30.0.1.0-24"
    }
  }
}

############################## NSG Rule ##############################
variable "nsg_rule_object" {
  default = {
    "nsg-rule-hub-mgt-ssh" = {
      nsg_name                   = "nsg-hub-mgt"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    "nsg-rule-prd-web-ssh" = {
      nsg_name                   = "nsg-prd-web"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    "nsg-rule-prd-web-http" = {
      nsg_name                   = "nsg-prd-web"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    "nsg-rule-dev-web-ssh" = {
      nsg_name                   = "nsg-dev-web"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    "nsg-rule-dev-web-http" = {
      nsg_name                   = "nsg-dev-web"
      priority                   = 110
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
    "vm-hub-mgt-bckim-01" = {
      nic_name                      = "nic-hub-mgt-bckim-01"
      subnet_name                   = "snet-hub-bckim-mgt-10.0.2.0-24"
      ip_name                       = "pip-hub-mgt-bckim-01"
      private_ip_address_allocation = "Static"
      private_ip_address            = "10.0.0.11"

      vm_name = "vm-hub-mgt-bckim-01"
      vm_size = "Standard_B1s"

      storage_image_publisher = "OpenLogic"
      storage_image_offer     = "CentOS"
      storage_image_sku       = "7_6-gen2"
      storage_image_version   = "latest"

      storage_os_disk_name          = "osdisk-hub-mgt-bckim-01"
      storage_os_disk_caching       = "ReadWrite"
      storage_os_disk_create_option = "FromImage"
      storage_os_disk_type          = "Premium_LRS"
      storage_os_disk_size_gb       = "30"

      os_profile_computer_name  = "vm-hub-mgt-bckim-01"
      os_profile_admin_username = "bckim"
      os_profile_admin_password = "qjacksdl293!"
    },
    "vm-prd-web-bckim-01" = {
      nic_name                      = "nic-prd-web-bckim-01"
      subnet_name                   = "snet-prd-web-bckim-20.0.1.0-24"
      ip_name                       = "pip-prd-web-bckim-01"
      private_ip_address_allocation = "Static"
      private_ip_address            = "20.0.0.11"

      vm_name = "vm-prd-web-bckim-01"
      vm_size = "Standard_B1s"

      storage_image_publisher = "OpenLogic"
      storage_image_offer     = "CentOS"
      storage_image_sku       = "7_6-gen2"
      storage_image_version   = "latest"

      storage_os_disk_name          = "osdisk-prd-web-bckim-01"
      storage_os_disk_caching       = "ReadWrite"
      storage_os_disk_create_option = "FromImage"
      storage_os_disk_type          = "Standard_LRS"
      storage_os_disk_size_gb       = "50"

      os_profile_computer_name  = "vm-prd-web-bckim-01"
      os_profile_admin_username = "bckim"
      os_profile_admin_password = "qjacksdl293!"
    },
    "vm-prd-web-bckim-02" = {
      nic_name                      = "nic-prd-web-bckim-01"
      subnet_name                   = "snet-prd-web-bckim-20.0.1.0-24"
      ip_name                       = "pip-prd-web-bckim-02"
      private_ip_address_allocation = "Static"
      private_ip_address            = "20.0.0.12"

      vm_name = "vm-prd-web-bckim-02"
      vm_size = "Standard_B1s"

      storage_image_publisher = "OpenLogic"
      storage_image_offer     = "CentOS"
      storage_image_sku       = "7_6-gen2"
      storage_image_version   = "latest"

      storage_os_disk_name          = "osdisk-prd-web-bckim-02"
      storage_os_disk_caching       = "ReadWrite"
      storage_os_disk_create_option = "FromImage"
      storage_os_disk_type          = "Standard_LRS"
      storage_os_disk_size_gb       = "50"

      os_profile_computer_name  = "vm-prd-web-bckim-02"
      os_profile_admin_username = "bckim"
      os_profile_admin_password = "qjacksdl293!"
    },
    "vm-dev-web-bckim-01" = {
      nic_name                      = "nic-dev-web-bckim-01"
      subnet_name                   = "snet-dev-web-bckim-30.0.1.0-24"
      ip_name                       = "pip-dev-web-bckim-01"
      private_ip_address_allocation = "Static"
      private_ip_address            = "30.0.0.11"

      vm_name = "vm-dev-web-bckim-01"
      vm_size = "Standard_B1s"

      storage_image_publisher = "OpenLogic"
      storage_image_offer     = "CentOS"
      storage_image_sku       = "7_6-gen2"
      storage_image_version   = "latest"

      storage_os_disk_name          = "osdisk-dev-web-bckim-01"
      storage_os_disk_caching       = "ReadWrite"
      storage_os_disk_create_option = "FromImage"
      storage_os_disk_type          = "Standard_LRS"
      storage_os_disk_size_gb       = "50"

      os_profile_computer_name  = "vm-dev-web-bckim-01"
      os_profile_admin_username = "bckim"
      os_profile_admin_password = "qjacksdl293!"
    }
  }
}

############################## Vnet Peering ##############################
variable "peering_object" {
  default = {
    "hub-peer-prd" = {
      vnet_name        = "vnet-hub-bckim"
      remote_vnet_name = "vnet-prd-bckim"
    },
    "hub-peer-dev" = {
      vnet_name        = "vnet-hub-bckim"
      remote_vnet_name = "vnet-dev-bckim"
    }
  }
}

############################## AGW ##############################
variable "agw_object" {
  default = {
    "agw-hub-bckim-01" = {
      sku_name = "Standard_v2"
      sku_tier = "Standard_v2"
      capacity = "2"

      subnet_name = "snet-hub-agw-bckim-10.0.1.0-24"
      agw_ip_name = "pip-agw-hub-bckim-01"

      frontend_port_name = "agw-frontport-prd-web-80"
      frontend_port      = "80"
      frontend_ip_name   = "pip-agw-hub-bckim-01"

      backend_address_pool_name = "agw-backpool-prd-web-01"

      http_setting_name     = "agw-httpsetting-prd-web-01"
      cookie_based_affinity = "Disabled"

      backend_path            = "/"
      backend_port            = "80"
      backend_protocol        = "Http"
      backend_request_timeout = "60"

      listener_name                  = "agw-listener-prd-web-80"
      frontend_ip_configuration_name = "pip-agw-hub-bckim-01"
      listener_protocol              = "Http"
      request_routing_rule_name      = "agw-routingrule-prd-web-01"
      rule_type                      = "Basic"
    }
  }
}
