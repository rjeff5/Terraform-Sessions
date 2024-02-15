resource "azurerm_resource_group" "rg" {
  #comments to be placed like this started with # for single line
  #attribute_name = "value"
  name     = "tester"
  location = "West Europe"
  provider = azurerm.dev
}

resource "azurerm_storage_account" "st" {
  name                     = "tfdemo05022024"
  provider = azurerm.dev
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "container1" {
  name                  = "demo-container"
  provider = azurerm.dev
  storage_account_name  = azurerm_storage_account.st.name
  container_access_type = "private"
}