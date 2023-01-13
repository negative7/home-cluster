#!/usr/bin/env bash

NODES=$(kubectl get nodes | awk '{print $1}')

for node in $NODES
do
    kubectl label node $node k3s-upgrade=true
done

kubectl label node vinnytsia node-role.kubernetes.io/worker=true
kubectl label node dnipro node-role.kubernetes.io/worker=true
kubectl label node kyiv node-role.kubernetes.io/worker=true
