#! /bin/bash
set -e

bb=$(tput bold) || true
nn=$(tput sgr0) || true
green=$(tput setaf 2) || true


# pipeline
echo "${bb}Loading the latest tekton pipeline... ${nn}"
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml


# Chaine 
echo "${bb}Loading the tekton chain v0.14.0... ${nn}"
kubectl apply --filename https://storage.googleapis.com/tekton-releases/chains/previous/v0.14.0/release.yaml

echo "${green}Loading tekton completed.${nn}"

