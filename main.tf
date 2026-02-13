terraform{
    required_providers{
        azurerm ={
            source = "hashicorp/azurerm"
            version = ">= 3.0"
        }
    }
}

provider "azurerm" {
    features {}

    subscription_id = "c943efc2-430f-4c7c-a428-293d6fb2c352"
}

resource "azurerm_resource_group" "rg-elizabeth"{
    name = "rg-elizabeth"
    location = "indonesiacentral"
}

resource "azurerm_virtual_network" "vnet" {
    name = "vnet-elizabeth"
    address_space = ["10.0.0.0/16"]
    location = azurerm_resource_group.rg-elizabeth.location
    resource_group_name = azurerm_resource_group.rg-elizabeth.name
}

resource "azurerm_subnet" "subnet"{
    name = "subnet-elizabeth"
    resource_group_name = azurerm_resource_group.rg-elizabeth.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "network_interface" {
    name = "nic-vm-elizabeth"
    location = azurerm_resource_group.rg-elizabeth.location
    resource_group_name = azurerm_resource_group.rg-elizabeth.name

    ip_configuration {
        name = "internal"
        subnet_id = azurerm_subnet.subnet.id
        private_ip_address_allocation = "Dynamic"
    }
}

variable "vm_admin_password" {
  description = "Admin password for Azure VM"
  type        = string
  sensitive   = true
}


resource "azurerm_linux_virtual_machine" "vm" {
    name = "vm-elizabeth-terraform"
    resource_group_name = azurerm_resource_group.rg-elizabeth.name
    location = azurerm_resource_group.rg-elizabeth.location
    size = "Standard_B2s"
    admin_username = "elizabeth"
    admin_password = var.vm_admin_password
    
    disable_password_authentication = false

    network_interface_ids = [
        azurerm_network_interface.network_interface.id
    ]

    tags = {
        environment = "staging"
    }
    


    os_disk {
        name = "vm-elizabeth-OsDisk"
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "ubuntu-24_04-lts"
        sku       = "server"
        version   = "latest"
    }

    
}

resource "azurerm_network_security_group" "nsg" {
    name                = "nsg-vm-elizabeth"
    location            = azurerm_resource_group.rg-elizabeth.location
    resource_group_name = azurerm_resource_group.rg-elizabeth.name

    security_rule {
        name                       = "allow-ssh"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}
