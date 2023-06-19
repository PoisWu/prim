#! /bin/bash

set -e

bb=$(tput bold) || true
nn=$(tput sgr0) || true
green=$(tput setaf 2) || true

# generate-key
echo "${bb}Generating private key...${nn}"
cosign generate-key-pair k8s://tekton-chains/signing-secrets

# config chains
echo "${bb}Configuring Tekton Chain...${nn}"
kubectl patch configmap chains-config -n tekton-chains -p='{"data":{"artifacts.taskrun.format": "in-toto"}}'
kubectl patch configmap chains-config -n tekton-chains -p='{"data":{"artifacts.taskrun.storage": "oci"}}'
kubectl patch configmap chains-config -n tekton-chains -p='{"data":{"transparency.enabled": "true"}}'

echo ""

echo "${bb}Loading 3 Tasks: git-clone, buildpacks and buildpacks-phases...${nn}"
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.9/git-clone.yaml
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/buildpacks/0.5/buildpacks.yaml
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/buildpacks-phases/0.2/buildpacks-phases.yaml

echo ""

echo "${bb}Loading a Pipeline : buildpacks${nn}"
kubectl apply -f pipeline-buildpacks.yaml

