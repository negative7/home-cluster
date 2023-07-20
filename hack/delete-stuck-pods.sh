#!/usr/bin/env bash

function delete_pod () {
    echo "Deleting pod $1 -n $2"
    kubectl -n $2 patch pod $1 -p '{"metadata":{"finalizers":null}}'
    kubectl delete pod -n $2 --grace-period=0 --force $pod
}

NAMESPACES=(actions-runner-system cert-manager default home kube-system kyverno longhorn-system monitoring networking system-upgrade)

for NS in ${NAMESPACES[@]}; do
    TERMINATING_PODS=$(kubectl get pods -n $NS | grep Terminating | awk '{print $1}')
    for pod in $TERMINATING_PODS
    do
        delete_pod $pod $NS
    done
    TERMINATING_PODS=$(kubectl get pods -n $NS | grep Unknown | awk '{print $1}')
    for pod in $TERMINATING_PODS
    do
        delete_pod $pod $NS
    done
    TERMINATING_PODS=$(kubectl get pods -n $NS | grep Evicted | awk '{print $1}')
    for pod in $TERMINATING_PODS
    do
        delete_pod $pod $NS
    done
    TERMINATING_PODS=$(kubectl get pods -n $NS | grep ContainerCreating | awk '{print $1}')
    for pod in $TERMINATING_PODS
    do
        delete_pod $pod $NS
    done
done
