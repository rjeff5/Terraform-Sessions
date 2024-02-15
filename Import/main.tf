resource "azurerm_app_service_plan" "appserviceplan" {
  name                = "ASP-tester-9fed"
  resource_group_name = "tester"
  location            = "East US"
  kind                = "Linux"
  reserved            = true

  sku {
    tier     = "Free"
    size     = "F1"
    capacity = 1
  }


  tags = {
    created   = "terraform"
    purpose   = "import"
    createdby = "jeff"
  }
}


resource "azurerm_app_service" "webapp" {
  name                = var.webapp
  resource_group_name = "tester"
  location            = var.location
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id


  tags = {
    created   = "terraform"
    purpose   = "import"
    createdby = "jeff"
  }
}
resource "azurerm_storage_account" "example" {
  name                     = "azurejefftester"
  resource_group_name      = "tester"
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}


resource "azurerm_storage_account" "example2" {
    name = "terraformimport0902204"
    resource_group_name      = "tester"
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}