
#creating this manually
data "azurerm_resource_group" "my_rg" {
  name = "datasource2"
}

resource "azurerm_storage_account" "my_st" {
  name                     = "datasourcetutor21022025"
  resource_group_name      = data.azurerm_resource_group.my_rg.name
  location                 = data.azurerm_resource_group.my_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = data.azurerm_resource_group.my_rg.tags
}