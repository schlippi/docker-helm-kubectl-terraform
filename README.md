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

### helm-kubectl-terraform

Based on alpine.

| Name                                           | helm    | kubectl | terraform |
|------------------------------------------------|---------|---------|-----------|
| helm-kubectl-terraform:2.8.0__1.11.3__0.11.8   | v2.8.0  | v1.11.3 | 0.11.8    |
| helm-kubectl-terraform:2.8.0__1.11.3__0.11.10  | v2.8.0  | v1.11.3 | 0.11.10   |
| helm-kubectl-terraform:2.8.0__1.12.0__0.11.8   | v2.8.0  | v1.12.0 | 0.11.8    |
| helm-kubectl-terraform:2.8.0__1.12.0__0.11.10  | v2.8.0  | v1.12.0 | 0.11.10   |
| helm-kubectl-terraform:2.8.2__1.11.3__0.11.8   | v2.8.2  | v1.11.3 | 0.11.8    |
| helm-kubectl-terraform:2.8.2__1.11.3__0.11.10  | v2.8.2  | v1.11.3 | 0.11.10   |
| helm-kubectl-terraform:2.8.2__1.12.0__0.11.8   | v2.8.2  | v1.12.0 | 0.11.8    |
| helm-kubectl-terraform:2.8.2__1.12.0__0.11.10  | v2.8.2  | v1.12.0 | 0.11.10   |
| helm-kubectl-terraform:2.11.0__1.11.3__0.11.8  | v2.11.0 | v1.11.3 | 0.11.8    |
| helm-kubectl-terraform:2.11.0__1.11.3__0.11.10 | v2.11.0 | v1.11.3 | 0.11.10   |
| helm-kubectl-terraform:2.11.0__1.12.0__0.11.8  | v2.11.0 | v1.12.0 | 0.11.8    |
| helm-kubectl-terraform:2.11.0__1.12.0__0.11.10 | v2.11.0 | v1.12.0 | 0.11.10   |

### ruby-helm-kubectl-terraform

Based on ruby:2.5.3-alpine

| Name                                                | helm    | kubectl | terraform |
|-----------------------------------------------------|---------|---------|-----------|
| ruby-helm-kubectl-terraform:2.8.0__1.11.3__0.11.8   | v2.8.0  | v1.11.3 | 0.11.8    |
| ruby-helm-kubectl-terraform:2.8.0__1.11.3__0.11.10  | v2.8.0  | v1.11.3 | 0.11.10   |
| ruby-helm-kubectl-terraform:2.8.0__1.12.0__0.11.8   | v2.8.0  | v1.12.0 | 0.11.8    |
| ruby-helm-kubectl-terraform:2.8.0__1.12.0__0.11.10  | v2.8.0  | v1.12.0 | 0.11.10   |
| ruby-helm-kubectl-terraform:2.8.2__1.11.3__0.11.8   | v2.8.2  | v1.11.3 | 0.11.8    |
| ruby-helm-kubectl-terraform:2.8.2__1.11.3__0.11.10  | v2.8.2  | v1.11.3 | 0.11.10   |
| ruby-helm-kubectl-terraform:2.8.2__1.12.0__0.11.8   | v2.8.2  | v1.12.0 | 0.11.8    |
| ruby-helm-kubectl-terraform:2.8.2__1.12.0__0.11.10  | v2.8.2  | v1.12.0 | 0.11.10   |
| ruby-helm-kubectl-terraform:2.11.0__1.11.3__0.11.8  | v2.11.0 | v1.11.3 | 0.11.8    |
| ruby-helm-kubectl-terraform:2.11.0__1.11.3__0.11.10 | v2.11.0 | v1.11.3 | 0.11.10   |
| ruby-helm-kubectl-terraform:2.11.0__1.12.0__0.11.8  | v2.11.0 | v1.12.0 | 0.11.8    |
| ruby-helm-kubectl-terraform:2.11.0__1.12.0__0.11.10 | v2.11.0 | v1.12.0 | 0.11.10   |
