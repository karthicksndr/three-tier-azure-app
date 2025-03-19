terraform {
  backend "azurerm" {
    resource_group_name   = "terraform-state-rg"       # Resource group for storing state
    storage_account_name  = "tfstatebackend"            # Storage account for state
    container_name        = "terraform-state"           # Blob container for state files
    key                   = "aks-${var.env}.tfstate"   # State file name per environment
  }
}