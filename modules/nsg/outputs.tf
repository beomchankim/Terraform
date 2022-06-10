output "id" {
  value = azurerm_network_security_group.nsg.id
  #  value = { for k, subnet in azurerm_subnet.subnet : k => subnet.id }
}
