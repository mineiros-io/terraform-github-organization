# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# MANAGE A GITHUB ORGANIZATION
#   - manage memberships ( admins and members )
#   - manage blocked users
#   - manage projects
#   - create the team "all" that contains every member of the organization
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

locals {
  admins  = { for i in var.admins : lower(i) => "admin" }
  members = { for i in var.members : lower(i) => "member" }

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
