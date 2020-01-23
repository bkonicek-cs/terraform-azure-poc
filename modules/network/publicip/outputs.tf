output "public_ip_id" {
  value       = azurerm_public_ip.ip.*.id
  description = "IDs of all Public IPs created by this module"
}
