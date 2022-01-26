header {
  image = "https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg"
  url   = "https://mineiros.io/?ref=terraform-github-organization"

  badge "build" {
    image = "https://github.com/mineiros-io/terraform-github-organization/workflows/CI/CD%20Pipeline/badge.svg"
    url   = "https://github.com/mineiros-io/terraform-github-organization/actions"
    text  = "Build Status"
  }

  badge "semver" {
    image = "https://img.shields.io/github/v/tag/mineiros-io/terraform-github-organization.svg?label=latest&sort=semver"
    url   = "https://github.com/mineiros-io/terraform-github-organization/releases"
    text  = "GitHub tag (latest SemVer)"
  }

  badge "terraform" {
    image = "https://img.shields.io/badge/terraform-1.x-623CE4.svg?logo=terraform"
    url   = "https://github.com/hashicorp/terraform/releases"
    text  = "Terraform Version"
  }

  badge "tf-gh" {
    image = "https://img.shields.io/badge/GH-4.x-F8991D.svg?logo=terraform"
    url   = "https://github.com/terraform-providers/terraform-provider-github/releases"
    text  = "Github Provider Version"
  }

  badge "slack" {
    image = "https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack"
    url   = "https://join.slack.com/t/mineiros-community/shared_invite/zt-ehidestg-aLGoIENLVs6tvwJ11w9WGg"
    text  = "Join Slack"
  }
}

section {
  title   = "terraform-github-organization"
  toc     = true
  content = <<-END
    A [Terraform] module that acts as a wrapper around the Terraform
    [GitHub provider](https://www.terraform.io/docs/providers/github/index.html) and offers a more convenient and tested way
    to manage GitHub Organizations following best practices.

    **_This module supports Terraform v1.x and is compatible with the Official Terraform GitHub Provider v4.x from `integrations/github`._**

    **Attention: This module is incompatible with the Hashicorp GitHub Provider! The latest version of this module supporting `hashicorp/github` provider is `~> 0.6.0`**
  END

  section {
    title   = "Module Features"
    content = <<-END
    - **Standard Module Features**:
      Organization Members,
      Organization Owners (Admins),
      Organization Projects,
      Blocked Users

    - **Extended Module Features**:
      Change organization member roles without removing and re-inviting users,
      Rename projects without recreating (when providing unique ids),
      No need to import members/admins on first run,
      Create an all member team that contains every member of your organization
    END
  }

  section {
    title   = "Getting Started"
    content = <<-END
      To quickly start managing your GitHub Organization with Terraform:

      ```hcl
      module "organization" {
        source  = "mineiros-io/organization/github"
        version = "~> 0.7.0"

        create_all_members_team = true

        members = [
          "a-user",
          "b-user",
        ]

        admins = [
          "a-admin",
        ]

        blocked_users = [
          "blocked-user",
          "another-blocked-user",
        ]

        projects = [
          {
            id   = "project-a"
            name = "A Great Project"
            body = "This is a project created by Terraform"
          }
        ]
      }

      provider "github" {}

      terraform {
        required_version = "~> 1.0"

        required_providers {
          github = {
            source  = "integrations/github"
            version = "~> 4.0"
          }
        }
      }
      ```
    END
  }

  section {
    title   = "Module Argument Reference"
    content = <<-END
      See [variables.tf] and [examples/] for details and use-cases.
    END

    section {
      title = "Top-level Arguments"

      variable "blocked_users" {
        type           = set(string)
        default        = []
        description    = <<-END
          A list of usernames to be blocked from a GitHub organization.
        END
        readme_example = <<-END
          blocked_users = [
            "blocked-user"
          ]
        END
      }

      variable "members" {
        type           = set(string)
        default        = []
        description    = <<-END
          A list of users to be added to your organization with member role.
          When applied, an invitation will be sent to the user to become part of the organization.
          When destroyed, either the invitation will be cancelled or the user will be removed.
        END
        readme_example = <<-END
          members = [
            "admin",
            "another-admin"
          ]
        END
      }

      variable "admins" {
        type           = set(string)
        default        = []
        description    = <<-END
          A list of users to be added to your organization with admin role.
          When applied, an invitation will be sent to the user to become part of the organization.
          When destroyed, either the invitation will be cancelled or the user will be removed.
        END
        readme_example = <<-END
          admins = [
            "admin",
            "another-admin"
          ]
        END
      }

      variable "projects" {
        type           = list(project)
        default        = []
        description    = <<-END
          Create and manage projects for the GitHub organization.
        END
        readme_example = <<-END
          projects = [
            {
              name   = "Test Project"
              body   = "This is a test project created by Terraform"
            },
            {
              name   = "Test Project without a body"
            }
          ]
        END
      }

      variable "all_members_team_name" {
        type        = string
        description = <<-END
          The name of the team that contains all members of the organization.
        END
      }

      variable "all_members_team_visibility" {
        type        = string
        default     = "secret"
        description = <<-END
          The level of privacy for the team. Must be one of `secret` or `closed`.
        END
      }

      variable "catch_non_existing_members" {
        type        = bool
        default     = false
        description = <<-END
          Validates if the list of GitHub users are existing users on every run. Use carefully as it will trigger one additional API call for every given user on every iteration.
        END
      }
    }
  }

  section {
    title   = "Module Outputs"
    content = <<-END
      The following attributes are exported by the module:
    END

    output "blocked_users" {
      type        = set(string)
      description = <<-END
        A list of `github_organization_block` resource objects
        that describe all users that are blocked by the organization.
      END
    }

    output "memberships" {
      type        = list(membership)
      description = <<-END
        A list of `github_membership` resource objects that describe
        all members of the organization.
      END
    }

    output "projects" {
      type        = list(project)
      description = <<-END
        A list of `github_organization_project` resource objects that
        describe all projects of the organization.
      END
    }

    output "all_members_team" {
      type        = object(all_members_team)
      description = <<-END
        The outputs of the all members team that contains all members of your organization.
      END
    }

    output "module_enabled" {
      type        = bool
      description = <<-END
        Whether this module is enabled.
      END
    }
  }

  section {
    title = "External Documentation"

    section {
      title   = "Terraform Github Provider Documentation:"
      content = <<-END
        - https://www.terraform.io/docs/providers/github/index.html
      END
    }
  }

  section {
    title   = "Module Versioning"
    content = <<-END
      This Module follows the principles of [Semantic Versioning (SemVer)].

      Given a version number `MAJOR.MINOR.PATCH`, we increment the:

      1. `MAJOR` version when we make incompatible changes,
      2. `MINOR` version when we add functionality in a backwards compatible manner, and
      3. `PATCH` version when we make backwards compatible bug fixes.
    END

    section {
      title   = "Backwards compatibility in `0.0.z` and `0.y.z` version"
      content = <<-END
        - Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
        - Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)
      END
    }
  }

  section {
    title   = "About Mineiros"
    content = <<-END
      Mineiros is a [DevOps as a Service][homepage] company based in Berlin, Germany.
      We offer commercial support for all of our projects and encourage you to reach out
      if you have any questions or need help. Feel free to send us an email at [hello@mineiros.io] or join our [Community Slack channel][slack].

      We can also help you with:

      - Terraform modules for all types of infrastructure such as VPCs, Docker clusters, databases, logging and monitoring, CI, etc.
      - Consulting & training on AWS, Terraform and DevOps
    END
  }

  section {
    title   = "Reporting Issues"
    content = <<-END
      We use GitHub [Issues] to track community reported issues and missing features.
    END
  }

  section {
    title   = "Contributing"
    content = <<-END
      Contributions are always encouraged and welcome! For the process of accepting changes, we use
      [Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].
    END
  }

  section {
    title   = "Makefile Targets"
    content = <<-END
      This repository comes with a handy [Makefile].
      Run `make help` to see details on each available target.
    END
  }

  section {
    title   = "License"
    content = <<-END
      [![license][badge-license]][apache20]

      This module is licensed under the Apache License Version 2.0, January 2004.
      Please see [LICENSE] for full details.

      Copyright &copy; 2021-2022 [Mineiros GmbH][homepage]
    END
  }
}

