variable "region" {
  description = "AWS region"
  type        = string
}

variable "env" {
  description = "Environment name (dev-01, stage-01)"
  type        = string
  validation {
    condition = (
      startswith(var.env, "dev") ||
      startswith(var.env, "stage") ||
      startswith(var.env, "prod")
    )
    error_message = "Environment name must start with 'dev', 'stage', or 'prod'."
  }
}