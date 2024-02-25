variable "resource_group_names" {
  type    = list(string)
  default = ["MyRG1", "MyRG2", "MyRG3"]
}

locals {
  lowercase_rg_names = [for name in var.resource_group_names : lower(name)]
  totalrg = [for name in var.resource_group_names : length(name)]
}

resource "azurerm_resource_group" "example" {
  for_each = toset(local.lowercase_rg_names)
  name     = each.key
  location = "East US"
}