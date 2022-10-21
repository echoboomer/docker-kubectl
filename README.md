# docker-kubectl

Image for executing various Kubernetes-centric commands in CI. Currently used by the `echoboomer` group for Circle CI.

## Purpose

This image is used in our pipelines to run generalized workflows against Kubernetes clusters or artifacts. It contains the following packages:

* `awscli` - Allows us to authenticate to EKS clusters.
* `bats` - Allows us to run tests.
* `helm` - Allows us to manipulate Helm charts and run unit tests against our own charts.
* `kubectl` - Allows us to interact with clusters.
* `kustomize` - Allows us to manipulate Kustomize files.
