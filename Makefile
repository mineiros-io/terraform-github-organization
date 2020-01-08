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
docker-run-pre-commit-hooks-from-cache: docker-build
	docker run --rm ${REPOSITORY_NAME}:${BUILD_VERSION} pre-commit run --all-files

# Run pre-commit hooks using a cached image
docker-run-tests-from-cache: docker-load
	docker run --rm  ${REPOSITORY_NAME}:${BUILD_VERSION} pre-commit run --all-files

# run tests
docker-run-tests: docker-build
	docker run --rm  ${REPOSITORY_NAME}:${BUILD_VERSION} go test .

# run tests using a cached image
docker-run-tests-from-cache: docker-load
	docker run --rm  ${REPOSITORY_NAME}:${BUILD_VERSION} go test .


.PHONY: docker-build
.PHONY: docker-save
.PHONY: docker-load
