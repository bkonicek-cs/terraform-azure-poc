resource "azurerm_public_ip" "ip" {
  count = var.num_ips

  name                = "${var.pip_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.pip_allocation
}
