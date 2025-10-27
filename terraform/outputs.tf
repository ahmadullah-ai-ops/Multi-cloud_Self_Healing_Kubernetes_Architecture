output "aws_eks_kubeconfig" {
  value = aws_eks_cluster.demo.endpoint
  description = "EKS cluster endpoint (example). Use eks module outputs for full kubeconfig."
  sensitive = false
}