# Define your resource group
resource "azurerm_resource_group" "count" {
  name     = "count"
  location = "East US"
}


variable "subnet_names" {
  description = "List of subnet names"
  type        = list(string)
  # default = "subnet-a" --> string
  # default = ["subnet-a", "subnet-b"] --> list(string)
  default     = ["inbound", "outbound", "external"]
}

resource "azurerm_virtual_network" "vnet" {
  name                = "my-vnet"
  resource_group_name = azurerm_resource_group.count.name
  location            = azurerm_resource_group.count.location
  address_space       = ["10.0.0.0/16"]

}

resource "azurerm_subnet" "subnet" {
  count               = length(var.subnet_names)
  #length(var.subnet_names) == Total length = 3
  #count = 3
  name                = var.subnet_names[count.index]
  #If I need to call subnet-b --> var.subnet_names[1]
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name = azurerm_resource_group.count.name
  address_prefixes    = ["10.0.${count.index}.0/24"]
  depends_on = [azurerm_virtual_network.vnet]
}