#terraform {
#  backend "azurerm" {
#    resource_group_name  = "prod_resource_group"
#    storage_account_name = "prod_resource_group_storage"
#    container_name       = "tfstate"
#    key                  = "terraform.tfstate"
#  }
#}