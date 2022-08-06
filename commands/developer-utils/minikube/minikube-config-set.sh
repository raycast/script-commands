#!/bin/bash

# Dependency: This script requires `minikube` to be installed: https://minikube.sigs.k8s.io/docs/start/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Config Set
# @raycast.mode compact
# @raycast.packageName Minikube

# Optional parameters:
# @raycast.icon ⚙️

# Documentation:
# @raycast.description Pause Minikube cluster
# @raycast.author Daniils Petrovs
# @raycast.authorURL https://danpetrov.xyz
# @raycast.argument1 { "type": "text", "placeholder": "property name" }
# @raycast.argument2 { "type": "text", "placeholder": "property value" }

if ! command -v minikube &> /dev/null; then
	echo "minikube is required (https://minikube.sigs.k8s.io).";
	exit 1;
fi

minikube config set "$1" "$2"

echo "Set $1 to $2"
