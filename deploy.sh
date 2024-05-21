#!/bin/bash

echo "Deploying Paul's K3S HomeLab"
# Load environment variables from .env file
export $(grep -v '^#' .env | xargs)

# Substitute environment variables in YAML files
for file in cert-manager/*.yaml ingress/*.yaml metallb/*.yaml paperless/*.yaml duckdns/*.yaml; do
  echo "Substituting environment variables in $file"
  envsubst <$file >/tmp/$(basename $file)
done

Deploy with Helm using the substituted YAML files
helm upgrade --install cert-manager /tmp/cert-manager
helm upgrade --install ingress /tmp/ingress
helm upgrade --install metallb /tmp/metallb
helm upgrade --install paperless /tmp/paperless
helm upgrade --install duckdns /tmp/duckdns
