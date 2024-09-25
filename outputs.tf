output "resource_group_name" {
  description = "The name of the created resource group"
  value       = azurerm_resource_group.rg[*].name
}

output "resource_group_location" {
  description = "The location of the created resource group"
  value       = azurerm_resource_group.rg[*].location
}

output "resource_group_id" {
  description = "The ID of the created resource group"
  value       = azurerm_resource_group.rg[*].id
}
output "vnet_id" {
  description = "The ID of the created Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "The name of the created Virtual Network"
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_ids" {
  description = "The IDs of all created subnets in the Virtual Network"
  value       = [for subnet in azurerm_subnet.subnet : subnet.id]
}

output "subnet_names" {
  description = "The names of all created subnets in the Virtual Network"
  value       = [for subnet in azurerm_subnet.subnet : subnet.name]
}