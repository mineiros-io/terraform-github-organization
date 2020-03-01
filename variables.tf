# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables.
# ---------------------------------------------------------------------------------------------------------------------

# GITHUB_ORGANIZATION
# GITHUB_TOKEN

# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# These variables must be set when using this module.
# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL VARIABLES
# These variables have defaults, but may be overridden.
# ---------------------------------------------------------------------------------------------------------------------

variable "blocked_users" {
  type        = set(string)
  description = "A list of usernames to be blocked from a GitHub organization."

  # Example:
  #
  # blocked_users = [
  #   "blocked-user"
  # ]

  default = []
}

variable "members" {
  type        = set(string)
  description = "A list of users to be added to your organization with member role. When applied, an invitation will be sent to the user to become part of the organization. When destroyed, either the invitation will be cancelled or the user will be removed."

  # Example:
  #
  # members = [
  #   "admin",
  #   "another-admin"
  # ]

  default = []
}

variable "admins" {
  type        = set(string)
  description = "A list of users to be added to your organization with admin role. When applied, an invitation will be sent to the user to become part of the organization. When destroyed, either the invitation will be cancelled or the user will be removed."

  # Example:
  #
  # admins = [
  #   "admin",
  #   "another-admin"
  # ]

  default = []
}

variable "projects" {
  type = list(any)

  # We can't use a detailed type specification due to a terraform limitation. However, this might be changed in a future
  # Terraform version. See https://github.com/hashicorp/terraform/issues/19898 and https://github.com/hashicorp/terraform/issues/22449
  #
  # type = list(object({
  #   name = string
  #   body = optional(string)
  # }))
  description = "Create and manage projects for the GitHub organization."

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

  default = []
}
