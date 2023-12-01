#!/usr/bin/env bash

# Deploy the configuration to the nodes
talosctl apply-config -n 10.2.0.21 -f ./clusterconfig/cluster-0-kharkiv.yaml
talosctl apply-config -n 10.2.0.22 -f ./clusterconfig/cluster-0-vinnytsia.yaml 
talosctl apply-config -n 10.2.0.23 -f ./clusterconfig/cluster-0-dnipro.yaml 
talosctl apply-config -n 10.2.0.24 -f ./clusterconfig/cluster-0-kyiv.yaml

talosctl upgrade --nodes 10.2.0.21 --image factory.talos.dev/installer/22b1d04da881ef7c57edb0f24d1f3ba2c78a8e22cbe3fa9af4f42d487b2863f7:v1.5.5 
talosctl upgrade --nodes 10.2.0.22 --image factory.talos.dev/installer/22b1d04da881ef7c57edb0f24d1f3ba2c78a8e22cbe3fa9af4f42d487b2863f7:v1.5.5 
talosctl upgrade --nodes 10.2.0.23 --image factory.talos.dev/installer/22b1d04da881ef7c57edb0f24d1f3ba2c78a8e22cbe3fa9af4f42d487b2863f7:v1.5.5 
talosctl upgrade --nodes 10.2.0.24 --image factory.talos.dev/installer/22b1d04da881ef7c57edb0f24d1f3ba2c78a8e22cbe3fa9af4f42d487b2863f7:v1.5.5 

