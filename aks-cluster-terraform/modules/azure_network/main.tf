resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group
  address_space       = [var.vnet_cidr]
}

resource "azurerm_subnet" "frontend" {
  name                 = "frontend-subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = var.resource_group
  address_prefixes     = [var.frontend_subnet_cidr]
}

resource "azurerm_subnet" "backend" {
  name                 = "backend-subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = var.resource_group
  address_prefixes     = [var.backend_subnet_cidr]
}

resource "azurerm_subnet" "privatelink" {
  name                 = "privatelink-subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = var.resource_group
  address_prefixes     = [var.privatelink_subnet_cidr]
}

# Private DNS Zone for SQL DB
resource "azurerm_private_dns_zone" "sql_db_dns_zone" {
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group
}

# Private Endpoint for Azure SQL DB with a Hardcoded Private IP
resource "azurerm_private_endpoint" "sql_db_private_endpoint" {
  name                = "sql-db-private-endpoint"
  location            = var.location
  resource_group_name = var.resource_group
  subnet_id           = azurerm_subnet.backend.id
  private_ip_address  = var.sql_db_private_ip  # Specify the fixed private IP for the DB

  private_service_connection {
    name                           = "sql-db-connection"
    private_connection_resource_id = var.sql_server_id
    is_manual_connection           = false
    subresource_names              = ["sqlServer"]
  }
}

# Private DNS Zone Link to VNet
resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                      = "sql-db-dns-vnet-link"
  resource_group_name       = var.resource_group
  private_dns_zone_name    = azurerm_private_dns_zone.sql_db_dns_zone.name
  virtual_network_id       = azurerm_virtual_network.vnet.id
  registration_enabled     = true
}