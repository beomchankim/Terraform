resource "azurerm_virtual_network" "vnet" {
  resource_group_name = var.rg_name
  location            = var.rg_location
  name                = var.vnet_name
  address_space       = var.vnet_address

  tags = {
    environment = "Test-bckim"
  }
}

# data "azurerm_virtual_network" "vnet" {
#   name                = azurerm_virtual_network.vnet.name
#   resource_group_name = azurerm_virtual_network.vnet.resource_group_name
# }
