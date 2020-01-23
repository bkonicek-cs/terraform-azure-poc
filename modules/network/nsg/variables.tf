variable "location" {
  default = "eastus2"
}

variable "nsg_attributes" {
  default = {
    Name  = "name"
    Usage = "usage"
  }
}

variable "resource_group_name" {
  default = ""
}

variable "rules" {
  default = {
    "Web" = {
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    "SQL" = {
      priority                   = 101
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "1433"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

variable "environment" {
  default = "QA"
}
