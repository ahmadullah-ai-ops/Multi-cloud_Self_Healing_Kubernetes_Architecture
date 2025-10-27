variable "cluster_name_prefix" {
  type    = string
  default = "mcsh" # multi-cloud-self-healing
}

variable "vpc_id" {
  type    = string
  description = "abc" #Optional:set existing VPC id. If empty, the EKS module can create a VPC when configured. so don't worry
  default = ""
}

variable "eks_subnets" {
  type    = list(string)
  description = "" # also optional: list of subnet ids for the EKS cluster (if using existing VPC)."
  default = []
}

variable "aws_region" {
  type    = string
  default = "us-east-1" # or set you own region
}