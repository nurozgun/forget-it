variable "aws_region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment tag applied to all resources"
  type        = string
  default     = "dev"
}

variable "budget_alert_emails" {
  description = "Email addresses notified by the monthly budget alert"
  type        = list(string)
}
