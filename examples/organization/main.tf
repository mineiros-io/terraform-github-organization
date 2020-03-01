# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# MANAGE A GITHUB ORGANIZATION
#   - manage blocked users
#   - manage projects
#   - manage memberships ( admins and members )
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ---------------------------------------------------------------------------------------------------------------------
# SET TERRAFORM AND PROVIDER REQUIREMENTS FOR RUNNING THIS MODULE
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = "~> 0.12.9"
}

provider "github" {
  version = "~> 2.4"
}

module "organization" {
  source = "../.."

  members       = var.members
  admins        = var.admins
  blocked_users = var.blocked_users
  projects      = var.projects
}
