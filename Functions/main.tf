# Define your resource group
resource "azurerm_resource_group" "function" {
  name     = "functions"
  location = "East US"
}

# # Use the lower function to ensure lowercase storage account name
# resource "azurerm_storage_account" "example" {
#   name                     = lower(local.truncateme) # Convert to lowercase
#   #lower(ATHIrJeff22)
#   #lower(athirjeff22)
#   location                 = "East US"
#   resource_group_name      = azurerm_resource_group.function.name
#   account_tier             = "Standard"
#   account_replication_type = "GRS"
#   depends_on = [azurerm_resource_group.function]
#   # # Set a minimum length for the storage account name
#   # tags = {
#   #   name_length = max(length(var.storagename), 3) # Minimum length of 8 characters
#   # }
# }

# # max to 13char (communicate only 13char) --> Official doc (24char)
# # Truncating the name to 13char
# #athirjeffst


# # Define your variable
# variable "storagename" {
#   description = "Name for the storage account"
# }

# # Define a local variable to truncate the storage account name
# locals {
#   truncateme = substr(var.storagename, 0, 11) # truncate to 11 characters
#   #Backend
#   #truncateme = substr("ATHIrJeff22022024")
#   #truncateme = (truncatedvalue == ATHIrJeff22)
#   #line --> move to line9
#   #substr(exract a substring) starts with 0 and truncate the 11th index
#   # substr(var.storagename, 0, 11) O is the starting position to extract the element and 11 is the number of characters to extract
# }


# # # In this modified code:

# # # We define a local variable called truncated_storagename using the substr function to truncate the storage account name to a maximum of 21 characters.
# # # The lower(local.truncated_storagename) expression ensures that the storage account name is converted to lowercase.
# # # You can adjust the maximum length (21 characters) as needed.



# #######################################################################################################################
# #Format function & Join

variable "resource_prefix" {
  type    = string
  default = "webserver"
}

variable "environment" {
  type    = string
  default = "prod"
}

resource "azurerm_storage_account" "format" {
  name                     = format("%s%s", var.resource_prefix, var.environment)
  #%s is the placehodlers for the values
  #webserverprod
  resource_group_name      = "functions"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    description = join(", ", var.tags)
  }
  depends_on = [azurerm_resource_group.function]
}

variable "tags" {
  type    = list(string)
  default = ["dev", "myapp"]
}

locals {
  fruits = ["apple", "banana", "cherry"]
}

output "concatenated_fruits" {
  value = join(", ", local.fruits)
  #join(separator, list)
  #(", ") --> Seperator
  #local.fruits --> list
}


# # #########################################################################################################################
# # #Resource Naming conventions with join

# variable "env" {
#   type    = list(string)
#   default = ["friendship", "love", "marriage"]
# }

# resource "azurerm_storage_account" "naming" {
#   for_each                 = toset(var.env)
#   name                     = join("", ["store17022024", each.value])
#   resource_group_name      = "functions"
#   location                 = "East US"
#   account_tier             = "Standard"
#   account_replication_type = "LRS"

#   depends_on = [azurerm_resource_group.function]
# }

# # ##################################################################################################################################
# # #Concat list
# # #Locals block
# # #Allows to define local values

variable "networks" {
  type    = list(string)
  default = ["frontend", "backend"]
}

variable "zones" {
  type    = list(string)
  default = ["zone1", "zone2"]
}

locals {
  combined_list = concat(var.networks, var.zones)
  #combined list = [frontend, backend, zone1, zone2]
}



resource "azurerm_virtual_network" "example" {
  count               = length(local.combined_list) # 4
  name                = "vnet-${local.combined_list[count.index]}"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = "functions"
  depends_on = [azurerm_resource_group.function]
}

# # ######################################################################################################
# # #merge

# variable "tags1" {
#   type    = map(string)
#   default = { environment = "abcd", owner = "John" }
# }

# variable "tags2" {
#   type    = map(string)
#   default = { project = "example", environment = "efghi" }
# }

# locals {
#   merged_tags = merge(var.tags1, var.tags2)
# }

# resource "azurerm_storage_account" "merge" {
#   name                     = "storage19022024merge"
#   resource_group_name      = "functions"
#   location                 = "East US"
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#   tags = local.merged_tags
#   depends_on = [azurerm_resource_group.function]
# }


# #######################################################################################################################################
# #JOin
# # Define a variable for a unique identifier
# locals {
#   project_name   = "myproject"
#   environment    = "dev"
#   resource_type  = "storage"
  
#   storage_account_name = join("-", [local.project_name, local.environment, local.resource_type])
# }

# output "constructed_name" {
#   value = local.storage_account_name
# }
