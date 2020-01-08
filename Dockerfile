FROM golang:1.13.5-alpine3.11
MAINTAINER "The Mineiros.io Team <hello@mineiros.io>"

ENV TFLINT_VERSION="v0.13.4"
ENV TFLINT_SHA256SUM="f89113271e50259aac318c05f4e9a9a1b4ec4a59afaa9bb4f36438cbb346757f"

RUN apk add --update bash curl git python3 terraform

RUN pip3 install pre-commit

RUN curl -L -o /tmp/tflint.zip https://github.com/terraform-linters/tflint/releases/download/${TFLINT_VERSION}/tflint_linux_amd64.zip && unzip /tmp/tflint.zip -d /usr/local/bin

WORKDIR /app/src

COPY . .

RUN pre-commit install
