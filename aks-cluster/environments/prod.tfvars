env                     = "prod"
vnet_cidr               = "10.1.0.0/16"
frontend_subnet_cidr    = "10.1.1.0/24"
backend_subnet_cidr     = "10.1.2.0/24"
privatelink_subnet_cidr = "10.1.3.0/24"
min_count_frontend      = 3
max_count_frontend      = 6
min_count_backend       = 3
max_count_backend       = 6
node_count_frontend     = 3
node_count_backend      = 3

# Fixed Private IP for SQL Database (from the Backend Subnet)
sql_db_private_ip       = "10.1.2.5"

# The ID of the pre-existing SQL Server
sql_server_id           = "/subscriptions/{subscription-id}/resourceGroups/{resource-group-name}/providers/Microsoft.Sql/servers/{sql-server-name}"