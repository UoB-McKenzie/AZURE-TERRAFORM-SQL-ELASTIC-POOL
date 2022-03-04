# This azure security.tf file configures 
#  - A baseline security assessment policy for a resource in terraform 
#  - NOTE: Azure defender must be enabled for the subscription

resource "azurerm_security_center_assessment_policy" "sec_center" {
  display_name = format("policy-%s", var.ENV_ID) # Change name for own purposes.
  severity     = "Medium"
  description  = "Description of your security policy"
}

resource "azurerm_security_center_assessment" "sec_center" {
  assessment_policy_id = azurerm_security_center_assessment_policy.sec_center.id
  target_resource_id   = azurerm_storage_account.st.id

  status {
    code = "Healthy"
  }
}

resource "azurerm_advanced_threat_protection" "example" {
  target_resource_id = azurerm_storage_account.st.id
  enabled            = true
}