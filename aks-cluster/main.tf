module "network" {
  source               = "./modules/network"
  env                  = var.env
  vnet_name            = "aks-vnet-${var.env}"
  vnet_cidr            = var.vnet_cidr
  frontend_subnet_cidr = var.frontend_subnet_cidr
  backend_subnet_cidr  = var.backend_subnet_cidr
  privatelink_subnet_cidr = var.privatelink_subnet_cidr
}

module "security" {
  source              = "./modules/security"
  env                 = var.env
  resource_group      = module.network.resource_group
  frontend_subnet_id  = module.network.frontend_subnet_id
  backend_subnet_id   = module.network.backend_subnet_id
  private_dns_zone_name = var.private_dns_zone_name
  # Pass in the DB Private IP and SQL Server information
  db_private_ip       = var.db_private_ip        # This is the private IP of the database
  sql_server_id       = var.sql_server_id        # Pass the SQL server ID, this can be hardcoded or from an external data source
}

module "aks" {
  source             = "./modules/aks"
  env                = var.env
  resource_group     = module.network.resource_group
  vnet_id            = module.network.vnet_id
  frontend_subnet_id = module.network.frontend_subnet_id
  backend_subnet_id  = module.network.backend_subnet_id
  min_count_frontend = var.min_count_frontend
  max_count_frontend = var.max_count_frontend
  min_count_backend  = var.min_count_backend
  max_count_backend  = var.max_count_backend
  node_count_frontend = var.node_count_frontend
  node_count_backend  = var.node_count_backend
}
