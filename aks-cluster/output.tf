output "vnet_id" {
  value = module.network.vnet_id
}

output "frontend_subnet_id" {
  value = module.network.frontend_subnet_id
}

output "backend_subnet_id" {
  value = module.network.backend_subnet_id
}

output "aks_cluster_name" {
  value = module.aks.aks_cluster_name
}