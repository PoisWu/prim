#! /bin/bash
set -e

bb=$(tput bold) || true
nn=$(tput sgr0) || true
green=$(tput setaf 2) || true

echo "${bb}Loading the latest tekton Dashboard... ${nn}"
kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/release.yaml

echo ""

echo "${bb}Waiting Tekton Dashboard pod... ${nn}"
kubectl wait --all pod --for=condition=Ready -n tekton-pipelines

echo "${bb}Forwarding tekton-dashboard service port to port 9097... ${nn}"
kubectl port-forward -n tekton-pipelines service/tekton-dashboard 9097:9097



