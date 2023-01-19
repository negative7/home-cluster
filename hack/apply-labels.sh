#!/usr/bin/env bash

NODES=$(kubectl get nodes | awk '{print $1}')

for node in $NODES
do
    kubectl label node $node k3s-upgrade=true
done

kubectl label node vinnytsia node-role.kubernetes.io/worker=true
kubectl label node dnipro node-role.kubernetes.io/worker=true
kubectl label node kyiv node-role.kubernetes.io/worker=true


kubectl get pvc -n default --no-headers | grep config | awk '{print $3}' | xargs -l bash -c 'kubectl -n longhorn-system label volume/$0 recurring-job.longhorn.io/backup-1=enabled'
kubectl get pvc -n default --no-headers | grep config | awk '{print $3}' | xargs -l bash -c 'kubectl -n longhorn-system label volume/$0 recurring-job.longhorn.io/snapshot-1=enabled'

kubectl get pvc -n home --no-headers | grep config | awk '{print $3}' | xargs -l bash -c 'kubectl -n longhorn-system label volume/$0 recurring-job.longhorn.io/backup-1=enabled'
kubectl get pvc -n home --no-headers | grep config | awk '{print $3}' | xargs -l bash -c 'kubectl -n longhorn-system label volume/$0 recurring-job.longhorn.io/snapshot-1=enabled'
