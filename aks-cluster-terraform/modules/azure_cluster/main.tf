resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.env}"
  location            = var.location
  resource_group_name = var.resource_group
  dns_prefix          = "aks-${var.env}"

  default_node_pool {
    name       = "system"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  node_pool {
    name                 = "frontend"
    vm_size              = "Standard_D2_v2"
    min_count            = var.min_count_frontend
    max_count            = var.max_count_frontend
    node_count           = var.min_count_frontend  # Initial node count
    availability_zones   = var.env == "prod" ? [1, 2, 3] : null
    enable_auto_scaling  = true
    max_pods             = 110
    type                 = "VirtualMachineScaleSets"
  }

  node_pool {
    name                 = "backend"
    vm_size              = "Standard_D2_v2"
    min_count            = var.min_count_backend
    max_count            = var.max_count_backend
    node_count           = var.min_count_backend  # Initial node count
    availability_zones   = var.env == "prod" ? [1, 2, 3] : null
    enable_auto_scaling  = true
    max_pods             = 110
    type                 = "VirtualMachineScaleSets"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = var.env
  }
}
