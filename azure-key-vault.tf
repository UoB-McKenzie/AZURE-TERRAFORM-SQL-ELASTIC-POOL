# This azure main.tf file configures 
#  - A key vault and logging for storing sensitive values 
#  - Example code for creating access policies for users, Azure resources and service principles

# Deploy azure key vault

resource "azurerm_key_vault" "kv" {
  name                        = format("demonkvname%s", var.ENV_ID) # Change for your instance
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = var.TENANT_ID
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

 tags = {
    Service        =  "SQL Elastic Pool",
    Last_Deployment = timestamp(),
    Environment     = var.ENV_ID
  }

}

# Define Key Vault logging

resource "azurerm_monitor_diagnostic_setting" "log" {
  name               = "Key Vault access and metric logs"
  target_resource_id = azurerm_key_vault.kv.id
  storage_account_id = azurerm_storage_account.st.id

  log {
    category = "AuditEvent" 
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
}

# Define Key Vault access policies for SP, azure resources and users. 

resource "azurerm_key_vault_access_policy" "service_principle_access" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get",
  ]

  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set",
  ]

  storage_permissions = [
    "Get",
  ]
}

# Example setting key vault access rights for Azure service (Functions) 
/*

resource "azurerm_key_vault_access_policy" "resource_access" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_function_app.la_func.identity.0.principal_id

  key_permissions = [
    "Get",
  ]

  secret_permissions = [
    "Get",
    "List",
  ]

  storage_permissions = [
    "Get",
  ]

  depends_on = [azurerm_function_app.la_func]
}

*/

# Example setting key vault access rights for Azure user (Cloud admin in AD) 

/* 
resource "azurerm_key_vault_access_policy" "admin_access" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = "id" # Azure AD object ID for admin user 

  key_permissions = [
    "Get",
  ]

  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set",
  ]

  storage_permissions = [
    "Get",
  ]
} 

*/

# Define a Key Vault Secret - using var passed from CI/CD pipeline

resource "azurerm_key_vault_secret" "demo_secret" {
  name         = "DEMO-SECRET" # Change for your instance
  value        = var.DEMO_SECRET # Change for your instance
  key_vault_id = azurerm_key_vault.kv.id
  depends_on   = [azurerm_key_vault_access_policy.service_principle_access]
}

