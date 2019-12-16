variable "resource_group" {
  default = "1-85ff13-playground-sandbox"
}

variable "vnet_cidr" {
  default = [
    "10.10.0.0/16"
  ]
}

variable "num_private_subnets" {
  default = 2
}

variable "vnet_name" {
  default = "QA"
}

variable "environment" {
  default = "QA"
}

# variable "num_public_subnets" {
#   default = 2
# }
variable "location" {
  default = "eastus2"
}
