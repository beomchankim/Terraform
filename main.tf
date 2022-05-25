locals {
  rg_name             = var.rg_name
  rg_location         = var.rg_location
  vnet_name           = var.vnet_name
  vnet_subnet_name    = var.subnet_name_1
  vnet_subnet_address = var.subnet_address_1
}

# 리소스 그룹 생성
module "rg" {
  source      = "./modules/rg"
  rg_name     = local.rg_name
  rg_location = local.rg_location
}

module "vnet" {
  source       = "./modules/vnet"
  rg_name      = local.rg_name
  rg_location  = local.rg_location
  vnet_name    = var.vnet_name
  vnet_address = var.vnet_address
  #  dns_servers  = var.dns_servers

  subnet_name_1    = local.vnet_subnet_name
  subnet_address_1 = local.vnet_subnet_address

  # subnet_name_2    = var.subnet_name_2
  # subnet_address_2 = var.subnet_address_2

}

# module "subnet" {
#   source               = "./modules/subnet"
#   rg_name              = module.rg.rg_name
#   rg_location          = module.rg.rg_location
#   virtual_network_name = module.vnet.vnet_name
#   name                 = var.subnet_name_1
#   address_prefixes     = var.subnet_address_1

# }

# module "vnet" {
#   source = "./vnet"

#   #count               = local.vnet.name
#   name                = local.vnet_name
#   resource_group_name = azurerm_resource_group.resource_group.name
#   location            = azurerm_resource_group.resource_group.location
#   address_space       = local.vnet_address_space

# }
