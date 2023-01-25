provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-resources"
  location = var.location
  tags = {
    git_commit           = "20e75e3482e02f4f90f5db5edda8adb0b6f5e340"
    git_file             = "main.tf"
    git_last_modified_at = "2023-01-25 09:10:07"
    git_last_modified_by = "59680997+pan258@users.noreply.github.com"
    git_modifiers        = "59680997+pan258"
    git_org              = "pan258"
    git_repo             = "TFazurevmssh"
    yor_trace            = "fa7225a7-c6f0-4dc1-8514-c7fec46ae169"
  }
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags = {
    git_commit           = "20e75e3482e02f4f90f5db5edda8adb0b6f5e340"
    git_file             = "main.tf"
    git_last_modified_at = "2023-01-25 09:10:07"
    git_last_modified_by = "59680997+pan258@users.noreply.github.com"
    git_modifiers        = "59680997+pan258"
    git_org              = "pan258"
    git_repo             = "TFazurevmssh"
    yor_trace            = "76d76fed-0abb-47ee-a1ad-838dec6abbd5"
  }
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
  tags = {
    git_commit           = "20e75e3482e02f4f90f5db5edda8adb0b6f5e340"
    git_file             = "main.tf"
    git_last_modified_at = "2023-01-25 09:10:07"
    git_last_modified_by = "59680997+pan258@users.noreply.github.com"
    git_modifiers        = "59680997+pan258"
    git_org              = "pan258"
    git_repo             = "TFazurevmssh"
    yor_trace            = "d199954f-10d5-44b8-8e65-7674743c9330"
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                = "${var.prefix}-vm"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = "Standard_F2"
  admin_username      = "adminusername"
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  admin_ssh_key {
    username   = "adminusername"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
  tags = {
    git_commit           = "993578ddd45b36a3ea24ffd0ce2ac174ff18a33d"
    git_file             = "main.tf"
    git_last_modified_at = "2023-01-25 12:46:59"
    git_last_modified_by = "59680997+pan258@users.noreply.github.com"
    git_modifiers        = "59680997+pan258"
    git_org              = "pan258"
    git_repo             = "TFazurevmssh"
    yor_trace            = "1eb610a3-9d3b-4c86-8847-a1db8c2b7feb"
  }
}
