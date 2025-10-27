output "eks_cluster_name" {
  value = module.eks.cluster_id
}

output "eks_kubeconfig" {
  value     = module.eks.kubeconfig
  sensitive = true
  description = "Raw kubeconfig for the EKS cluster (sensitive). Save to file for kubectl."
}