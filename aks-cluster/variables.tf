variable "env" {
  description = "The environment (prod/non-prod)"
  type        = string
}

variable "vnet_cidr" {
  description = "The CIDR block for the virtual network"
  type        = string
}

variable "frontend_subnet_cidr" {
  description = "The CIDR block for the frontend subnet"
  type        = string
}

variable "backend_subnet_cidr" {
  description = "The CIDR block for the backend subnet"
  type        = string
}

variable "privatelink_subnet_cidr" {
  description = "The CIDR block for the privatelink subnet"
  type        = string
}

variable "min_count_frontend" {
  description = "The minimum number of nodes in the frontend pool"
  type        = number
}

variable "max_count_frontend" {
  description = "The maximum number of nodes in the frontend pool"
  type        = number
}

variable "min_count_backend" {
  description = "The minimum number of nodes in the backend pool"
  type        = number
}

variable "max_count_backend" {
  description = "The maximum number of nodes in the backend pool"
  type        = number
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

# Fixed Private IP for SQL Database
variable "sql_db_private_ip" {
  description = "The fixed private IP address to assign to the SQL Database private endpoint"
  type        = string
}