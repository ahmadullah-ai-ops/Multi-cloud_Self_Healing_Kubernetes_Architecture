#!/bin/sh
# simple helper: merge two kubeconfigs or set KUBECONFIG env var
# usage: ./kubecontext-switch.sh /path/to/eks_kubeconfig
export KUBECONFIG=$1
kubectl config get-contexts