provider "azurerm" {
  features {}
}


module "my_resource_group" {
  source = "git::https://github.com/rjeff5/terraform-modules.git//ResourceGroup"
  resource_group_name = "storage-foreach"
  location            = "East US"
}