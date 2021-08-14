data "azurerm_kubernetes_cluster" "k8s" {
  name                = "${var.prefix}-k8s"
  resource_group_name = azurerm_resource_group.k8rg.name
  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
}

provider "kubectl" {
  load_config_file       = false
  host                   = azurerm_kubernetes_cluster.k8s.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.k8s.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate)

}

data "kubectl_path_documents" "manifests" {
    pattern = "${path.module}/manifests/*.yaml"
}

resource "kubectl_manifest" "test" {
    count     = length(data.kubectl_path_documents.manifests.documents)
    yaml_body = element(data.kubectl_path_documents.manifests.documents, count.index)
}

