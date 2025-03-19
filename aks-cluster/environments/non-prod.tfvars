env                     = "non-prod"
vnet_cidr               = "10.0.0.0/16"
frontend_subnet_cidr    = "10.0.1.0/24"
backend_subnet_cidr     = "10.0.2.0/24"
privatelink_subnet_cidr = "10.0.3.0/24"
min_count_frontend      = 1
max_count_frontend      = 2
min_count_backend       = 1
max_count_backend       = 2
node_count_frontend     = 1
node_count_backend      = 1

# Fixed Private IP for SQL Database (from the Backend Subnet)
sql_db_private_ip       = "10.0.2.5"

# The ID of the pre-existing SQL Server
sql_server_id           = "/subscriptions/{subscription-id}/resourceGroups/{resource-group-name}/providers/Microsoft.Sql/servers/{sql-server-name}"