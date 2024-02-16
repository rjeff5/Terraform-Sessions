output "resource_group_id" {
  value = azurerm_resource_group.example.id
}

output "network_security_group_id" {
  value = azurerm_network_security_group.example.id
}

output "virtual_network_id" {
  value = azurerm_virtual_network.example.id
}

output "resource_group_name" {
  value = azurerm_resource_group.example.name
}