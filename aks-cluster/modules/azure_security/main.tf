# Network Security Group for Frontend
resource "azurerm_network_security_group" "frontend_nsg" {
  name                = "frontend-nsg"
  location            = var.location
  resource_group_name = var.resource_group

  # Allow HTTPS over internet to Frontend Subnet on 443
  security_rule {
    name                       = "allow-https-internet"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = var.frontend_subnet_cidr
  }

  # Allow HTTP and HTTPS from frontend subnet to backend subnet
  security_rule {
    name                       = "allow-http-https-front-to-back"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80,443"
    source_address_prefix      = var.frontend_subnet_cidr
    destination_address_prefix = var.backend_subnet_cidr
  }

  # Allow backend subnet to Azure SQL DB on 1433
  security_rule {
    name                       = "allow-sql-backend-to-db"
    priority                   = 120
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = var.backend_subnet_cidr
    destination_address_prefix = "AzureSql"
  }

  # Deny all other traffic
  security_rule {
    name                       = "deny-all-other"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Network Security Group for Backend
resource "azurerm_network_security_group" "backend_nsg" {
  name                = "backend-nsg"
  location            = var.location
  resource_group_name = var.resource_group

  # Allow traffic from frontend subnet to backend subnet
  security_rule {
    name                       = "allow-frontend-to-backend"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80,443"
    source_address_prefix      = var.frontend_subnet_cidr
    destination_address_prefix = var.backend_subnet_cidr
  }

  # Deny all other traffic
  security_rule {
    name                       = "deny-all-other"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Application Security Group for Frontend
resource "azurerm_application_security_group" "frontend_asg" {
  name                = "frontend-asg"
  location            = var.location
  resource_group_name = var.resource_group
}

# Application Security Group for Backend
resource "azurerm_application_security_group" "backend_asg" {
  name                = "backend-asg"
  location            = var.location
  resource_group_name = var.resource_group
}

# Application Security Group for DB
resource "azurerm_application_security_group" "db_asg" {
  name                = "db-asg"
  location            = var.location
  resource_group_name = var.resource_group
}

# NSG Rule: Allow traffic only from frontend ASG to backend ASG
resource "azurerm_network_security_rule" "allow-frontend-to-backend-asg" {
  name                       = "allow-frontend-to-backend-asg"
  priority                   = 100
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "80,443"
  source_address_prefix      = azurerm_application_security_group.frontend_asg.id
  destination_address_prefix = azurerm_application_security_group.backend_asg.id
  resource_group_name        = var.resource_group
  network_security_group_name = azurerm_network_security_group.backend_nsg.name
}

# NSG Rule: Allow traffic only from backend ASG to db ASG
resource "azurerm_network_security_rule" "allow-backend-to-db-asg" {
  name                       = "allow-backend-to-db-asg"
  priority                   = 100
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "1433"
  source_address_prefix      = azurerm_application_security_group.backend_asg.id
  destination_address_prefix = azurerm_application_security_group.db_asg.id
  resource_group_name        = var.resource_group
  network_security_group_name = azurerm_network_security_group.backend_nsg.name
}
