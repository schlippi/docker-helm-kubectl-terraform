# docker-helm-kubectl-terraform
A Docker image that includes helm, kubectl, and terraform.

[![Build Status](https://travis-ci.org/ngeor/docker-helm-kubectl-terraform.svg?branch=master)](https://travis-ci.org/ngeor/docker-helm-kubectl-terraform)

- Inspired by [dtzar/helm-kubectl](https://github.com/dtzar/helm-kubectl)
- Includes `terraform`
- Docker image is published at https://hub.docker.com/r/ngeor/helm-kubectl-terraform/

## Tags

The tag scheme is a bit complex because of the multiple packages.

`helm-version__kubectl-version__terraform-version`

e.g.

`2.8.2__0.11.3__0.11.0`
