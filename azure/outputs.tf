output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "aks_kube_config_raw" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
  description = "Raw kubeconfig for the AKS cluster (sensitive). Save to file for kubectl."
}