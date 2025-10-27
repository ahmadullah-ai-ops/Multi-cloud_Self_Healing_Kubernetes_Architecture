# Root Terraform Orchestrator

terraform {
  required_version = ">= 1.5.0"
}

variable "cloud_provider" {
  description = "Choose the cloud provider (aws or azure)"
  type        = string
  default     = "aws"
}

module "selected_cloud" {
  source = var.cloud_provider == "aws" ? "./aws" : "./azure"
}
