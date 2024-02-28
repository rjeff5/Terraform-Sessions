
resource "azurerm_resource_group" "example" {
  name     = "lifecycle"
  location = "East US"
  lifecycle {
    create_before_destroy = true
  }
}

#APP1
#Azure RG --> AzStorage --> ADF
#ADF xml files --> Storage blob --> Production (Govt project)
#ADF (xmlfiles)
#ADF Linked connection with new storage account

resource "azurerm_storage_account" "example" {
  name                     = "mystoragemejeff2802466"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  #Account tier changes Standard to Premium
  account_tier             = "Standard"
  account_replication_type = "LRS"
  lifecycle {
    create_before_destroy = true
    #Creation and then destroy
  }

}



# resource "azurerm_storage_account" "prevent_destroy" {
#   name                     = "mystoragemejeff222024"
#   resource_group_name      = azurerm_resource_group.example.name
#   location                 = azurerm_resource_group.example.location
#   account_tier             = "Standard"
#   account_replication_type = "GRS"
# lifecycle {
#     prevent_destroy = false
#   }

# }



resource "azurerm_app_service_plan" "example" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "example" {

  name                = "exampletutorjeffathir"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  app_settings = {
    "Application" = "Tutor"   
    "appid"       = "aasdfawe97-34jkwmlkdmflkmlksdf23e"
    # Add more key-value pairs as needed
  }
    lifecycle {
    ignore_changes = [
      app_settings,  // Ignore changes to app_settings attribute
    ]
  }
  depends_on = [azurerm_app_service_plan.example]
}


#   lifecycle {
#     ignore_changes = [
#       app_settings["WEBSITE_RUN_FROM_PACKAGE"],  # Ignore all app settings changes
#       # Add other app settings here...
#     ]
#   }
# }

