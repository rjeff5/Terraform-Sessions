provider "azurerm" {
  features {}

  subscription_id = "23579c69-6625-45a8-a332-2b47fe5706dd"
  client_id       = "416b7295-7e6f-4698-a11f-f31adc351503"
  client_secret   = "4qi8Q~~60c2oD4jsierVkDCPJVPcfIc-zbHM~bkS"
  tenant_id       = "8118918f-d63f-4826-ab92-8073345198f7"

  //This is only for the demo and it is not a secure approach

}


resource "azurerm_resource_group" "local-exec" {
  name     = "local-exec"
  location = "East US"
}

resource "azurerm_storage_account" "localexec" {
  name                     = "localexecaccount07224"
  resource_group_name      = azurerm_resource_group.local-exec.name
  location                 = azurerm_resource_group.local-exec.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
  }
  provisioner "local-exec" {
    command = "echo Storage Account Name: ${azurerm_storage_account.localexec.name} > output.txt"
  }

}  
resource "terraform_data" "example2" {
  provisioner "local-exec" {
    command = "Get-Date > completed.txt"
    interpreter = ["PowerShell", "-Command"]
  }
  depends_on = ["azurerm_storage_account.localexec"]
}


resource "terraform_data" "example1" {
  provisioner "local-exec" {
    when = destroy
    command = "Get-Date > destroyed.txt"
    interpreter = ["PowerShell", "-Command"]
  }
  depends_on = ["azurerm_storage_account.localexec"]
}