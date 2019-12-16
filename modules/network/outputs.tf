output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vnet_cidr" {
  value = azurerm_virtual_network.vnet.address_space
}

output "subnet_ips" {
  value = azurerm_subnet.private_subnets.*.address_prefix
}

