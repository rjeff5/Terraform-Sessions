resource "azurerm_resource_group" "rg" {
  name     = "workflow"
  location = var.location
}

resource "azurerm_application_insights" "appinsights" {
  name                = "tf-test-appinsights"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}

output "instrumentation_key" {
  value     = azurerm_application_insights.appinsights.instrumentation_key
  sensitive = true
}


resource "azurerm_storage_account" "st" {
  name                     = "todaydemo08024"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

output "app_id" {
  value = azurerm_application_insights.appinsights.app_id
}

resource "azurerm_storage_account" "st2" {
  name                     = "todaydemo14022024"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}