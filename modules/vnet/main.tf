resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address
  dns_servers         = var.dns_servers
  resource_group_name = var.rg_name
  location            = var.rg_location

  tags = {
    environment = "Test-bckim"
  }
}
