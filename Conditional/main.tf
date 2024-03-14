

variable "create_storage_account" {
  default = true
}

resource "azurerm_resource_group" "example" {
  name     = "my-rg"
  location = "East US"
}

variable "environment" {
  default = "prod"
}

resource "azurerm_storage_account" "example" {
  count                   = var.create_storage_account ? 1 : 0
  name                    = "jeffathir14032024test"
  resource_group_name     = azurerm_resource_group.example.name
  location                = azurerm_resource_group.example.location
  account_tier            = "Standard"
  account_replication_type = var.environment == "dev" ? "LRS" : "GRS"
}
