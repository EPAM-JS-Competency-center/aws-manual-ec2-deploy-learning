#!/bin/bash

#configure paths
branch="master"
branch_dir="/var/www/node-app-deploy"
deploy_dir="$branch_dir/deploy"
all_versions_dir="$branch_dir/versions"
code_link="$branch_dir/code"
previous_links="$branch_dir/previous_links/"
deploy_date=$(date -u +%Y_%m_%d_T%H_%M_%S)
version_dir="$all_versions_dir/$deploy_date"

#pull from git
cd $deploy_dir
git fetch --all
git reset --hard origin/$branch
git pull origin $branch

#build
npm install
#npx eslint src/
#tsc
#npm run test
#migrate database

#deploy
mkdir $version_dir
rsync -a  --exclude=".git/" --exclude="src/"  $deploy_dir/ $version_dir/

#switch to a new version
cp -Pf $code_link $previous_links
ln -sf -T $version_dir $code_link

#start/restart app
cd $code_link
forever stopall
forever start app.js

