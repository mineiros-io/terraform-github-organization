# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# MANAGE A GITHUB ORGANIZATION
#   - manage memberships ( admins and members )
#   - manage blocked users
#   - manage projects
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

locals {
  admins  = { for i in var.admins : lower(i) => "admin" }
  members = { for i in var.members : lower(i) => "member" }

  memberships = merge(local.admins, local.members)
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
