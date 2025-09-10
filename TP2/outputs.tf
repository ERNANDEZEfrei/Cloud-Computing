output "vm_public_ip" {
  description = "Public IP address of the VM"
  value       = azurerm_public_ip.main.ip_address
}

output "vm_dns_name" {
  description = "DNS name associated with the VM"
  value       = azurerm_public_ip.main.fqdn
}