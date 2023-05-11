variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "env" {
  description = "A environment prefix used for naming. ie test"
}

variable "location" {
  description = "The Azure location in which all resources in this example should be provisioned"
}

variable "zones" {
  description = "A list of availability zones"
}

variable "vm_size" {
  description = "VM SKU for nodes"  
}

variable "system_node_count" {
  description = "The number of system nodes in default node pool block"
}

variable "user_node_count" {
  description = "The number of system nodes in cluster node pool resource"
}

variable "address_space" {
  description = "The VNET CIDR Block"
}

variable "address_prefixes" {
  description = "Subnet CIDR block"  
}

variable "network_plugin" {
  description = "CNI plugin - kubenet (default), azure or azure overlay" 
}

variable "network_policy" {
  description = "NCP plugin - ie. calico"
}