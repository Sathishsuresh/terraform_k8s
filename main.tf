terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.70.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "1.8.0"
    }
  }
}

provider "azurerm" {
  features {}
}

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

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "${var.prefix}-k8s"
  location            = azurerm_resource_group.k8rg.location
  resource_group_name = azurerm_resource_group.k8rg.name
  dns_prefix          = "${var.prefix}-k8s"

  default_node_pool {
    name                 = "system"
    node_count           = 1
    vm_size              = "Standard_DS2_v2"
    vnet_subnet_id       = azurerm_subnet.internal.id
  }

  network_profile {
    network_plugin = "kubenet"
    load_balancer_sku = "standard"
  }

  identity {
    type = "SystemAssigned"
  }

  addon_profile {
    aci_connector_linux {
      enabled = false
    }

    azure_policy {
      enabled = false
    }

    http_application_routing {
      enabled = false
    }

    oms_agent {
      enabled = false
    }
  }
    linux_profile {
        admin_username = "ubuntu"

        ssh_key {
            key_data = file(var.ssh_public_key)
        }
  }
}


