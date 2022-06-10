# locals {
#   subnet_id = lookup(module.subnet[var.subnet_name].azurerm_subnet.subnet, "id", "")
# }

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.rg_location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet_network_security_group_association" "nsg_associate" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
