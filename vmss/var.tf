variable "frontend_vmss" {
  type = map(object({
    name                            = string
    location                        = string
    resource_group_name             = string
    sku                             = string
    instances                       = number
    disable_password_authentication = bool
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    os_disk = object({
      caching              = string
      storage_account_type = string
      disk_size_gb         = number
    })
    subnet_name         = string
  }))
}

variable "backend_vmss" {
  type = map(object({
    name                            = string
    location                        = string
    resource_group_name             = string
    sku                             = string
    instances                       = number
    disable_password_authentication = bool
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    os_disk = object({
      caching              = string
      storage_account_type = string
      disk_size_gb         = number
    })
    subnet_name         = string
  }))
  
}
variable "appgw_backend_pool_id" {
  type = string
}