provider "azurerm" {
  version = "=1.39.0"

}

data "azurerm_resource_group" "default" {
  name = var.resource_group
}

module "network" {
  source = "./modules/network"

  resource_group      = data.azurerm_resource_group.default.name
  vnet_cidr           = var.vnet_cidr
  num_private_subnets = var.num_private_subnets
}

module "nsg" {
  source = "./modules/nsg"

  resource_group_name = data.azurerm_resource_group.default.name
  nsg_attributes      = var.nsgs
}
