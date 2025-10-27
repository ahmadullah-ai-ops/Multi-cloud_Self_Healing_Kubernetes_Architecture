# recommended: use terraform-aws-modules or eks module for production.
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = ">= 20.0"
# specify the cluster details
  cluster_name    = "${var.cluster_name_prefix}-eks"
  cluster_version = "1.28" # use latest
  subnets         = var.eks_subnets # set in variables or data
  vpc_id          = var.vpc_id

  node_groups = {
    default = {
      desired_capacity = 2 # declear the count you need
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t3.medium" # set from ec2 instance family
    }
  }
# give any tags to remember any metedata about
  tags = {
    Project = "multi-cloud-self-heal"
  }
}

output "eks_cluster_name" {
  value = module.eks.cluster_id
}
output "eks_kubeconfig" {
  value = module.eks.kubeconfig
  sensitive = true
}