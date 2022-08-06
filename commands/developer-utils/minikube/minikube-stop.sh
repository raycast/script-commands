#!/bin/bash

# Dependency: This script requires `minikube` to be installed: https://minikube.sigs.k8s.io/docs/start/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Stop
# @raycast.mode compact
# @raycast.packageName Minikube

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Stops a running Minikube cluster
# @raycast.author Daniils Petrovs
# @raycast.authorURL https://danpetrov.xyz

if ! command -v minikube &> /dev/null; then
	echo "minikube is required (https://minikube.sigs.k8s.io).";
	exit 1;
fi

minikube stop

echo "Cluster stopped"
