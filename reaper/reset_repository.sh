#!/bin/bash
# This script resets the autolab-sandbox repository to a pristine, new state.

REPO_DIR=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)")
cd $REPO_DIR || exit 1

echo "Removing all non-default directories from the sandbox."
DIRECTORIES=$(find . -type d -maxdepth 1 -not -path "./.git*" -not -path "./templates" -not -path "./scripts" -not -path ".")
for DIR in $DIRECTORIES; do
  echo "[INFO] Deleting non-default directory $DIR."
  rm -rf "$DIR"
done

echo "[INFO] Restoring atlantis.yaml to default values."
rm -f atlantis.yaml
cp templates/atlantis.yaml atlantis.yaml
