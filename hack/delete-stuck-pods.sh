#!/usr/bin/env bash

function delete_pod () {
    echo "Deleting pod $1 -n $2"
    kubectl -n $2 patch pod $1 -p '{"metadata":{"finalizers":null}}'
    kubectl delete pod $pod --grace-period=0 --force -n networking
}

TERMINATING_PODS=$(kubectl get pods -n networking | | grep cloudflare-ddns | grep Terminating | awk '{print $1}')
NS="networking"

for pod in $TERMINATING_PODS
do
    delete_pod $pod $NS
done
