# variable "has_public_ip" {
#   type        = bool
#   description = "set to true if the VM(s) should have their own public IP addresses"
#   default     = false
# }

variable "public_ip_ids" {
  type        = list(string)
  description = "List of Public IP IDs to be assigned to NICs"
  default     = []
}

variable "vm_prefix" {
  type        = string
  description = "region and environment prefix for resources, e.g. 'USE2QACTCH'"
}

variable "vm_type" {
  type        = string
  description = "type of VM, e.g. 'WEB', 'MGT'"
}

variable "num_vms" {
  type        = number
  description = "number of VMs of the specified type to create"
  default     = 1
}

variable "location" {
  type        = string
  description = "location in which to create the resources"
  default     = "eastus2"
}

variable "resource_group_name" {
  type        = string
  description = "resource group in which to create the resources"
}

variable "vm_size" {
  type        = string
  description = "vm instance size"
}

variable "vm_sku" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "details for SKU of VM"
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

variable "admin_user" {
  type        = string
  description = "username for the default admin user"
  default     = "csadmin"
}

variable "admin_password" {
  type        = string
  description = "password for the default admin user"
}

# What's the best way to do this?
variable "data_disks" {
  type = list(object({
    name          = string
    storage_type  = string
    disk_size     = string
    create_option = string
  }))
  description = "optionally add data disks"
  default     = []
}

variable "os_disk_type" {
  type        = string
  description = "Mansged Disk Type for OS Disks"
  default     = "Standard_LRS"
}

variable "timezone" {
  type        = string
  description = "time zone for the VMs"
  default     = "Eastern Standard Time"
}

variable "pip_allocation" {
  type        = string
  description = "allocation method for Public IP - Static or Dynamic"
  default     = "Dynamic"
}

variable "private_ip_allocation" {
  type        = string
  description = "allocation method for Private IP - Static or Dynamic"
  default     = "Dynamic"
}

variable "subnet_name" {
  type        = string
  description = "name of the subnet for the VM(s)"
}

variable "vnet_name" {
  type        = string
  description = "Name of the VNET for the VM(s)"
}

variable "subnet_starting_address" {
  type        = number
  description = "The starting IP in the subnet for the first VM created"
}
