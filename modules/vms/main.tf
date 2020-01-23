data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

resource "azurerm_public_ip" "vm" {
  count = var.has_public_ip ? var.num_vms : 0

  name                = "${var.vm_prefix}${var.vm_type}${count.index + 1}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.pip_allocation
}

resource "azurerm_network_interface" "vm" {
  count = var.num_vms

  name                = "${var.vm_prefix}${var.vm_type}${count.index + 1}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = var.private_ip_allocation
    private_ip_address            = var.private_ip_allocation != "Dynamic" ? cidrhost(data.azurerm_subnet.subnet.address_prefix, var.subnet_starting_address + count.index) : null
    public_ip_address_id          = var.has_public_ip ? element(azurerm_public_ip.vm.*.id, count.index) : null
  }
}

# Can't get assigned public IPs if they're Dynamic until after they're created.
data "azurerm_public_ip" "ips" {
  for_each = { for ip in azurerm_public_ip.vm : ip.name => ip.name }

  name                = each.value
  resource_group_name = var.resource_group_name
}

resource "azurerm_availability_set" "vm" {
  count = var.num_vms > 1 ? 1 : 0

  name                = "${var.vm_prefix}${var.vm_type}-as"
  location            = var.location
  resource_group_name = var.resource_group_name
  managed             = true
}

resource "azurerm_virtual_machine" "vm" {
  count = var.num_vms

  name                = "${var.vm_prefix}${var.vm_type}${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name

  network_interface_ids = [element(azurerm_network_interface.vm.*.id, count.index)]
  vm_size               = var.vm_size

  storage_image_reference {
    publisher = var.vm_sku.publisher
    offer     = var.vm_sku.offer
    sku       = var.vm_sku.sku
    version   = var.vm_sku.version
  }
  storage_os_disk {
    name              = "${var.vm_prefix}${var.vm_type}${count.index}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.os_disk_type
  }

  os_profile {
    computer_name  = "${var.vm_prefix}${var.vm_type}${count.index + 1}"
    admin_username = var.admin_user
    admin_password = var.admin_password
  }

  os_profile_windows_config {
    provision_vm_agent = true
    timezone           = var.timezone
  }

  availability_set_id = var.num_vms > 1 ? azurerm_availability_set.vm.0.id : null

  dynamic "storage_data_disk" {
    for_each = var.data_disks

    content {
      name              = "${var.vm_prefix}${var.vm_type}${count.index + 1}-${storage_data_disk.value["name"]}"
      caching           = "ReadWrite"
      create_option     = storage_data_disk.value["create_option"]
      lun               = index(var.data_disks, storage_data_disk.value)
      disk_size_gb      = storage_data_disk.value["disk_size"]
      managed_disk_type = storage_data_disk.value["storage_type"]
    }
  }

  # can add CA/Worker Role/etc certs this way  https://www.terraform.io/docs/providers/azurerm/r/virtual_machine.html#certificate_url
  # dynamic blocks?
  # vault_certificates {

  # }
}
