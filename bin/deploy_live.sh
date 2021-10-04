#!/bin/bash

#configure paths
branch="master"
app_dir="/var/www/node-app-deploy"

cd $app_dir

#pull from git
git fetch --all
git reset --hard origin/$branch
git pull origin $branch

#build
npm install
#npx eslint src/
#tsc
#npm run test
#migrate database

#start/restart app
forever stopall
forever start app.js

