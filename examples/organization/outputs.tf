output "all_outputs" {
  description = "All outputs exposed by this module."
  value       = module.organization
}

output "blocked_users" {
  description = "A list of users that are blocked by the organiation."
  value       = module.organization.blocked_users
}

output "memberships" {
  description = "A map of members and admins keyed by username."
  value       = module.organization.memberships
}

output "projects" {
  description = "A map of projects keyed by the id (default: project name)."
  value       = module.organization.projects
}

