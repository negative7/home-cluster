#!/usr/bin/env bash

# Deploy the configuration to the nodes
talosctl apply-config -n 10.2.0.21 -f ./clusterconfig/cluster-0-kharkiv.yaml
talosctl apply-config -n 10.2.0.22 -f ./clusterconfig/cluster-0-vinnytsia.yaml 
talosctl apply-config -n 10.2.0.23 -f ./clusterconfig/cluster-0-dnipro.yaml 
talosctl apply-config -n 10.2.0.24 -f ./clusterconfig/cluster-0-kyiv.yaml

talosctl upgrade --nodes 10.2.0.21 --image ghcr.io/siderolabs/installer:v1.5.5
talosctl upgrade --nodes 10.2.0.22 --image ghcr.io/siderolabs/installer:v1.5.5
talosctl upgrade --nodes 10.2.0.23 --image ghcr.io/siderolabs/installer:v1.5.5
talosctl upgrade --nodes 10.2.0.24 --image ghcr.io/siderolabs/installer:v1.5.5
