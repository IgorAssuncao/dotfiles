#!/bin/bash

function decode_secret() {
  NAMESPACE=$1
  SECRET_NAME=$2

  kubectl -n $NAMESPACE get secrets $SECRET_NAME -o yaml | yq '. | .data |= with_entries(.value |= @base64d)'
}

function change_context() {
  echo "Current context: $(kubectl config current-context)"

  echo """Available contexts: 
  """

  available_contexts=($(cat ~/.kube/config | yq '.contexts[].name'))

  i=0
  for context in ${available_contexts[@]}; do
    echo "$i - $context"
    i=$((i+1))
  done

  echo ""
  read -p "Pick a context: " choice

  echo ""
  kubectl config use-context ${available_contexts[choice]}

  echo "Current context: $(kubectl config current-context)"
}

"$@"
