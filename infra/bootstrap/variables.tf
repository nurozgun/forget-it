variable "aws_region" {
  description = "Region the state bucket lives in"
  type        = string
  default     = "us-east-1"
}

variable "state_bucket_name" {
  description = "Globally unique name of the Terraform state bucket"
  type        = string
  default     = "nurozgun-forget-it-tfstate"
}
