# Network-related variables
variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "vnet_cidr" {
  description = "CIDR block for the Virtual Network"
  type        = string
}

variable "frontend_subnet_cidr" {
  description = "CIDR block for the Frontend Subnet"
  type        = string
}

variable "backend_subnet_cidr" {
  description = "CIDR block for the Backend Subnet"
  type        = string
}

variable "privatelink_subnet_cidr" {
  description = "CIDR block for the Private Link Subnet"
  type        = string
}

# Location variable for resources
variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

# Resource group name
variable "resource_group" {
  description = "The resource group name"
  type        = string
}

# Environment type (prod or non-prod)
variable "env" {
  description = "The environment for this deployment (prod or non-prod)"
  type        = string
}

# Private DNS zone for SQL DB
variable "private_dns_zone_name" {
  description = "The name of the Private DNS Zone for SQL DB"
  default     = "privatelink.database.windows.net"
}

# The ID of the pre-existing SQL Server
variable "sql_server_id" {
  description = "The ID of the existing SQL Server"
  type        = string
}

# Subnet IDs for Private Endpoint
variable "privatelink_subnet_id" {
  description = "ID of the subnet where the Private Endpoint will be deployed"
  type        = string
}

# Private IP for SQL Database
variable "sql_db_private_ip" {
  description = "The fixed private IP address to assign to the SQL Database private endpoint"
  type        = string
}
