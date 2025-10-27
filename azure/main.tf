resource "azurerm_resource_group" "rg" {
  name     = "${var.cluster_name_prefix}-rg"
  location = var.azure_location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.cluster_name_prefix}-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.cluster_name_prefix}-aks"

  default_node_pool {
    name       = "agentpool"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Project = "multi-cloud-self-heal"  # set the tags to recognise
  }
}

output "aks_kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}