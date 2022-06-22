resource "azurerm_network_interface" "nic" {
  resource_group_name = var.rg_name
  location            = var.rg_location

  name = var.nic_name

  ip_configuration {
    name                          = var.ip_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    private_ip_address            = var.private_ip_address
  }
}

resource "azurerm_virtual_machine" "vm" {
  location            = var.rg_location
  resource_group_name = var.rg_name

  name = var.vm_name

  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = var.vm_size

  storage_image_reference {
    publisher = var.storage_image_publisher
    offer     = var.storage_image_offer
    sku       = var.storage_image_sku
    version   = var.storage_image_version
  }
  storage_os_disk {
    name              = var.storage_os_disk_name
    caching           = var.storage_os_disk_caching
    create_option     = var.storage_os_disk_create_option
    managed_disk_type = var.storage_os_disk_type
    disk_size_gb      = var.storage_os_disk_size_gb
  }
  os_profile {
    computer_name  = var.os_profile_computer_name
    admin_username = var.os_profile_admin_username
    admin_password = var.os_profile_admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "Test"
  }
}
