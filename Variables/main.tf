resource "azurerm_resource_group" "example" {
  name     = var.rgname
  #env = fromenvvars
  location = "West Europe"
}

resource "azurerm_network_security_group" "example" {
  name                = "example-security-group"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  #resourcegroup is the implicit dependency
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
#   address_space       = ["10.0.0.0/16"]
  address_space = var.address_space
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.example.id
    #Security group creation is the implicit dependency
  }
  subnet {
    name           = "subnet3"
    address_prefix = "10.0.6.0/24"
    security_group = azurerm_network_security_group.example.id
    #Security group creation is the implicit dependency
  }














  

  tags = {
    environment = "Production"
  }
}

variable "rgname"{
    default = "asdv"
}

#How precedence happens??
# First approach checks in env