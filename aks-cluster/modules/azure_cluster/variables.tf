variable "env" {
  description = "The environment (prod/non-prod)"
  type        = string
}

variable "resource_group" {
  description = "The resource group name"
  type        = string
}

variable "vnet_id" {
  description = "The virtual network ID"
  type        = string
}

variable "frontend_subnet_id" {
  description = "The frontend subnet ID"
  type        = string
}

variable "backend_subnet_id" {
  description = "The backend subnet ID"
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

variable "location" {
  description = "The Azure location"
  type        = string
}
