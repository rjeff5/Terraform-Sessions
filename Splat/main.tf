variable "my_list" {
  type = list(object({
    id = string
  }))
  default = [
    { id = "524587962" },
    { id = "225478965" },
    # Add more objects as needed
  ]
}

output "all_ids" {
  value = var.my_list[*].id
}

################################################################################################################################
variable "vm_count" {
  default = 4
}

resource "azurerm_resource_group" "example" {
  name     = "splat-operator"
  location = "East US"
}

resource "azurerm_virtual_network" "example" {
  name                = "my-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "my-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes    = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "example" {
  count = var.vm_count
  name                = "nic-${count.index}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "config"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "example" {
  count = var.vm_count
  name  = "vm-splatoperator${count.index}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  network_interface_ids = [azurerm_network_interface.example[count.index].id]

  vm_size                  = "Standard_DS1_v2"
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

    storage_os_disk {
    name              = "osdisk-${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  tags = {
    environment = "production"
    role        = "web"
  }
}

output "vm_names" {
  value = azurerm_virtual_machine.example[*].name
}

output "vm_ips" {
  value = azurerm_network_interface.example[*].ip_configuration[0].private_ip_address
}
