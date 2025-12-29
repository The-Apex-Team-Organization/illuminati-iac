variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "bird_app_url" {
  description = "URL of the bird watching app"
}

variable "bird_user" {
  description = "Username for the bird app"
  type        = string
  sensitive   = true
}

variable "bird_pass" {
  description = "Password for the bird app"
  type        = string
  sensitive   = true
}

variable "illuminati_api_url" {
  description = "URL for the secondary API"
}

