env                = "dev"
location           = "UK South"
zones              = ["1"]                        # ["1","2","3"]
system_node_count  = "1"
user_node_count    = "1"
vm_size            = "Standard_D2ads_v5"
address_space      = ["10.1.0.0/16"]
address_prefixes   = ["10.1.0.0/22"]
network_plugin     = "azure"
network_policy     = "calico"
tags               = {
  Terraform        = "true"
  Environment      = "test"
}