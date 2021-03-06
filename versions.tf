# ---------------------------------------------------------------------------------------------------------------------
# SET TERRAFORM AND PROVIDER REQUIREMENTS FOR RUNNING THIS MODULE
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.12.20, < 2.0"

  required_providers {
    github = ">= 2.4, < 5.0"
  }
}
