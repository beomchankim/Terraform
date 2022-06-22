# Locals 
locals {
  rg_name     = "rg-terraform"
  rg_location = "Korea Central"
}
# Resource Group
module "rg" {
  for_each    = var.rg_object
  source      = "./modules/rg"
  rg_name     = each.key
  rg_location = each.value.rg_location
}
# Virtual Network 
module "vnet" {
  depends_on   = [module.rg]
  for_each     = var.vnet_object
  source       = "./modules/vnet"
  rg_name      = each.value.rg_name
  rg_location  = each.value.rg_location
  vnet_name    = each.key
  vnet_address = each.value.vnet_address
}
# Subnet
module "subnet" {
  depends_on     = [module.vnet]
  for_each       = var.subnet_object
  source         = "./modules/subnet"
  rg_name        = each.value.rg_name
  vnet_name      = each.value.vnet_name
  subnet_name    = each.key
  subnet_address = each.value.subnet_address
}
# Network Seucrity Group
module "nsg" {
  depends_on  = [module.rg, module.vnet, module.subnet]
  for_each    = var.nsg_object
  source      = "./modules/nsg"
  rg_name     = each.value.rg_name
  rg_location = each.value.rg_location
  nsg_name    = each.key
  subnet_id   = module.subnet[each.value.subnet_name].subnet_id
}
# Network Seucrity Group Rule
module "nsg_rule" {
  depends_on                 = [module.nsg]
  for_each                   = var.nsg_rule_object
  source                     = "./modules/nsgRule"
  rg_name                    = each.value.rg_name
  nsg_name                   = each.value.nsg_name
  nsg_rule_name              = each.value.nsg_rule_name
  priority                   = each.value.priority
  direction                  = each.value.direction
  access                     = each.value.access
  protocol                   = each.value.protocol
  source_port_range          = each.value.source_port_range
  destination_port_range     = each.value.destination_port_range
  source_address_prefix      = each.value.source_address_prefix
  destination_address_prefix = each.value.destination_address_prefix
}
# Public IP
module "pip" {
  depends_on        = [module.rg]
  for_each          = var.pip_object
  source            = "./modules/pip"
  rg_name           = each.value.rg_name
  rg_location       = each.value.rg_location
  pip_name          = each.key
  allocation_method = each.value.allocation_method
  pip_sku           = each.value.pip_sku
}
# Virtual Machine
module "vm" {
  depends_on                    = [module.subnet]
  for_each                      = var.vm_object
  source                        = "./modules/vm"
  rg_name                       = each.value.rg_name
  rg_location                   = each.value.rg_location
  nic_name                      = each.value.nic_name
  subnet_name                   = each.value.subnet_name
  subnet_id                     = module.subnet[each.value.subnet_name].subnet_id
  ip_name                       = each.value.ip_name
  private_ip_address_allocation = each.value.private_ip_address_allocation
  private_ip_address            = each.value.private_ip_address

  vm_name                 = each.key
  vm_size                 = each.value.vm_size
  storage_image_publisher = each.value.storage_image_publisher
  storage_image_offer     = each.value.storage_image_offer
  storage_image_sku       = each.value.storage_image_sku
  storage_image_version   = each.value.storage_image_version

  storage_os_disk_name          = each.value.storage_os_disk_name
  storage_os_disk_caching       = each.value.storage_os_disk_caching
  storage_os_disk_create_option = each.value.storage_os_disk_create_option
  storage_os_disk_type          = each.value.storage_os_disk_type
  storage_os_disk_size_gb       = each.value.storage_os_disk_size_gb

  os_profile_computer_name  = each.value.os_profile_computer_name
  os_profile_admin_username = each.value.os_profile_admin_username
  os_profile_admin_password = each.value.os_profile_admin_password
}
# Vnet to Vnet Peering
module "peering" {
  depends_on     = [module.vnet]
  for_each       = var.peering_object
  source         = "./modules/peering"
  rg_name        = each.value.rg_name
  peering_name   = each.key
  vnet_name      = each.value.vnet_name
  remote_vnet_id = module.vnet[each.value.remote_vnet_name].vnet_id
}
# Application Gateway
module "agw" {
  depends_on  = [module.subnet, module.pip]
  for_each    = var.agw_object
  source      = "./modules/agw"
  agw_name    = each.key
  rg_name     = each.value.rg_name
  rg_location = each.value.rg_location

  sku_name = each.value.sku_name
  sku_tier = each.value.sku_tier
  capacity = each.value.capacity

  agw_ip_name = each.value.agw_ip_name
  subnet_id   = module.subnet[each.value.subnet_name].subnet_id

  frontend_port_name = each.value.frontend_port_name
  frontend_port      = each.value.frontend_port

  frontend_ip_name = each.value.frontend_ip_name
  frontend_ip_id   = module.pip[each.value.frontend_ip_name].pip_id

  backend_address_pool_name = each.value.backend_address_pool_name

  http_setting_name       = each.value.http_setting_name
  cookie_based_affinity   = each.value.cookie_based_affinity
  backend_path            = each.value.backend_path
  backend_port            = each.value.backend_port
  backend_protocol        = each.value.backend_protocol
  backend_request_timeout = each.value.backend_request_timeout

  listener_name                  = each.value.listener_name
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
  listener_protocol              = each.value.listener_protocol
  request_routing_rule_name      = each.value.request_routing_rule_name
  rule_type                      = each.value.rule_type
}
