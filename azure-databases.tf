# This azure database.tf file configures 
#  - Individual SQL databases each added to the SQL Elastic Pool

# Deploy Azure SQL Database 1

resource "azurerm_mssql_database" "sql-db-1" {
  name               = format("${random_string.random.result}db-title-elastic-pool-%s-uksouth", var.ENV_ID) # Change name for own purposes.
  server_id          = azurerm_sql_server.sql.id
  collation          = "SQL_Latin1_General_CP1_CI_AS"
  license_type       = "LicenseIncluded"
  max_size_gb        = 4
  elastic_pool_id    = azurerm_mssql_elasticpool.ep.id
  geo_backup_enabled = false

   tags = {
    Service        =  "SQL Elastic Pool - DB",
    Last_Deployment = timestamp(),
    Environment     = var.ENV_ID
  }
}

/* Deploy Another Azure SQL Database 2

resource "azurerm_mssql_database" "sql-db-1" {
  name               = format("db-title1-elastic-pool-%s-uksouth", var.ENV_ID)
  server_id          = azurerm_sql_server.sql.id
  collation          = "SQL_Latin1_General_CP1_CI_AS"
  license_type       = "LicenseIncluded"
  max_size_gb        = 4
  elastic_pool_id    = azurerm_mssql_elasticpool.ep.id
  geo_backup_enabled = false

   tags = {
    Service        =  "SQL Elastic Pool - DB name",
    Last_Deployment = timestamp(),
    Environment     = var.ENV_ID
  }
} 

*/

