terraform {
  backend "azurerm" {
    resource_group_name  = "terrafor-mmodules"
    storage_account_name = "terraformmodules"
    container_name       = "terraformtf"
    key                  = "count"
    access_key           = "Yh8YUE71S4sSrZcdXIhbMx0epFbuyh01fKz1bEBXaHR9xbjdvBJkgi4MqGiMjHLOL4gcRg2B5T6J+ASt0Vxz3g==" # Replace with your storage account access key
    # sas_token             = "your-sas-token"   # Alternatively, use SAS token for authentication
    # use_shared_access_signature = true        # Uncomment if using SAS token
    # encrypt                = true               # Enable encryption at rest
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.74.0"
    }
  }
}

provider "azurerm" {
  features {}
}
