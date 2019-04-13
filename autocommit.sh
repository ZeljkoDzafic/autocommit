#!/bin/bash

# Autocommits chnages on git
# created due fact we have some old school devs
# that hate git and use only FTP


#variables and configuration

echo "### Autocommiter v0.1 ###"

test_location_dir="/var/www/deploy_to_test/"
project_dir="/home/developer/project_git_repo"

dt=$(date +"%Y-%m-%d")
branch_name="auto-commiter-$dt"
commit_message="Commiting changes to new branch $branch_name"


echo "Copying data from one test  location ($test_location_dir) to git directory ($project_dir)"

rsync -r $test_location_dir $project_dir

cd $project_dir


if [ -z "$(git status --porcelain)" ]; then
  # Working directory clean
  echo "Project $project_dir directory is clean";

else
  # Uncommitted changes
  echo "### Doing some git magic ###"
  git status
  git checkout -b $branch_name
  git add --all
  git commit -am "$commit_message"
  git push origin $branch_name:$branch_name
fi
