#!/bin/bash
# Archives master and resets key files for further cleaning

## Setting Atlantis to maintenance mode
touch /home/atlantis/.atlantis/.maintenance

# Ensuring we're in the correct repo directory
REPO_DIR=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)")
cd $REPO_DIR || exit 1

ARCHIVE_DATE=$(date +%Y-%m)

# Ensuring we have the latest copy of master for reaping
git fetch
git checkout --force master
git pull origin master

# Moving master into our work tree
git checkout -b "archive/$ARCHIVE_DATE"
git push -u origin "archive/$ARCHIVE_DATE"

git checkout master
git checkout -b "reaper/$ARCHIVE_DATE-work-path"

# Revering our templates and scripts in case anyone messed with them
git show reaper:reaper/reset_repository.sh > reaper/reset_repository.sh
git show reaper:reaper/wipe_projects.sh > reaper/wipe_projects.sh
git show reaper:templates/atlantis.yaml > templates/atlantis.yaml

echo "Work branch files reverted."

bash reaper/wipe_projects.sh
bash reaper/reset_repository.sh
