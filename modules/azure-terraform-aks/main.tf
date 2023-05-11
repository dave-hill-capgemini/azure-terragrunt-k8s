provider "azurerm" {
  features {}
}

###########################################################################
# Create resource group
###########################################################################
resource "azurerm_resource_group" "this" {
  name                  = "${replace(var.location, "/\\s+/", "")}-${var.env}-k8s-rg"
  location              = var.location
  tags                  = var.tags
}

###########################################################################
# Create virtual network
###########################################################################
resource "azurerm_virtual_network" "this" {
  name                  = "${replace(var.location, "/\\s+/", "")}-${var.env}-k8s-vnet"
  location              = var.location
  resource_group_name   = azurerm_resource_group.this.name
  address_space         = var.address_space
  tags                  = var.tags
}

###########################################################################
# Create subnet
###########################################################################
resource "azurerm_subnet" "this" {
  name                  = "internal"
  virtual_network_name  = azurerm_virtual_network.this.name
  resource_group_name   = azurerm_resource_group.this.name
  address_prefixes      = var.address_prefixes
}

###########################################################################
# Create AKS cluster and system nodes
###########################################################################
resource "azurerm_kubernetes_cluster" "this" {
  name                  = "${replace(var.location, "/\\s+/", "")}-${var.env}-k8s"
  location              = var.location
  resource_group_name   = azurerm_resource_group.this.name
  dns_prefix            = "${replace(var.location, "/\\s+/", "")}-${var.env}-k8s"

  default_node_pool {
    name                = var.env
    node_count          = var.system_node_count
    vm_size             = var.vm_size
    os_disk_size_gb     = 30
    availability_zones  = var.zones
    vnet_subnet_id      = azurerm_subnet.this.id
  }

  network_profile {
    network_plugin      = var.network_plugin
    network_policy      = var.network_policy
  }

  identity   {
    type                = "SystemAssigned"
  }

  role_based_access_control {
    enabled             = true
  }

  tags                  = var.tags
}

###########################################################################
# Create user nodes
###########################################################################
resource "azurerm_kubernetes_cluster_node_pool" "this" {
  name                  = "user"
  availability_zones    = var.zones
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size               = var.vm_size
  node_count            = var.user_node_count
  vnet_subnet_id        = azurerm_subnet.this.id
  tags                  = var.tags
}