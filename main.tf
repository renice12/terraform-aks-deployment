#code de deployement
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "rg" {
 name = var.resource_group
 location = var.location
}

resource "azurerm_virtual_network" "vnet" {
 name = "myVirtualNetwork"
 location = azurerm_resource_group.rg.location
 resource_group_name = azurerm_resource_group.rg.name
 address_space = ["10.1.0.0/16"]

subnet {
 name = "subnet1"
 address_prefix = "10.1.1.0/24"
 }
}

resource "random_password" "winnode" {
 length = 16
}

resource "azurerm_kubernetes_cluster" "aks" {
 name = "cergiaks"
 location = azurerm_resource_group.rg.location
 resource_group_name = azurerm_resource_group.rg.name
 dns_prefix = "aks1"

default_node_pool {
 name = "linux"
 node_count = var.node_count_linux
 vm_size = "Standard_D2_v2"
 }

windows_profile {
 admin_username = "cergiazadmin"
 admin_password = random_password.winnode.result
 }
 
network_profile {
 network_plugin = "azure"
 }

identity {
 type = "SystemAssigned"
 }
}

resource "azurerm_kubernetes_cluster_node_pool" "win" {
 name = "winpl"
 kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
 vm_size = "Standard_DS2_v2"
 node_count = var.node_count_windows
 os_type = "Windows"
}

output "kube_config" {
 value = azurerm_kubernetes_cluster.aks.kube_config_raw
 sensitive = true
}
/*
#configuration de terraform state storage
terraform {
  backend "azurerm" {
    resource_group_name   = "terraform-storage-rg"
    storage_account_name  = "terraformstatexlrwdrzs"
    container_name        = "prodtfstate"
    key                   = "terraform-custom-vnet.tfstate"
  }
}
*/