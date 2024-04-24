# GitOps on Bare Metal using ArgoCD and ClusterAPI with Tinkerbell

This repository contains resources and configurations for implementing GitOps workflows on bare metal infrastructure using ArgoCD and ClusterAPI with Tinkerbell.

## Overview

GitOps is a methodology for managing infrastructure and applications declaratively using version control. This repository provides a reference implementation for GitOps on bare metal infrastructure, leveraging ArgoCD for GitOps management and ClusterAPI for provisioning and managing Kubernetes clusters. Tinkerbell is used as the provisioning engine to automate bare metal infrastructure provisioning.

## Contents

- **ArgoCD Configuration**: Configuration files for setting up ArgoCD to manage Kubernetes cluster configurations stored in Git repositories.
- **ClusterAPI Manifests**: Manifests and configuration files for ClusterAPI to provision and manage Kubernetes clusters on bare metal infrastructure.
- **Tinkerbell Workflow Templates**: Templates for Tinkerbell workflows used in the bare metal provisioning process.

## Getting Started

To get started, follow these steps:

Clone this repository to your local machine.
Customize the configurations according to your infrastructure requirements.
Run [bootstrap.sh](bootstrap.sh) to deploy a Managment Cluster on Equinix Metal

## Acknowledgments

This project is sponsored by **Equinix Metal**. We extend our thanks to **Equinix Metal** for their support and collaboration in making this project possible.

## Contributing

Contributions are welcome! Feel free to submit issues, feature requests, or pull requests to help improve this project.

## License

This project is licensed under the [MIT License](LICENSE).
