resource "azurerm_virtual_network" "vnet-1" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
}

# resource "azurerm_subnet" "subnet-1" {
#     name = 
# }
