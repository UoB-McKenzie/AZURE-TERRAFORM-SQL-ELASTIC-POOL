# This azure main.tf file configures 
#  - A baseline SQL server 
#  - An elastic pool on top of that SQL server

# Deploy Azure SQL Server

resource "azurerm_sql_server" "sql" {
  name                         = format("${random_string.random.result}sql-elastic-pool-%s-uksouth", var.ENV_ID) # Change name for own purposes.
  location                     = azurerm_resource_group.rg.location
  resource_group_name          = azurerm_resource_group.rg.name
  version                      = "12.0"
  administrator_login          = var.ADMIN_LOGIN
  administrator_login_password = var.ADMIN_PASSWORD
}


# Deploy Azure Elastic Pool

resource "azurerm_mssql_elasticpool" "ep" {
  name                = format("sql-elastic-pool-%s-uksouth", var.ENV_ID) # Change name for own purposes.
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_sql_server.sql.name
  license_type        = "LicenseIncluded"
  max_size_gb         = 10

  sku {
    name     = "GP_Gen5"
    tier     = "GeneralPurpose"
    family   = "Gen5"
    capacity = 2
  }

  per_database_settings {
    min_capacity = 0.25
    max_capacity = 2
  }

   tags = {
    Service        =  "SQL Elastic Pool", # Change name for own purposes.
    Last_Deployment = timestamp(),
    Environment     = var.ENV_ID
  }

}
