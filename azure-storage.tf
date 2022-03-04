# This azure storage.tf file configures 
#  - A baseline azure storage account resource 
#  - Basic tagging for the resource
# - hello

resource "azurerm_storage_account" "st" {
  name                     = format("sta%suksouth", var.ENV_ID) # Change name for own purposes.
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "GRS"
  min_tls_version          = "TLS1_1"

 tags = {
    Service        =  "SQL Elastic Pool",
    Last_Deployment = timestamp(),
    Environment     = var.ENV_ID
  }
}

resource "azurerm_storage_account" "st1" {
  name                     = format("sta%suksoutha", var.ENV_ID) # Change name for own purposes.
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "GRS"
  min_tls_version          = "TLS1_2"

 tags = {
    Service        =  "SQL Elastic Pool",
    Last_Deployment = timestamp(),
    Environment     = var.ENV_ID
  }
}
