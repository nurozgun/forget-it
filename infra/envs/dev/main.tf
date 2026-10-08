module "budget" {
  source = "../../modules/budget"

  name         = "nur-budget"
  limit_amount = "5"
  alert_emails = var.budget_alert_emails

  tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
    Team        = "platform"
  }
}
