output "frontend_nsg_id" {
  value = azurerm_network_security_group.frontend_nsg.id
}

output "backend_nsg_id" {
  value = azurerm_network_security_group.backend_nsg.id
}

output "frontend_asg_id" {
  value = azurerm_application_security_group.frontend_asg.id
}

output "backend_asg_id" {
  value = azurerm_application_security_group.backend_asg.id
}
