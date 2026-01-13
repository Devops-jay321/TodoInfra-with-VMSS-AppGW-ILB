resource "azurerm_linux_virtual_machine_scale_set" "frontend_vmss" {
  for_each            = var.frontend_vmss
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku
  instances           = each.value.instances
  admin_username      = data.azurerm_key_vault_secret.admin-login.value
  admin_password      = data.azurerm_key_vault_secret.vm-password.value
  disable_password_authentication = each.value.disable_password_authentication

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }

  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
    disk_size_gb         = each.value.os_disk.disk_size_gb
  }

  network_interface {
    name    = "frontend-nic"
    primary = true

    ip_configuration {
      name      = "frontend-ipconfig"
      primary  = true
      subnet_id = data.azurerm_subnet.subnets[each.key].id
      application_gateway_backend_address_pool_ids = [
      var.appgw_backend_pool_id
      ]
    }
  }

  custom_data = base64encode(<<-EOF
    #!/bin/bash
    apt update
    apt install -y nginx
    chmod -R 777 /var
    rm -rf /var/www/html/*
    systemctl enable nginx
    systemctl start nginx
  EOF
  )
}


resource "azurerm_linux_virtual_machine_scale_set" "backend_vmss" {
  for_each            = var.backend_vmss
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku
  instances           = each.value.instances
  admin_username      = data.azurerm_key_vault_secret.admin-login.value
  admin_password      = data.azurerm_key_vault_secret.vm-password.value
  disable_password_authentication = each.value.disable_password_authentication

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }

  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
    disk_size_gb         = each.value.os_disk.disk_size_gb
  }

  network_interface {
    name    = "backend-nic"
    primary = true

    ip_configuration {
      name      = "backend-ipconfig"
      primary  = true
      subnet_id = data.azurerm_subnet.subnets_back[each.key].id
    }
  }

  custom_data = base64encode(<<-EOF
    #!/bin/bash
    set -e
	
    apt-get update
    apt-get install -y wget apt-transport-https software-properties-common
	    
    wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    dpkg -i packages-microsoft-prod.deb
	    
    apt-get update
    apt-get install -y dotnet-sdk-8.0 aspnetcore-runtime-8.0 dotnet-runtime-8.0
       
	  EOF
  )
}
