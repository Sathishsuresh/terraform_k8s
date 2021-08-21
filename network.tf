
resource "azurerm_resource_group" "k8rg" {
  name     = "${var.prefix}-k8s-resources"
  location = var.location
}

resource "azurerm_virtual_network" "example" {
  name                = "${var.prefix}-network"
  location            = azurerm_resource_group.k8rg.location
  resource_group_name = azurerm_resource_group.k8rg.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  virtual_network_name = azurerm_virtual_network.example.name
  resource_group_name  = azurerm_resource_group.k8rg.name
  address_prefixes     = ["10.1.0.0/22"]
}