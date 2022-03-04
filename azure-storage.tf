# This azure storage.tf file configures 
#  - A baseline azure storage account resource 
#  - Basic tagging for the resource


resource "azurerm_storage_account" "st" {
  name                     = format("${random_string.random.result}sta%suksouth", var.ENV_ID) # Change name for own purposes.
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
