output "public_ips" {
  description = "List of public IPs (if any) for VMs"
  value       = { for ip in data.azurerm_public_ip.ips : ip.name => ip.ip_address }
}

output "private_ips" {
  description = "Private IPs of each VM created"
  value       = { for instance in azurerm_network_interface.vm : instance.name => instance.private_ip_address }
  # value = azurerm_network_interface.vm.*.private_ip_address
}

output "vm_ids" {
  description = "IDs of created VMs"
  value       = azurerm_virtual_machine.vm.*.id
}
   
