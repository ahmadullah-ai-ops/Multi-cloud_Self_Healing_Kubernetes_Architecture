variable "cluster_name_prefix" {
  type    = string
  default = "mcsh"
}

variable "azure_location" {
  type    = string
  default = "eastus"
}

variable "azure_subscription_id" { type = string }
variable "azure_tenant_id"       { type = string }
variable "azure_client_id"       { type = string }
variable "azure_client_secret"   { type = string }