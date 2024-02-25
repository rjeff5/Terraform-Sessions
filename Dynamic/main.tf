resource "azurerm_resource_group" "my_resource_group" {
  name     = "dynamic-block"
  location = "East US"
}

resource "azurerm_virtual_network" "my_vnet" {
  name                = "my-vnet"
  resource_group_name = azurerm_resource_group.my_resource_group.name
  location            = azurerm_resource_group.my_resource_group.location
  address_space       = ["10.0.0.0/16"]

  dynamic "subnet" {
    for_each = var.subnets
    content {
      name           = subnet.value.name
      address_prefix = subnet.value.address_prefix
    }
  }
}

#Many Operations   pushed to dynamic block which will process it  sends output

variable "subnets"{
    type = map(object({
        name = string
        address_prefix = string
    }))
    default = {
        subnet1 = {
            name           = "subnet1"
            address_prefix = "10.0.1.0/24"      
        }
        subnet2 = {
            name = "subnet2"
            address_prefix = "10.0.2.0/24"
        }
        external = {
            name = "external"
            address_prefix = "10.0.9.0/24"
        }
    }
}

# variable "subnets" {
#   type = map(object({
#     name           = string
#     address_prefix = string
#   }))
#   default = {
#     subnet1 = {
#       name           = "subnet1"
#       address_prefix = "10.0.1.0/24"
#     }
#     subnet2 = {
#       name           = "subnet2"
#       address_prefix = "10.0.2.0/24"
#     }
#   }
# }

variable "security_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    source_port_range          = string
    protocol                   = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = [
    {
      name                       = "rule-1"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      source_port_range          = "*"
      protocol                   = "*"
      destination_port_range     = "80"
      source_address_prefix      = "10.0.0.0/16"
      destination_address_prefix = "*"
    },
    {
      name                       = "rule-2"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "10.0.0.0/16"
      destination_address_prefix = "*"

    },
    # Add more rule instances with different parameter values
    {
      name                       = "rule-3"
      priority                   = 120
      direction                  = "Outbound"
      access                     = "Allow"
      source_port_range          = "*"
      protocol                   = "*"
      destination_port_range     = "8080"
      source_address_prefix      = "10.0.0.0/16"
      destination_address_prefix = "*"
    }
    # Add more instances as needed
  ]
}

resource "azurerm_network_security_group" "my_nsgs" {
  count = 2
  name  = "my-nsg-${count.index}"
  resource_group_name = azurerm_resource_group.my_resource_group.name
  location            = azurerm_resource_group.my_resource_group.location
  # other configuration...

  dynamic "security_rule" {
    for_each = var.security_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      protocol                   = security_rule.value.protocol
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}
