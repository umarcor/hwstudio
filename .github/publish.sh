#!/usr/bin/env sh

cd $(dirname "$0")/..

mkdir pages
cd pages

git init
cp ../.git/config ./.git/config

git fetch
git checkout -b gh-pages origin/gh-pages

if [ ! -f .nojekyll ]; then
  touch .nojekyll
fi

if [ -z "$1" ]; then
  cp -vr ../dist/html5/* ./
  rm serve.sh
else
  mkdir -p doc
  mv ../doc/index.html doc
  mkdir -p img
  cp ../img/icon.png img
fi

git add .

git config --local user.email "push@gha"
git config --local user.name "GHA"

git commit -am "update godot $GITHUB_SHA"

git push -u origin +gh-pages
