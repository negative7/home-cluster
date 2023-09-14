#!/usr/bin/env bash
# shellcheck disable=2312
pushd integrations >/dev/null 2>&1 || exit 1

rm -rf cni/charts
envsubst < ../../../../kubernetes/cluster-0/apps/kube-system/cilium/app/values.yaml > cni/values.yaml
kustomize build --enable-helm cni | kubectl apply -f -
rm cni/values.yaml
rm -rf cni/charts
