#!/usr/bin/env bash

pushd _site
git status
git add --all
git commit -m "Update (`date '+%F %T %Z'`) [ci skip]"
git push origin master
popd

git status
git add _site
git commit -m "Update _site (`date '+%F %T %Z'`) [ci skip]"
git push origin source
