variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "common_tags" {
  type = map(string)
  default = {
    "CreatedBy"  = "Terraform"
    "Project"    = "illuminati"
    "Repository" = "https://github.com/the-apex-team/illuminati-iac.git"
    "Module"     = "account-setup"
  }
}