references {
  ref "homepage" {
    value = "https://mineiros.io/?ref=terraform-github-organization"
  }
  ref "hello@mineiros.io" {
    value = "mailto:hello@mineiros.io"
  }
  ref "badge-build" {
    value = "https://github.com/mineiros-io/terraform-github-organization/workflows/CI/CD%20Pipeline/badge.svg"
  }
  ref "badge-semver" {
    value = "https://img.shields.io/github/v/tag/mineiros-io/terraform-github-organization.svg?label=latest&sort=semver"
  }
  ref "badge-license" {
    value = "https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg"
  }
  ref "badge-terraform" {
    value = "https://img.shields.io/badge/terraform-1.x-623CE4.svg?logo=terraform"
  }
  ref "badge-slack" {
    value = "https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack"
  }
  ref "build-status" {
    value = "https://github.com/mineiros-io/terraform-github-organization/actions"
  }
  ref "releases-github" {
    value = "https://github.com/mineiros-io/terraform-github-organization/releases"
  }
  ref "badge-tf-gh" {
    value = "https://img.shields.io/badge/GH-4.x-F8991D.svg?logo=terraform"
  }
  ref "releases-github-provider" {
    value = "https://github.com/terraform-providers/terraform-provider-github/releases"
  }
  ref "releases-terraform" {
    value = "https://github.com/hashicorp/terraform/releases"
  }
  ref "apache20" {
    value = "https://opensource.org/licenses/Apache-2.0"
  }
  ref "slack" {
    value = "https://join.slack.com/t/mineiros-community/shared_invite/zt-ehidestg-aLGoIENLVs6tvwJ11w9WGg"
  }
  ref "terraform" {
    value = "https://www.terraform.io"
  }
  ref "aws" {
    value = "https://aws.amazon.com/"
  }
  ref "semantic versioning (semver)" {
    value = "https://semver.org/"
  }
  ref "examples/example/main.tf" {
    value = "https://github.com/mineiros-io/terraform-github-organization/blob/main/examples/example/main.tf"
  }
  ref "variables.tf" {
    value = "https://github.com/mineiros-io/terraform-github-organization/blob/main/variables.tf"
  }
  ref "examples/" {
    value = "https://github.com/mineiros-io/terraform-github-organization/blob/main/examples"
  }
  ref "issues" {
    value = "https://github.com/mineiros-io/terraform-github-organization/issues"
  }
  ref "license" {
    value = "https://github.com/mineiros-io/terraform-github-organization/blob/main/LICENSE"
  }
  ref "makefile" {
    value = "https://github.com/mineiros-io/terraform-github-organization/blob/main/Makefile"
  }
  ref "pull requests" {
    value = "https://github.com/mineiros-io/terraform-github-organization/pulls"
  }
  ref "contribution guidelines" {
    value = "https://github.com/mineiros-io/terraform-github-organization/blob/main/CONTRIBUTING.md"
  }
}
