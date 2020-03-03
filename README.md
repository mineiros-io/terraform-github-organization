<img src="https://i.imgur.com/t8IkKoZl.png" width="200"/>

[![Maintained by Mineiros.io](https://img.shields.io/badge/maintained%20by-mineiros.io-00607c.svg)](https://www.mineiros.io/ref=repo_terraform-github-organization)
[![Build Status](https://mineiros.semaphoreci.com/badges/terraform-github-organization/branches/master.svg?style=shields)](https://mineiros.semaphoreci.com/badges/terraform-github-organization/branches/master.svg?style=shields)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mineiros-io/terraform-github-organization.svg?label=latest&sort=semver)](https://github.com/mineiros-io/terraform-github-organization/releases)
[![Terraform Version](https://img.shields.io/badge/terraform-~%3E%200.12.9-brightgreen.svg)](https://github.com/hashicorp/terraform/releases)
[![Github Provider Version](https://img.shields.io/badge/github--provider-%3E%3D%202.3.1-brightgreen.svg)](https://github.com/terraform-providers/terraform-provider-github/releases)
[![License](https://img.shields.io/badge/License-Apache%202.0-brightgreen.svg)](https://opensource.org/licenses/Apache-2.0)

A Terraform module that acts as a wrapper around the Terraform
[GitHub provider](https://www.terraform.io/docs/providers/github/index.html) and offers a more convenient and tested way
 to manage GitHub Organizations following best practices.

- [Getting Started](#getting-started)
- [Module Features](#module-features)
- [Limitations](#limitations)
- [Makefile](#makefile)
- [Module Versioning](#module-versioning)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [License](#license)

## Getting Started

To quickly start managing your GitHub Organization with Terraform:

```hcl
module "organization" {
  source  = "mineiros-io/organization/github"
  version = "0.0.5"


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

## Limitations
- Currently the [GitHub Provider](https://www.terraform.io/docs/providers/github/index.html) doesn't support to
  provision new organizations.

## Makefile
This repository comes with a handy [https://github.com/mineiros-io/terraform-module-template/blob/master/Makefile](Makefile).
Run `make help` to see details on each available target.

## Module Versioning
This Module follows the principles of [Semantic Versioning (SemVer)](https://semver.org/).

Given a version number `MAJOR.MINOR.PATCH`, we increment the:
1) `MAJOR` version when we make incompatible changes,
2) `MINOR` version when we add functionality in a backwards compatible manner, and
3) `PATCH` version when we make backwards compatible bug fixes.

### Backwards compatibility in `0.0.z` and `0.y.z` version
- Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
- Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)

## About Mineiros
Mineiros is a [DevOps as a Service](https://mineiros.io/) Company based in Berlin, Germany.
We offer Commercial Support for all of our projects, just send us an email to [hello@mineiros.io](mailto:hello@mineiros.io).

We can also help you with:
- Terraform Modules for all types of infrastructure such as VPC's, Docker clusters,
databases, logging and monitoring, CI, etc.
- Complex Cloud- and Multi Cloud environments.
- Consulting & Training on AWS, Terraform and DevOps.

## Reporting Issues
We use GitHub [Issues](https://github.com/mineiros-io/terraform-github-repository/issues) to track community reported issues and missing features.

## Contributing
Contributions are very welcome!
We use [Pull Requests](https://github.com/mineiros-io/terraform-github-repository/pulls)
for accepting changes.
Please see our
[Contribution Guidelines](https://github.com/mineiros-io/terraform-github-repository/blob/master/CONTRIBUTING.md)
for full details.

## License
This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE](https://github.com/mineiros-io/terraform-github-repository/blob/master/LICENSE) for full details.

Copyright &copy; 2020 Mineiros
