variable "resource_group" {
  default = "1-85ff13-playground-sandbox"
}

variable "vnet_cidr" {
  default = [
    "10.10.0.0/16"
  ]
}

variable "num_private_subnets" {
  default = 1
}

variable "nsgs" {
  default = {
    Name  = "QA-Web"
    Usage = "Web"
  }
}

