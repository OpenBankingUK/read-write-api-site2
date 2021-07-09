#!/usr/bin/env sh
# Instructions taken from: https://vuepress.vuejs.org/guide/deploy.html#github-pages

# abort on errors
set -e

# build
yarn docs:build

# navigate into the build output directory
cd docs/.vuepress/dist

# if you are deploying to a custom domain
# echo 'www.example.com' > CNAME

git init
git add -A
git commit -m 'deploy'

# if you are deploying to https://<USERNAME>.github.io
# git push -f git@github.com:<USERNAME>/<USERNAME>.github.io.git master

# if you are deploying to https://banaio.github.io/read-write-api-site2 or https://banaio.github.io/read-write-api-site2/
git push -f git@github.com:banaio/read-write-api-site2.git master:gh-pages

cd -
