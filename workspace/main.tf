resource "azurerm_resource_group" "workspacedev" {
  #comments to be placed like this started with # for single line
  #attribute_name = "value"
  name     = "workspace-dev"
  location = "West Europe"
}

resource "azurerm_storage_account" "st" {
  name                     = "tfworkspacedev120224test"
  resource_group_name      = azurerm_resource_group.workspacedev.name
  location                 = azurerm_resource_group.workspacedev.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "container1" {
  name                  = "demo-container"
  storage_account_name  = azurerm_storage_account.st.name
  container_access_type = "private"
}




# Workspaces: >>>> Dev <<<<
# Athir A --> Athir-tester (RG) --> (athirtester09022024)  --> DEV --> terraform.tfstate -->


# terraform workspace new Athirb
# terraform workspace select Athirb

# Athir B --> Athir-tester (RG) --> (athirtestersadfasf) -->>> (testerA) --> Athirb --> terraform.tfstate

# terraform workspace delete Athirb