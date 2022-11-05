# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "tp3" {
  name     = "tp3-resources"
  location = "France Central"
}


####################################################
################VPC01 : PRIVATE NETWORK#############
####################################################


resource "azurerm_virtual_network" "vpc1" {
  name                = "vpc1-network"
  location            = "France Central"
  resource_group_name = "tp3-resources"
  address_space       = ["192.168.20.0/24"]

}

resource "azurerm_subnet" "subnet" {
  name                 = "internal"
  resource_group_name  = "tp3-resources"
  virtual_network_name = azurerm_virtual_network.vpc1.name
  address_prefixes     = ["192.168.20.0/24"]
}

resource "azurerm_network_interface" "interface" {
  name                = "interface-nic"
  location            = "France Central"
  resource_group_name = "tp3-resources"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "inst-vpc1" {
  name                = "inst-vpc1-machine"
  resource_group_name = "tp3-resources"
  location            = "France Central"
  size                = "Standard_B1ls"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.interface.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}







resource "azurerm_linux_virtual_machine" "inst2-vpc1" {
  name                = "inst2-vpc1-machine"
  resource_group_name = "tp3-resources"
  location            = "France Central"
  size                = "Standard_B1ls"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.interface.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}