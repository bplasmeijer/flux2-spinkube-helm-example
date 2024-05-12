#!/bin/bash

# Install k3d
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash

# Create a k3d cluster with the containerd-shim-spin image
k3d cluster create wasm-cluster \
  --image ghcr.io/spinkube/containerd-shim-spin/k3d:v0.14.1 \
  --port "8081:80@loadbalancer" \
  --agents 2

# Install fluxcd CLI
curl -s https://fluxcd.io/install.sh | sudo FLUX_VERSION=2.2.3 bash

# Bootstrap fluxcd
flux install --manifests manifests/flux-system