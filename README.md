[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>][homepage]

[![Build Status][badge-build]][build-status]
[![GitHub tag (latest SemVer)][badge-semver]][releases-github]
[![Terraform Version][badge-terraform]][releases-terraform]
[![Github Provider Version][badge-tf-gh]][releases-github-provider]
[![Join Slack][badge-slack]][slack]

# terraform-github-organization

A [Terraform] module that acts as a wrapper around the Terraform
[GitHub provider](https://www.terraform.io/docs/providers/github/index.html) and offers a more convenient and tested way
to manage GitHub Organizations following best practices.

**_This module supports Terraform v1.x and is compatible with the Official Terraform GitHub Provider v4.x from `integrations/github`._**

**Attention: This module is incompatible with the Hashicorp GitHub Provider! The latest version of this module supporting `hashicorp/github` provider is `~> 0.6.0`**

- [Module Features](#module-features)
- [Getting Started](#getting-started)
- [Module Argument Reference](#module-argument-reference)
  - [Top-level Arguments](#top-level-arguments)
- [Module Attributes Reference](#module-attributes-reference)
- [External Documentation](#external-documentation)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## Module Features

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

## Getting Started

To quickly start managing your GitHub Organization with Terraform:

```hcl
module "organization" {
  source  = "mineiros-io/organization/github"
  version = "~> 0.6.0"

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

## Module Argument Reference

See [variables.tf] and [examples/] for details and use-cases.

### Top-level Arguments

- **`blocked_users`**: _(Optional `set(string)`)_

  A list of usernames to be blocked from a GitHub organization.
  Default is `[]`.

- **`members`**: _(Optional `set(string)`)_

  A list of users to be added to your organization with member role.
  When applied, an invitation will be sent to the user to become part of the organization.
  When destroyed, either the invitation will be cancelled or the user will be removed.
  Default is `[]`.

- **`admins`**: _(Optional `set(string)`)_

  A list of users to be added to your organization with admin role.
  When applied, an invitation will be sent to the user to become part of the organization.
  When destroyed, either the invitation will be cancelled or the user will be removed.
  Default is `[]`.

- **`projects`**: _(Optional `list(project)`)_
  Create and manage projects for the GitHub organization.
  Default is `[]`.

- **`all_members_team_name`**: _(Optional `string`)_

  The name of the team that contains all members of the organization.
  Default is `null`.

- **`all_members_team_visibility`**: _(Optional `string`)_

  The level of privacy for the team. Must be one of `secret` or `closed`.
  Default is `secret`.

- **`catch_non_existing_members`**: _(Optional `bool`)_

  Validates if the list of GitHub users are existing users on every run. Use carefully as it will trigger one additional API call for every given user on every iteration.
	Default is `false`.

## Module Attributes Reference

The following attributes are exported by the module:

- **`module_enabled`**

  Whether this module is enabled.

- **`blocked_users`**

  A list of `github_organization_block` resource objects
  that describe all users that are blocked by the organization.

- **`memberships`**

  A list of `github_membership` resource objects that describe
  all members of the organization.

- **`projects`**

  A list of `github_organization_project` resource objects that
  describe all projects of the organization.

## External Documentation

- Terraform Github Provider Documentation:
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

Copyright &copy; 2021 [Mineiros GmbH][homepage]

<!-- References -->

[homepage]: https://mineiros.io/?ref=terraform-github-organization
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
[examples/example/main.tf]: https://github.com/mineiros-io/terraform-github-organization/blob/master/examples/example/main.tf
[variables.tf]: https://github.com/mineiros-io/terraform-github-organization/blob/master/variables.tf
[examples/]: https://github.com/mineiros-io/terraform-github-organization/blob/master/examples
[issues]: https://github.com/mineiros-io/terraform-github-organization/issues
[license]: https://github.com/mineiros-io/terraform-github-organization/blob/master/LICENSE
[makefile]: https://github.com/mineiros-io/terraform-github-organization/blob/master/Makefile
[pull requests]: https://github.com/mineiros-io/terraform-github-organization/pulls
[contribution guidelines]: https://github.com/mineiros-io/terraform-github-organization/blob/master/CONTRIBUTING.md
