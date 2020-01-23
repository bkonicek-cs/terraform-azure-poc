resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_cidr
  location            = var.location
  resource_group_name = var.resource_group
  tags = {
    Environment = var.environment
  }
}

resource "azurerm_subnet" "private_subnets" {
  count = var.num_private_subnets

  address_prefix       = cidrsubnet(azurerm_virtual_network.vnet.address_space[0], 8, count.index)
  virtual_network_name = azurerm_virtual_network.vnet.name
  name                 = "subnet-${count.index + 1}"
  resource_group_name  = var.resource_group
}
