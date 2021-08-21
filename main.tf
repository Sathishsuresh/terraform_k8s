terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.70.0"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.11.3"
    }
  }
}

provider "azurerm" {
  features {}
}





