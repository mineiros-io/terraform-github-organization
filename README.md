[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>](https://mineiros.io/?ref=terraform-github-organization)

[![Build Status](https://github.com/mineiros-io/terraform-github-organization/workflows/CI/CD%20Pipeline/badge.svg)](https://github.com/mineiros-io/terraform-github-organization/actions)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mineiros-io/terraform-github-organization.svg?label=latest&sort=semver)](https://github.com/mineiros-io/terraform-github-organization/releases)
[![Terraform Version](https://img.shields.io/badge/terraform-1.x-623CE4.svg?logo=terraform)](https://github.com/hashicorp/terraform/releases)
[![Github Provider Version](https://img.shields.io/badge/GH-5.x-F8991D.svg?logo=terraform)](https://github.com/terraform-providers/terraform-provider-github/releases)
[![Join Slack](https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack)](https://join.slack.com/t/mineiros-community/shared_invite/zt-ehidestg-aLGoIENLVs6tvwJ11w9WGg)

# terraform-github-organization

A [Terraform] module that acts as a wrapper around the Terraform
[GitHub provider](https://www.terraform.io/docs/providers/github/index.html) and offers a more convenient and tested way
to manage GitHub Organizations following best practices.

**_This module supports Terraform v1.x and is compatible with the Official Terraform GitHub Provider v5.x from `integrations/github`._**

**Attention: This module is incompatible with the Hashicorp GitHub Provider! The latest version of this module supporting `hashicorp/github` provider is `~> 0.6.0`**


- [GitHub as Code](#github-as-code)
- [Module Features](#module-features)
- [Getting Started](#getting-started)
- [Module Argument Reference](#module-argument-reference)
  - [Top-level Arguments](#top-level-arguments)
- [Module Outputs](#module-outputs)
- [External Documentation](#external-documentation)
  - [Terraform Github Provider Documentation:](#terraform-github-provider-documentation)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## GitHub as Code

[GitHub as Code][github-as-code] is a commercial solution built on top of
our open-source Terraform modules for GitHub. It helps our customers to
manage their GitHub organization more efficiently by enabling anyone in
their organization to **self-service** manage **on- and offboarding of users**,
**repositories**, and settings such as **branch protections**, **secrets**, and more
through code. GitHub as Code comes with **pre-configured GitHub Actions
pipelines** for **change pre-view in Pull Requests**, **fully automated
rollouts** and **rollbacks**. It's a comprehensive, ready-to-use blueprint
maintained by our team of platform engineering experts and saves
companies such as yours tons of time by building on top of a pre-configured
solution instead of building and maintaining it yourself.

For details please see [https://mineiros.io/github-as-code][github-as-code].

## Module Features

- **Standard Module Features**:
  Organization Members,
  Organization Owners (Admins),
  Organization Projects,
  Blocked Users,
  Manage Organization Settings


- **Extended Module Features**:
  Change organization member roles without removing and re-inviting users,
  Rename projects without recreating (when providing unique ids),
  No need to import members/admins on first run,
  Create an all member team that contains every member of your organization

## Getting Started

To quickly start managing your GitHub Organization with Terraform:

```hcl
module "organization" {
  source  = "mineiros-io/organization/github"
  version = "~> 0.9.0"

  create_all_members_team = true

  settings = {
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

## Module Argument Reference

See [variables.tf] and [examples/] for details and use-cases.

### Top-level Arguments

- [**`settings`**](#var-settings): *(Optional `object(settings)`)*<a name="var-settings"></a>

  A map of settings for the GitHub organization.

  Default is `{"fixed_response":{"content_type":"plain/text","message_body":"Nothing to see here!","status_code":418}}`.

  The `settings` object accepts the following attributes:

  - [**`billing_email`**](#attr-settings-billing_email): *(**Required** `string`)*<a name="attr-settings-billing_email"></a>

    The billing email address for the organization.

  - [**`email`**](#attr-settings-email): *(Optional `string`)*<a name="attr-settings-email"></a>

    The email address for the organization.

  - [**`name`**](#attr-settings-name): *(Optional `string`)*<a name="attr-settings-name"></a>

    The name for the organization.

  - [**`description`**](#attr-settings-description): *(Optional `string`)*<a name="attr-settings-description"></a>

    The description for the organization.

  - [**`company_name`**](#attr-settings-company_name): *(Optional `string`)*<a name="attr-settings-company_name"></a>

    The company name for the organization.

  - [**`blog`**](#attr-settings-blog): *(Optional `string`)*<a name="attr-settings-blog"></a>

    The blog URL for the organization.

  - [**`twitter_username`**](#attr-settings-twitter_username): *(Optional `string`)*<a name="attr-settings-twitter_username"></a>

    The Twitter username for the organization.

  - [**`location`**](#attr-settings-location): *(Optional `string`)*<a name="attr-settings-location"></a>

    The location for the organization.

  - [**`has_organization_projects`**](#attr-settings-has_organization_projects): *(Optional `bool`)*<a name="attr-settings-has_organization_projects"></a>

    Whether or not organization projects are enabled for the organization.

    Default is `true`.

  - [**`has_repository_projects`**](#attr-settings-has_repository_projects): *(Optional `bool`)*<a name="attr-settings-has_repository_projects"></a>

    Whether or not repository projects are enabled for the organization.

    Default is `true`.

  - [**`default_repository_permission`**](#attr-settings-default_repository_permission): *(Optional `string`)*<a name="attr-settings-default_repository_permission"></a>

    The default permission for organization members to create new repositories.
    Can be one of `read`, `write`, `admin`, or `none`.

  - [**`members_can_create_repositories`**](#attr-settings-members_can_create_repositories): *(Optional `bool`)*<a name="attr-settings-members_can_create_repositories"></a>

    Whether or not organization members can create new repositories.

    Default is `false`.

  - [**`members_can_create_public_repositories`**](#attr-settings-members_can_create_public_repositories): *(Optional `bool`)*<a name="attr-settings-members_can_create_public_repositories"></a>

    Whether or not organization members can create new public repositories.

    Default is `true`.

  - [**`members_can_create_private_repositories`**](#attr-settings-members_can_create_private_repositories): *(Optional `bool`)*<a name="attr-settings-members_can_create_private_repositories"></a>

    Whether or not organization members can create new private repositories.

    Default is `false`.

  - [**`members_can_create_internal_repositories`**](#attr-settings-members_can_create_internal_repositories): *(Optional `bool`)*<a name="attr-settings-members_can_create_internal_repositories"></a>

    Whether or not organization members can create new internal repositories. For Enterprise Organizations only.

    Default is `false`.

  - [**`members_can_create_pages`**](#attr-settings-members_can_create_pages): *(Optional `bool`)*<a name="attr-settings-members_can_create_pages"></a>

    Whether or not organization members can create new pages.

    Default is `false`.

  - [**`members_can_create_public_pages`**](#attr-settings-members_can_create_public_pages): *(Optional `bool`)*<a name="attr-settings-members_can_create_public_pages"></a>

    Whether or not organization members can create new public pages.

    Default is `false`.

  - [**`members_can_fork_private_repositories`**](#attr-settings-members_can_fork_private_repositories): *(Optional `bool`)*<a name="attr-settings-members_can_fork_private_repositories"></a>

    Whether or not organization members can fork private repositories.

    Default is `false`.

  - [**`web_commit_signoff_required`**](#attr-settings-web_commit_signoff_required): *(Optional `bool`)*<a name="attr-settings-web_commit_signoff_required"></a>

    Whether or not commit signatures are required for commits to the organization.

    Default is `false`.

  - [**`advanced_security_enabled_for_new_repositories`**](#attr-settings-advanced_security_enabled_for_new_repositories): *(Optional `bool`)*<a name="attr-settings-advanced_security_enabled_for_new_repositories"></a>

    Whether or not advanced security is enabled for new repositories.

    Default is `false`.

  - [**`dependabot_alerts_enabled_for_new_repositories`**](#attr-settings-dependabot_alerts_enabled_for_new_repositories): *(Optional `bool`)*<a name="attr-settings-dependabot_alerts_enabled_for_new_repositories"></a>

    Whether or not dependabot alerts are enabled for new repositories.

    Default is `false`.

  - [**`dependabot_security_updates_enabled_for_new_repositories`**](#attr-settings-dependabot_security_updates_enabled_for_new_repositories): *(Optional `bool`)*<a name="attr-settings-dependabot_security_updates_enabled_for_new_repositories"></a>

    Whether or not dependabot security updates are enabled for new repositories.

    Default is `false`.

  - [**`dependency_graph_enabled_for_new_repositories`**](#attr-settings-dependency_graph_enabled_for_new_repositories): *(Optional `bool`)*<a name="attr-settings-dependency_graph_enabled_for_new_repositories"></a>

    Whether or not dependency graph is enabled for new repositories.

    Default is `false`.

  - [**`secret_scanning_enabled_for_new_repositories`**](#attr-settings-secret_scanning_enabled_for_new_repositories): *(Optional `bool`)*<a name="attr-settings-secret_scanning_enabled_for_new_repositories"></a>

    Whether or not secret scanning is enabled for new repositories.

    Default is `false`.

  - [**`secret_scanning_push_protection_enabled_for_new_repositories`**](#attr-settings-secret_scanning_push_protection_enabled_for_new_repositories): *(Optional `bool`)*<a name="attr-settings-secret_scanning_push_protection_enabled_for_new_repositories"></a>

    Whether or not secret scanning push protection is enabled for new repositories.

    Default is `false`.

- [**`blocked_users`**](#var-blocked_users): *(Optional `set(string)`)*<a name="var-blocked_users"></a>

  A list of usernames to be blocked from a GitHub organization.

  Default is `[]`.

  Example:

  ```hcl
  blocked_users = [
    "blocked-user"
  ]
  ```

- [**`members`**](#var-members): *(Optional `set(string)`)*<a name="var-members"></a>

  A list of users to be added to your organization with member role.
  When applied, an invitation will be sent to the user to become part of the organization.
  When destroyed, either the invitation will be cancelled or the user will be removed.

  Default is `[]`.

  Example:

  ```hcl
  members = [
    "admin",
    "another-admin"
  ]
  ```

- [**`admins`**](#var-admins): *(Optional `set(string)`)*<a name="var-admins"></a>

  A list of users to be added to your organization with admin role.
  When applied, an invitation will be sent to the user to become part of the organization.
  When destroyed, either the invitation will be cancelled or the user will be removed.

  Default is `[]`.

  Example:

  ```hcl
  admins = [
    "admin",
    "another-admin"
  ]
  ```

- [**`projects`**](#var-projects): *(Optional `list(project)`)*<a name="var-projects"></a>

  Create and manage projects for the GitHub organization.

  Default is `[]`.

  Example:

  ```hcl
  projects = [
    {
      name   = "Test Project"
      body   = "This is a test project created by Terraform"
    },
    {
      name   = "Test Project without a body"
    }
  ]
  ```

- [**`all_members_team_name`**](#var-all_members_team_name): *(Optional `string`)*<a name="var-all_members_team_name"></a>

  The name of the team that contains all members of the organization.

- [**`all_members_team_visibility`**](#var-all_members_team_visibility): *(Optional `string`)*<a name="var-all_members_team_visibility"></a>

  The level of privacy for the team. Must be one of `secret` or `closed`.

  Default is `"secret"`.

- [**`catch_non_existing_members`**](#var-catch_non_existing_members): *(Optional `bool`)*<a name="var-catch_non_existing_members"></a>

  Validates if the list of GitHub users are existing users on every run. Use carefully as it will trigger one additional API call for every given user on every iteration.

  Default is `false`.

## Module Outputs

The following attributes are exported by the module:

- [**`blocked_users`**](#output-blocked_users): *(`set(string)`)*<a name="output-blocked_users"></a>

  A list of `github_organization_block` resource objects
  that describe all users that are blocked by the organization.

- [**`memberships`**](#output-memberships): *(`list(membership)`)*<a name="output-memberships"></a>

  A list of `github_membership` resource objects that describe
  all members of the organization.

- [**`projects`**](#output-projects): *(`list(project)`)*<a name="output-projects"></a>

  A list of `github_organization_project` resource objects that
  describe all projects of the organization.

- [**`all_members_team`**](#output-all_members_team): *(`object(all_members_team)`)*<a name="output-all_members_team"></a>

  The outputs of the all members team that contains all members of your organization.

- [**`settings`**](#output-settings): *(`object(all_members_team)`)*<a name="output-settings"></a>

  The outputs of the organization settings.

## External Documentation

### Terraform Github Provider Documentation:

- https://www.terraform.io/docs/providers/github/index.html

## Module Versioning

This Module follows the principles of [Semantic Versioning (SemVer)].

Given a version number `MAJOR.MINOR.PATCH`, we increment the:

1. `MAJOR` version when we make incompatible changes,
2. `MINOR` version when we add functionality in a backwards compatible manner, and
3. `PATCH` version when we make backwards compatible bug fixes.

### Backwards compatibility in `0.0.z` and `0.y.z` version

- Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
- Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)

## About Mineiros

Mineiros is a [DevOps as a Service][homepage] company based in Berlin, Germany.
We offer commercial support for all of our projects and encourage you to reach out
if you have any questions or need help. Feel free to send us an email at [hello@mineiros.io] or join our [Community Slack channel][slack].

We can also help you with:

- Terraform modules for all types of infrastructure such as VPCs, Docker clusters, databases, logging and monitoring, CI, etc.
- Consulting & training on AWS, Terraform and DevOps

## Reporting Issues

We use GitHub [Issues] to track community reported issues and missing features.

## Contributing

Contributions are always encouraged and welcome! For the process of accepting changes, we use
[Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].

## Makefile Targets

This repository comes with a handy [Makefile].
Run `make help` to see details on each available target.

## License

[![license][badge-license]][apache20]

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE] for full details.

Copyright &copy; 2021-2022 [Mineiros GmbH][homepage]


<!-- References -->

[homepage]: https://mineiros.io/?ref=terraform-github-organization
[github-as-code]: https://mineiros.io/github-as-code?ref=terraform-github-organization
[hello@mineiros.io]: mailto:hello@mineiros.io
[badge-build]: https://github.com/mineiros-io/terraform-github-organization/workflows/CI/CD%20Pipeline/badge.svg
[badge-semver]: https://img.shields.io/github/v/tag/mineiros-io/terraform-github-organization.svg?label=latest&sort=semver
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[badge-terraform]: https://img.shields.io/badge/terraform-1.x-623CE4.svg?logo=terraform
[badge-slack]: https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack
[build-status]: https://github.com/mineiros-io/terraform-github-organization/actions
[releases-github]: https://github.com/mineiros-io/terraform-github-organization/releases
[badge-tf-gh]: https://img.shields.io/badge/GH-4.x-F8991D.svg?logo=terraform
[releases-github-provider]: https://github.com/terraform-providers/terraform-provider-github/releases
[releases-terraform]: https://github.com/hashicorp/terraform/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://join.slack.com/t/mineiros-community/shared_invite/zt-ehidestg-aLGoIENLVs6tvwJ11w9WGg
[terraform]: https://www.terraform.io
[aws]: https://aws.amazon.com/
[semantic versioning (semver)]: https://semver.org/
[examples/example/main.tf]: https://github.com/mineiros-io/terraform-github-organization/blob/main/examples/example/main.tf
[variables.tf]: https://github.com/mineiros-io/terraform-github-organization/blob/main/variables.tf
[examples/]: https://github.com/mineiros-io/terraform-github-organization/blob/main/examples
[issues]: https://github.com/mineiros-io/terraform-github-organization/issues
[license]: https://github.com/mineiros-io/terraform-github-organization/blob/main/LICENSE
[makefile]: https://github.com/mineiros-io/terraform-github-organization/blob/main/Makefile
[pull requests]: https://github.com/mineiros-io/terraform-github-organization/pulls
[contribution guidelines]: https://github.com/mineiros-io/terraform-github-organization/blob/main/CONTRIBUTING.md
