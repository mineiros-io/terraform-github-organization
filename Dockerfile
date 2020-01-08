FROM golang:1.13.5-alpine3.11
MAINTAINER "The Mineiros.io Team <hello@mineiros.io>"

RUN apk add --update bash git python3 terraform

RUN pip3 install pre-commit

WORKDIR /app/src

COPY . .

RUN pre-commit install
