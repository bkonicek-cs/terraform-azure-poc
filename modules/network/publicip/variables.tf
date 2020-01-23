variable "location" {
  type        = string
  description = "location in which to create the resources"
  default     = "eastus2"
}

variable "resource_group_name" {
  type        = string
  description = "resource group in which to create the resources"
}

variable "pip_allocation" {
  type        = string
  description = "allocation method for Public IP - Static or Dynamic"
  default     = "Dynamic"
}

variable "pip_name" {
  type        = string
  description = "Name of the Public IP"
}

variable "num_ips" {
  type        = number
  description = "Number of Public IPs to create"
  default     = 1
}
