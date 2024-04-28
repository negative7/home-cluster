#!/usr/bin/env bash

# Deploy the configuration to the nodes
talosctl apply-config -n 10.2.0.21 -f ./clusterconfig/cluster-0-kharkiv.yaml
talosctl apply-config -n 10.2.0.22 -f ./clusterconfig/cluster-0-vinnytsia.yaml 
talosctl apply-config -n 10.2.0.23 -f ./clusterconfig/cluster-0-dnipro.yaml 
talosctl apply-config -n 10.2.0.24 -f ./clusterconfig/cluster-0-kyiv.yaml

#upgrade cli to new version by  
# rm /usr/local/bin/talosctl
# curl -sL https://talos.dev/install | sh

# talosctl -n "10.2.0.21" upgrade
# talosctl -n "10.2.0.22" upgrade
# talosctl -n "10.2.0.23" upgrade
# talosctl -n "10.2.0.24" upgrade