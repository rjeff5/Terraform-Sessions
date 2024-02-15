terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  alias                 = "dev"
  features              {}
  skip_provider_registration = true
#   subscription_id       = "your_primary_subscription_id"
#   client_id             = "your_primary_client_id"
#   client_secret         = "your_primary_client_secret"
#   tenant_id             = "your_primary_tenant_id"
}

provider "azurerm" {
  alias                 = "uat"
  features              {}
  skip_provider_registration = true
#   subscription_id       = "your_secondary_subscription_id"
#   client_id             = "your_secondary_client_id"
#   client_secret         = "your_secondary_client_secret"
#   tenant_id             = "your_secondary_tenant_id"
}
