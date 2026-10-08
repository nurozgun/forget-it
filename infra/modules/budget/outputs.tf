output "arn" {
  description = "ARN of the budget"
  value       = aws_budgets_budget.monthly.arn
}
