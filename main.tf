# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# MANAGE A GITHUB ORGANIZATION
#   - manage memberships ( admins and members )
#   - manage blocked users
#   - manage projects
#   - create the team "all" that contains every member of the organization
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

locals {
  admins      = { for i in var.admins : lower(i) => "admin" }
  members     = { for i in var.members : lower(i) => "member" }
  memberships = merge(local.admins, local.members)
}

# Safeguard for validating if a GitHub user exists on `terraform plan`
data "github_user" "user" {
  for_each = var.catch_non_existing_members ? local.memberships : {}

  username = each.key
}

resource "github_membership" "membership" {
  for_each = local.memberships

  username = each.key
  role     = each.value
}

resource "github_organization_block" "blocked_user" {
  for_each = var.blocked_users

  username = each.value
}

locals {
  projects = { for p in var.projects : lookup(p, "id", lower(p.name)) => merge({
    body = null
  }, p) }
}

resource "github_organization_project" "project" {
  for_each = local.projects

  name = each.value.name
  body = each.value.body
}

resource "github_team" "all" {
  count = var.all_members_team_name != null ? 1 : 0

  name        = var.all_members_team_name
  description = "This teams contains all members of our organization."
  privacy     = var.all_members_team_visibility
}

resource "github_team_membership" "all" {
  for_each = var.all_members_team_name != null ? local.memberships : {}

  team_id  = github_team.all[0].id
  username = each.key
  role     = "member"
}

resource "github_organization_settings" "settings" {
  count = length(var.settings) > 0 ? 1 : 0

  billing_email                                                = var.settings.billing_email
  company                                                      = try(var.settings.company, null)
  blog                                                         = try(var.settings.blog, null)
  email                                                        = try(var.settings.email, null)
  twitter_username                                             = try(var.settings.twitter_username, null)
  location                                                     = try(var.settings.location, null)
  name                                                         = try(var.settings.name, null)
  description                                                  = try(var.settings.description, null)
  has_organization_projects                                    = try(var.settings.has_organization_projects, true)
  has_repository_projects                                      = try(var.settings.has_repository_projects, true)
  default_repository_permission                                = try(var.settings.default_repository_permission, "read")
  members_can_create_repositories                              = try(var.settings.members_can_create_repositories, false)
  members_can_create_public_repositories                       = try(var.settings.members_can_create_public_repositories, false)
  members_can_create_private_repositories                      = try(var.settings.members_can_create_private_repositories, false)
  members_can_create_internal_repositories                     = try(var.settings.members_can_create_internal_repositories, false)
  members_can_create_pages                                     = try(var.settings.members_can_create_pages, false)
  members_can_create_public_pages                              = try(var.settings.members_can_create_public_pages, false)
  members_can_create_private_pages                             = try(var.settings.members_can_create_private_pages, false)
  members_can_fork_private_repositories                        = try(var.settings.members_can_fork_private_repositories, false)
  web_commit_signoff_required                                  = try(var.settings.web_commit_signoff_required, false)
  advanced_security_enabled_for_new_repositories               = try(var.settings.advanced_security_enabled_for_new_repositories, false)
  dependabot_alerts_enabled_for_new_repositories               = try(var.settings.dependabot_alerts_enabled_for_new_repositories, false)
  dependabot_security_updates_enabled_for_new_repositories     = try(var.settings.advanced_security_enabled_for_new_repositories, false)
  dependency_graph_enabled_for_new_repositories                = try(var.settings.dependency_graph_enabled_for_new_repositories, false)
  secret_scanning_enabled_for_new_repositories                 = try(var.settings.secret_scanning_enabled_for_new_repositories, false)
  secret_scanning_push_protection_enabled_for_new_repositories = try(var.settings.secret_scanning_push_protection_enabled_for_new_repositories, false)
}
