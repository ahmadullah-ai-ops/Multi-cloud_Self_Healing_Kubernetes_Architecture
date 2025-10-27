variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "azure_subscription_id" { type = string }
variable "azure_tenant_id"       { type = string }
variable "azure_client_id"       { type = string }
variable "azure_client_secret"   { type = string }

variable "cluster_name_prefix" {
  type    = string
  default = "mcsh"
}