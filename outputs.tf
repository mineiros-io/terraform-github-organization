# ------------------------------------------------------------------------------
# OUTPUT CALCULATED VARIABLES (prefer full objects)
# ------------------------------------------------------------------------------

output "all_members_team" {
  description = "The outputs of the all members team that contains all members of your organization."
  value       = try(github_team.all[0], {})
}

# ------------------------------------------------------------------------------
# OUTPUT ALL RESOURCES AS FULL OBJECTS
# ------------------------------------------------------------------------------

output "blocked_users" {
  description = "The list of users that are blocked by the organiation."
  value       = github_organization_block.blocked_user
}

output "memberships" {
  description = "A map of members and admins keyed by username."
  value       = github_membership.membership
}

output "projects" {
  description = "A map of projects keyed by the id (default: project name)."
  value       = github_organization_project.project
}

# ------------------------------------------------------------------------------
# OUTPUT ALL INPUT VARIABLES
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OUTPUT MODULE CONFIGURATION
# ------------------------------------------------------------------------------
