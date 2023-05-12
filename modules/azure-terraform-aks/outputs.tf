output "resource_group_name" {
  value = azurerm_resource_group.this.name
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.this.name
}

output "kubeconfig" {
  value = "az aks get-credentials --admin --name ${replace(var.location, "/\\s+/", "")}-${var.env}-k8s --resource-group  ${replace(var.location, "/\\s+/", "")}-${var.env}-k8s-rg"
}