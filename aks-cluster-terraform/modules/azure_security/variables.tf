variable "env" {
  description = "The environment (prod/non-prod)"
  type        = string
}

variable "resource_group" {
  description = "The resource group name"
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

variable "location" {
  description = "The Azure location"
  type        = string
}
