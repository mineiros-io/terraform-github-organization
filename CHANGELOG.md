# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.5.0]

### Added

- Add support for Terraform `v0.15`

## [0.4.1]

### Added

- Add safeguard to validate if a GitHub user exists before trying to add it to the organization

## [0.4.0]

### Added

- Add support for Github Provider `v4`

## [0.3.0]

### Added

- Add support for Terraform `v0.14`

## [0.2.0]

### Added

- Add support for Terraform `v0.13`
- Add support for Terraform Github Provider `v3`
- Prepare support for Terraform `v0.14` (needs terraform `v0.12.20` or above)

## [0.1.4] - 2020-06-23

### Added

- Add `CHANGELOG.md`.

### Changed

- Switch CI from SemaphoreCI to GitHub Actions.

## [0.1.3] - 2020-05-13

### Added

- Work around a terraform issue in `module_depends_on` argument.

## [0.1.2] - 2020-05-05

### Change

- New format for README.md and LICENSE.
- Bump pre-commit hooks to `v0.1.4` and add new hooks.
- Bump build-tools to `v0.5.3`

## [0.1.1] - 2020-04-18

### Added

- Introduce new variables `all_members_team_name` and `all_members_team_visibility`
  for adding the possibility to create a team which contains all members of your organization.

## [0.1.0] - 2020-03-03

### Added

- Added some more documentation.
- Pre-commit hooks upgrade.

### Changed

- Add variables and outputs to the existing example.

## [0.0.2] - 2020-01-12

### Added

- Added pre-commit hooks.
- Added automated unit tests.
- Added CI configuration.
- Added admins for adding members with admins/owner role.
- Added projects to outputs.

### Changed

- Changed members from complex object to list of usernames for adding normal members.

## [0.0.1] - 2020-01-06

### Added

- This is the initial release of our GitHub Organization module with support
  for managing GitHub Organizations, Members and Blocked Users.

<!-- markdown-link-check-disable -->

[unreleased]: https://github.com/mineiros-io/terraform-github-organization/compare/v0.5.0...HEAD
[0.5.0]: https://github.com/mineiros-io/terraform-github-organization/compare/v0.4.1...v0.5.0

<!-- markdown-link-check-enable -->

[0.4.1]: https://github.com/mineiros-io/terraform-github-organization/compare/v0.4.0...v0.4.1
[0.4.0]: https://github.com/mineiros-io/terraform-github-organization/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/mineiros-io/terraform-github-organization/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/mineiros-io/terraform-github-organization/compare/v0.1.4...v0.2.0
[0.1.4]: https://github.com/mineiros-io/terraform-github-organization/compare/v0.1.3...v0.1.4
[0.1.3]: https://github.com/mineiros-io/terraform-github-organization/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/mineiros-io/terraform-github-organization/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/mineiros-io/terraform-github-organization/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/mineiros-io/terraform-github-organization/compare/v0.0.2...v0.1.0
[0.0.2]: https://github.com/mineiros-io/terraform-github-organization/compare/v0.0.1...v0.0.2
[0.0.1]: https://github.com/mineiros-io/terraform-github-organization/releases/tag/v0.0.1
