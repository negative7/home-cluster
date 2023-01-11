#!/usr/bin/env bash

function delete_pod () {
    echo "Deleting pod $1 -n $2"
    kubectl -n $2 patch pod $1 -p '{"metadata":{"finalizers":null}}'
    kubectl delete pod -n $2 --grace-period=0 --force $pod
}

TERMINATING_PODS=$(kubectl get pods -n networking | grep Terminating | awk '{print $1}')
NS="networking"

for pod in $TERMINATING_PODS
do
    delete_pod $pod $NS
done

TERMINATING_PODS3=$(kubectl get pods -n networking | grep Unknown | awk '{print $1}')

for pod in $TERMINATING_PODS3
do
    delete_pod $pod $NS
done

TERMINATING_PODS2=$(kubectl get pods -n media | grep Terminating | awk '{print $1}')
NS2="media"

for pod2 in $TERMINATING_PODS2
do
    delete_pod $pod2 $NS2
done



TERMINATING_PODS=$(kubectl get pods -n monitoring | grep Terminating | awk '{print $1}')
NS="monitoring"

for pod in $TERMINATING_PODS
do
    delete_pod $pod $NS
done


TERMINATING_PODS=$(kubectl get pods -n home | grep Terminating | awk '{print $1}')
NS="home"

for pod in $TERMINATING_PODS
do
    delete_pod $pod $NS
done


TERMINATING_PODS=$(kubectl get pods -n kube-system | grep Evicted | awk '{print $1}')
NS="kube-system"

for pod in $TERMINATING_PODS
do
    delete_pod $pod $NS
done

TERMINATING_PODS=$(kubectl get pods -n networking | grep Evicted | awk '{print $1}')
NS="networking"

for pod in $TERMINATING_PODS
do
    delete_pod $pod $NS
done
