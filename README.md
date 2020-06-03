[<img src="https://raw.githubusercontent.com/mineiros-io/brand/master/mineiros-primary-logo.svg" width="400"/>](https://mineiros.io/?ref=terraform-github-organization)

[![Build Status](https://mineiros.semaphoreci.com/badges/terraform-github-organization/branches/master.svg?style=shields)](https://mineiros.semaphoreci.com/projects/terraform-github-organization)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mineiros-io/terraform-github-organization.svg?label=latest&sort=semver)](https://github.com/mineiros-io/terraform-github-organization/releases)
[![license](https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg)](https://opensource.org/licenses/Apache-2.0)
[![Terraform Version](https://img.shields.io/badge/terraform-~%3E%200.12.20-623CE4.svg)](https://github.com/hashicorp/terraform/releases)
[<img src="https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack">](https://join.slack.com/t/mineiros-community/shared_invite/zt-ehidestg-aLGoIENLVs6tvwJ11w9WGg)

A Terraform module that acts as a wrapper around the Terraform
[GitHub provider](https://www.terraform.io/docs/providers/github/index.html) and offers a more convenient and tested way
 to manage GitHub Organizations following best practices.

- [Getting Started](#getting-started)
- [Module Features](#module-features)
- [Limitations](#limitations)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## Getting Started

To quickly start managing your GitHub Organization with Terraform:

```hcl
module "organization" {
  source  = "mineiros-io/organization/github"
  version = "0.0.5"

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
```

> This Module uses `For, For-Each and Dynamic Nested Blocks` that were introduced in Terraform 0.12.
> A common problem in Terraform configurations for versions 0.11 and earlier is dealing with situations where the number
> of values or resources is decided by a dynamic expression rather than a fixed count.
> You can now dynamically add and remove items from and to Lists without the necessity to render the whole list of
> resources again. Terraform will only add and remove the items you want it to.

## Module Features

**Standard github provider features:**

1. Organization Members
1. Organization Owners (Admins)
1. Organization Projects
1. Blocked Users

**Additional module features:**

1. Change organization member roles without removing and re-inviting users
1. Rename projects without recreating (when providing unique ids)
1. No need to import members/admins on first run
1. Create an all member team that contains every member of your organization

## Limitations

- Currently the [GitHub Provider](https://www.terraform.io/docs/providers/github/index.html) doesn't support to
  provision new organizations.

## Module Versioning

This Module follows the principles of [Semantic Versioning (SemVer)](https://semver.org/).

Using the given version number of `MAJOR.MINOR.PATCH`, we apply the following constructs:

1. Use the `MAJOR` version for incompatible changes.
1. Use the `MINOR` version when adding functionality in a backwards compatible manner.
1. Use the `PATCH` version when introducing backwards compatible bug fixes.

### Backwards compatibility in `0.0.z` and `0.y.z` version

- In the context of initial development, backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is
  increased. (Initial development)
- In the context of pre-release, backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is
  increased. (Pre-release)

## About Mineiros

Mineiros is a [DevOps as a Service](https://mineiros.io/?ref=terraform-github-organization) company based in Berlin, Germany. We offer commercial support
for all of our projects and encourage you to reach out if you have any questions or need help.
Feel free to send us an email at [hello@mineiros.io](mailto:hello@mineiros.io).

We can also help you with:

- Terraform modules for all types of infrastructure such as VPCs, Docker clusters, databases, logging and monitoring, CI, etc.
- Consulting & training on AWS, Terraform and DevOps

## Reporting Issues

We use GitHub [Issues](https://github.com/mineiros-io/terraform-github-organization/issues)
to track community reported issues and missing features.

## Contributing

Contributions are always encouraged and welcome! For the process of accepting changes, we use
[Pull Requests](https://github.com/mineiros-io/terraform-github-organization/pulls). If you'd like more information, please
see our [Contribution Guidelines](https://github.com/mineiros-io/terraform-github-organization/blob/master/CONTRIBUTING.md).

## Makefile Targets

This repository comes with a handy
[Makefile](https://github.com/mineiros-io/terraform-github-organization/blob/master/Makefile).
Run `make help` to see details on each available target.

## License

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE](https://github.com/mineiros-io/terraform-github-organization/blob/master/LICENSE) for full details.

Copyright &copy; 2020 Mineiros GmbH
