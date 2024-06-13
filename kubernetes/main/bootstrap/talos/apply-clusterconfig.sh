#!/usr/bin/env bash

# Deploy the configuration to the nodes
talosctl apply-config -n 10.2.0.21 -f ./clusterconfig/main-kharkiv.yaml
talosctl apply-config -n 10.2.0.22 -f ./clusterconfig/main-vinnytsia.yaml
talosctl apply-config -n 10.2.0.23 -f ./clusterconfig/main-dnipro.yaml
talosctl apply-config -n 10.2.0.24 -f ./clusterconfig/main-kyiv.yaml

#upgrade cli to new version by
# rm /usr/local/bin/talosctl
# curl -sL https://talos.dev/install | sh

# talosctl -n "10.2.0.21" upgrade
# talosctl -n "10.2.0.22" upgrade
# talosctl -n "10.2.0.23" upgrade
# talosctl -n "10.2.0.24" upgrade
