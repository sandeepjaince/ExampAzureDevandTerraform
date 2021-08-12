provider "azurerm" {
    version = "2.5.0"
    features {}
  }

  resource "azurerm_resource_group" "terrform_test" {
    name = "tftest"
    location = "Australia East"
  }


  terraform {

        backend "azurerm" {
            resource_group_name = "tf_rg_blobstorage"
            storage_account_name = "tfsdockerstorage007"
            container_name = "tfstate"
            key = "terraform.tfstate"
          
        }
    
  }

  variable "imagebuild" {
      type         = string
      description = "Latest variable for image"
    
  }


  resource "azurerm_container_group" "terrafrom_container" {
    name                 = "terrformcontainer"
    location             = azurerm_resource_group.terrform_test.location
    resource_group_name  = azurerm_resource_group.terrform_test.name

    ip_address_type     =  "public"
    dns_name_label      =  "terraformapidns"
    os_type             = "Linux"

    container {
      
      name   = "weatherapi"
      image  = "dockersanny0078/weatherapi: ${var.imagebuild}"
      cpu    = "1"
      memory = "1"

      ports {
          port      = 80
          protocol  = "TCP"
      }

    }
  }