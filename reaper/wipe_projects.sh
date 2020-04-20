#!/bin/bash
# Deletes all existing resources from master

REPO_DIR=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)")
cd $REPO_DIR || exit 1

echo "Identifying candidate projects for deletion."
CANDIDATES=$(grep 'dir:' atlantis.yaml | cut -d: -f2 | sed 's/^[[:space:]]//')
for CANDIDATE in $CANDIDATES; do
  echo "[INFO] Identified project $CANDIDATE as deletion target."
  if [[ -d "$CANDIDATE" ]]; then
    echo "  - Beginning deletion process for $CANDIDATE."
    ENV_PLACEHOLDER=true terraform init
    INIT_EXIT=$?
    if [[ "$INIT_EXIT" == 0 ]]; then
      echo "  - Terraform successfully initialized."
      ENV_PLACEHOLDER=true terraform destroy --auto-approve
    else
      echo "  - [ERROR] Terraform initlization failed."
    fi
  else
    echo "  - $CANDIDATE does not to exist in the codebase. Skipping."
  fi
done
