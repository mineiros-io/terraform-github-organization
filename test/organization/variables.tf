# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# These variables must be set when using this module.
# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL VARIABLES
# These variables have defaults, but may be overridden.
# ---------------------------------------------------------------------------------------------------------------------

variable "admins" {
  description = "A list of admins to add to the organization."
  type        = set(string)
  default = [
    "terraform-test-admin",
  ]
}

variable "all_members_team_name" {
  description = "The name of the team that contains all members of the organization."
  type        = string
  default     = "everyone"
}

variable "all_members_team_visibility" {
  description = "The level of privacy for the team. Must be one of `secret` or `closed`."
  type        = string
  default     = "secret"
}

variable "blocked_users" {
  description = "A list of users that should be blocked by the organization."
  type        = set(string)

  # randomly chosen users, sorry for blocking you guys!
  default = [
    "Testuser1",
    "Testuser2",
  ]
}

variable "members" {
  description = "A list of members to add to the organization."
  type        = set(string)
  default = [
    "terraform-test-user-1",
    "terraform-test-user-2",
  ]
}

variable "projects" {
  description = "A list of projects to add to the organization."
  type        = any
  default = [
    {
      name = "Test Project"
      body = "This is a test project created by Terraform"
    },
    {
      name = "Test Project without a body"
    }
  ]
}

variable "settings" {
  description = "A map of settings to apply to the organization."
  type        = any
  default = {
    billing_email                                                = "hello@mineiros.io"
    company                                                      = "Mineiros"
    blog                                                         = "https://blog.mineiros.io"
    email                                                        = "hello@mineiros.io"
    twitter_username                                             = "mineirosio"
    location                                                     = "Berlin"
    name                                                         = "Terraform Tests"
    description                                                  = "This Organization is just used to run some Terraform tests for https://github.com/mineiros-io"
    has_organization_projects                                    = true
    has_repository_projects                                      = true
    default_repository_permission                                = "read"
    members_can_create_repositories                              = false
    members_can_create_public_repositories                       = false
    members_can_create_private_repositories                      = false
    members_can_create_internal_repositories                     = false
    members_can_create_pages                                     = false
    members_can_create_public_pages                              = false
    members_can_create_private_pages                             = false
    members_can_fork_private_repositories                        = false
    web_commit_signoff_required                                  = false
    advanced_security_enabled_for_new_repositories               = false
    dependabot_alerts_enabled_for_new_repositories               = false
    dependabot_security_updates_enabled_for_new_repositories     = false
    dependency_graph_enabled_for_new_repositories                = false
    secret_scanning_enabled_for_new_repositories                 = false
    secret_scanning_push_protection_enabled_for_new_repositories = false
  }
}
