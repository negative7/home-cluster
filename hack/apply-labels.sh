#!/usr/bin/env bash

NODES=$(kubectl get nodes | awk '{print $1}')

for node in $NODES
do
    kubectl label node $node k3s-upgrade=true
done
