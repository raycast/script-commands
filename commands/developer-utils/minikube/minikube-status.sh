#!/bin/bash

# Dependency: This script requires `minikube` to be installed: https://minikube.sigs.k8s.io/docs/start/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Status
# @raycast.mode fullOutput
# @raycast.packageName Minikube

# Optional parameters:
# @raycast.icon ℹ️

# Documentation:
# @raycast.description Show Minikube cluster status
# @raycast.author Daniils Petrovs
# @raycast.authorURL https://danpetrov.xyz

if ! command -v minikube &> /dev/null; then
	echo "minikube is required (https://minikube.sigs.k8s.io).";
	exit 1;
fi

minikube status
