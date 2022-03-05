# This azure main.tf file configures 
#  - The baseline terraform registery for Azure
#  - The backend terraform uses to store STATE
#  - Authenication with Azure via Service Principle 
#  - Basic Azure structures such as resource groups


# Configure terraform resource providers and remote backend state management

terraform {

  # Comment out to use local state files 

  #backend "remote" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }

}

terraform {
  backend "azurerm" {
    resource_group_name  = "terraformabackend-rg"
    storage_account_name = "terraformbackendsa2320"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}


# Get configuration parameters from current deployment process

data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

# Configure the Azure provider to use specific subscription + other parameters

provider "azurerm" {
  features {}

  skip_provider_registration = true

  tenant_id       = var.TENANT_ID
  subscription_id = var.SUBSCRIPTION_ID
  client_id       = var.CLIENT_ID
  client_secret   = var.CLIENT_SECRET
}


resource "random_string" "random" {
    length = 6
    special = false
    upper = false

}



# Create azure resource group

resource "azurerm_resource_group" "rg" {
  name     = format("${random_string.random.result}rg-sql-elastic-pool-%s-uksouth", var.ENV_ID) # Change name for own purposes. 
  location = "westeurope"

 tags = {
    Service        =  "SQL Elastic Pool",
    Last_Deployment = timestamp(),
    Environment     = var.ENV_ID
  }
}

