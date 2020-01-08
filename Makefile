#!/usr/bin/env make

# set required build variables if env variables aren't set yet
ifndef BUILD_VERSION
	BUILD_VERSION := latest
endif

ifndef REPOSITORY_NAME
	REPOSITORY_NAME := terraform-github-organization
endif

ifndef DOCKER_CACHE_IMAGE
	DOCKER_CACHE_IMAGE := ${REPOSITORY_NAME}-${BUILD_VERSION}.tar
endif

# Check that given variables are set and all have non-empty values,
# die with an error otherwise.
# https://stackoverflow.com/questions/10858261/abort-makefile-if-variable-not-set
#
# Params:
#   1. Variable name(s) to test.
#   2. (optional) Error message to print.
check_env_vars = \
    $(strip $(foreach 1,$1, \
        $(call __check_env_vars,$1,$(strip $(value 2)))))
__check_env_vars = \
    $(if $(value $1),, \
      $(error Please set $1$(if $2, ($2))))

# builds the image
docker-build:
	docker build -t ${REPOSITORY_NAME}:latest -t ${REPOSITORY_NAME}:${BUILD_VERSION} .

# saves docker image to disk
docker-save:
	docker save ${REPOSITORY_NAME}:${BUILD_VERSION} > ${DOCKER_CACHE_IMAGE}

# load saved image
docker-load:
	docker load < ${DOCKER_CACHE_IMAGE}

# Run pre-commit hooks
docker-run-pre-commit-hooks: docker-build
	docker run --rm ${REPOSITORY_NAME}:${BUILD_VERSION} pre-commit run --all-files

# Run pre-commit hooks using a cached image
docker-run-pre-commit-hooks-from-cache: $(call check_env_vars, GITHUB_ORGANIZATION GITHUB_TOKEN) docker-load
	docker run --rm  ${REPOSITORY_NAME}:${BUILD_VERSION} pre-commit run --all-files

# run tests
docker-run-tests: $(call check_env_vars, GITHUB_ORGANIZATION GITHUB_TOKEN) docker-build
	docker run --rm -e GITHUB_TOKEN -e GITHUB_ORGANIZATION ${REPOSITORY_NAME}:${BUILD_VERSION} go test -v -timeout 30m test/github_organization_test.go

# run tests using a cached image
docker-run-tests-from-cache: credential-check docker-load
	docker run --rm -e GITHUB_TOKEn -e GITHUB_ORGANIZATION ${REPOSITORY_NAME}:${BUILD_VERSION} go test -v -timeout 30m test/github_organization_test.go


.PHONY: docker-build
.PHONY: docker-save
.PHONY: docker-load
