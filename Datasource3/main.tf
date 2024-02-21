
#creating this manually
data "azurerm_resource_group" "my_rg" {
  name = "datasource2"
}

data "azurerm_storage_account" "example" {
  name                = "datasourcetutor21022024"
  resource_group_name = data.azurerm_resource_group.my_rg.name
}

output "storage_account_tier" {
  value = data.azurerm_storage_account.example.account_tier
}

resource "azurerm_storage_container" "example" {
  name                  = "athir"
  storage_account_name  = data.azurerm_storage_account.example.name
  container_access_type = "private"
}