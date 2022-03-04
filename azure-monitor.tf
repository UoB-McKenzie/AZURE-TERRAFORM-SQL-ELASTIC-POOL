# This azure monitor.tf file configures 
#  - A baseline alert group that Azure will send alerts to when thresholds are met 
#  - A baseline budget alert to ensure costs are monitored from first deployment

# Creates alert group 

resource "azurerm_monitor_action_group" "action_group" {
  
  name                = format("monitor-group-%s-uksouth", var.ENV_ID) # Change name for own purposes.
  resource_group_name = azurerm_resource_group.rg.name
  short_name          = format("monitor-%s", var.ENV_ID)

   email_receiver {
    name                    = "D McKenzie"
    email_address           = "d.a.mckenzie@bham.ac.uk"
    use_common_alert_schema = true
  }

}

# Creates alert for budget

resource "azurerm_consumption_budget_subscription" "budget" {
  name            = "Monthy_budget"
  subscription_id = data.azurerm_subscription.current.subscription_id

  amount     = 350
  time_grain = "Monthly"

  time_period {
    start_date = "2022-06-01T00:00:00Z"
    end_date   = "2023-07-01T00:00:00Z"
  }

notification {
    enabled   = true
    threshold = 50.0
    operator  = "GreaterThan"

    contact_emails = [
        "d.a.mckenzie@bham.ac.uk",
    ]
  }

  notification {
    enabled   = true
    threshold = 75.0
    operator  = "GreaterThan"

    contact_emails = [
      "d.a.mckenzie@bham.ac.uk",
    ]
  }


}