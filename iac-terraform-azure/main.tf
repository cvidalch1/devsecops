terraform {
  required_version = ">=1.0"

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
  skip_provider_registration = "true"
  features {}
}



module "resource_group" {
    source                              =  "./modules/resource_group"
    location                            =  "eastus"
    name                                =  "rg-devsecops"

}

module "network" {
    source                              =  "./modules/network"
    depends_on                          =  [module.resource_group]
    resource_group_name                 =  module.resource_group.name
    name                                =  "vn-devsecops"
    name_nsg                            =  "nsg-devsecops"
    address_space                       =  "10.0.0.0/16"
    subnet_prefixes                     =  ["10.0.1.0/24"]
    subnet_names                        =  ["subnet-aks"]
}



module "aks" {
    source                              =  "./modules/aks"
    depends_on                          =  [module.network]
    resource_group_name                 =  module.resource_group.name
    name                                =  "aks-devsecops"
    dns_prefix                          =  "devsecops"
    kubernetes_version                  =  "1.24.9"
    agent_vm_count                      =  "2"
    agent_vm_size                       =  "Standard_D2_v2"
    vnet_subnet_id                      =  module.network.subnets[0]
    network_plugin                      =  "azure"
    network_policy                      =  "azure"
    service_cidr                        =  "10.10.0.0/16"
    dns_ip                              =  "10.10.0.10"
    docker_cidr                         =  "172.17.0.1/16"
}



