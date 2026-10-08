variable "name" {
  description = "Budget name"
  type        = string
}

variable "limit_amount" {
  description = "Monthly limit, in the account's billing currency"
  type        = string
}

variable "limit_unit" {
  description = "Currency of the limit; must match the account's billing currency"
  type        = string
  default     = "USD"
}

variable "alert_thresholds_percent" {
  description = "Percentages of the limit at which to send an email alert"
  type        = list(number)
  default     = [50, 80, 100]
}

variable "alert_emails" {
  description = "Email addresses notified when a threshold is crossed"
  type        = list(string)
}

variable "tags" {
  description = "Tags applied to the budget"
  type        = map(string)
  default     = {}
}
