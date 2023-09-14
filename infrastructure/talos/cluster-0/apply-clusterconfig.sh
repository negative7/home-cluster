#!/usr/bin/env bash

# Deploy the configuration to the nodes
talosctl apply-config -n 10.2.0.21 -f ./clusterconfig/cluster-0-kharkiv.yaml
talosctl apply-config -n 10.2.0.22 -f ./clusterconfig/cluster-0-vinnytsia.yaml 
talosctl apply-config -n 10.2.0.23 -f ./clusterconfig/cluster-0-dnipro.yaml 
talosctl apply-config -n 10.2.0.24 -f ./clusterconfig/cluster-0-kyiv.yaml


# talosctl bootstrap --nodes 10.2.0.21 --endpoints 10.2.0.21 --talosconfig=./clusterconfig/talosconfig


#   talosctl  -n 10.2.0.21 containers --talosconfig=./clusterconfig/talosconfig


# talosctl -n 10.2.0.21 disks --talosconfig=./clusterconfig/talosconfig


# talosctl reset -n 10.2.0.23 --system-labels-to-wipe STATE --system-labels-to-wipe EPHEMERAL --reboot   