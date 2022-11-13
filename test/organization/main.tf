# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# MANAGE A GITHUB ORGANIZATION
#   - manage blocked users
#   - manage projects
#   - manage memberships ( admins and members )
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

module "organization" {
  source = "../.."

  all_members_team_name       = var.all_members_team_name
  all_members_team_visibility = "closed"
  members                     = var.members
  admins                      = var.admins
  blocked_users               = var.blocked_users
  projects                    = var.projects
  settings                    = var.settings
}
