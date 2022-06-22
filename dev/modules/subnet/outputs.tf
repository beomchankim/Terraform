output "subnet_name" {
  value = azurerm_subnet.subnet.name
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}

# output "id" {
#   #value = azurerm_subnet.subnet.id
#   value = {
#     for name, subnet in azurerm_subnet.subnet : subnet.name => subnet.id
#   }
#   #  value = { for k, subnet in azurerm_subnet.subnet : k => subnet.id }
# }
