variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "common_tags" {
  type = map(string)
  default = {
    "CreatedBy"  = "Terraform"
    "Project"    = "illuminati"
    "Repository" = "https://github.com/Red-I3ull/illuminati-iac.git"
    "Module"     = "account-setup"
  }
}
