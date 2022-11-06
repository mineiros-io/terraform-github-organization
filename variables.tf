# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# These variables must be set when using this module.
# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL VARIABLES
# These variables have defaults, but may be overridden.
# ---------------------------------------------------------------------------------------------------------------------

variable "all_members_team_name" {
  description = "(Optional) The name of the team that contains all members of the organization."
  type        = string
  default     = null
}

variable "all_members_team_visibility" {
  description = "(Optional) The level of privacy for the team. Must be one of 'secret' or 'closed'."
  type        = string
  default     = "secret"
}

variable "catch_non_existing_members" {
  description = "(Optional) Validates if the list of GitHub users are existing users on every run. Use carefully as it will trigger one additional API call for every given user on every iteration. Default is 'false'"
  type        = bool
  default     = false
}

variable "blocked_users" {
  description = "(Optional) A list of usernames to be blocked from a GitHub organization."
  type        = set(string)

  #
  # Example:
  #
  # blocked_users = [
  #   "blocked-user"
  # ]
  #

  default = []
}

variable "members" {
  type        = set(string)
  description = "(Optional) A list of users to be added to your organization with member role. When applied, an invitation will be sent to the user to become part of the organization. When destroyed, either the invitation will be cancelled or the user will be removed."

  #
  # Example:
  #
  # members = [
  #   "admin",
  #   "another-admin"
  # ]
  #

  default = []
}

variable "admins" {
  type        = set(string)
  description = "(Optional) A list of users to be added to your organization with admin role. When applied, an invitation will be sent to the user to become part of the organization. When destroyed, either the invitation will be cancelled or the user will be removed."

  #
  # Example:
  #
  # admins = [
  #   "admin",
  #   "another-admin"
  # ]
  #

  default = []
}

variable "projects" {
  type = any

  # We can't use a detailed type specification due to a terraform limitation. However, this might be changed in a future
  # Terraform version. See https://github.com/hashicorp/terraform/issues/19898 and https://github.com/hashicorp/terraform/issues/22449
  #
  # type = list(object({
  #   name = string
  #   body = optional(string)
  # }))

  description = "(Optional) Create and manage projects for the GitHub organization."

  #
  # Example:
  #
  # projects = [
  #   {
  #     name   = "Test Project"
  #     body   = "This is a test project created by Terraform"
  #   },
  #   {
  #     name   = "Test Project without a body"
  #   }
  # ]
  #

  default = []
}

variable "settings" {
  type        = any
  description = "A map of settings for the GitHub organization."
  #
  # Example
  # settings = {
  #   billing_email                                                = "hello@mineiros.io"
  #   company                                                      = "Mineiros"
  #   blog                                                         = "https://blog.mineiros.io"
  #   email                                                        = "hello@mineiros.io"
  #   twitter_username                                             = "mineirosio"
  #   location                                                     = "Berlin"
  #   name                                                         = "Terraform Tests"
  #   description                                                  = "This Organization is just used to run some Terraform tests for https://github.com/mineiros-io"
  #   has_organization_projects                                    = true
  #   has_repository_projects                                      = true
  #   default_repository_permission                                = "read"
  #   members_can_create_repositories                              = false
  #   members_can_create_public_repositories                       = false
  #   members_can_create_private_repositories                      = false
  #   members_can_create_internal_repositories                     = false
  #   members_can_create_pages                                     = false
  #   members_can_create_public_pages                              = false
  #   members_can_create_private_pages                             = false
  #   members_can_fork_private_repositories                        = false
  #   web_commit_signoff_required                                  = false
  #   advanced_security_enabled_for_new_repositories               = false
  #   dependabot_alerts_enabled_for_new_repositories               = false
  #   dependabot_security_updates_enabled_for_new_repositories     = false
  #   dependency_graph_enabled_for_new_repositories                = false
  #   secret_scanning_enabled_for_new_repositories                 = false
  #   secret_scanning_push_protection_enabled_for_new_repositories = false
  # }
  #

  default = {}
}
