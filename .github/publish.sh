#!/usr/bin/env bash

set -e

cd $(dirname "$0")/..

mkdir pages
cd pages

echo '::group::Create and setup pages repo'
git init
cp ../.git/config ./.git/config

git config --local user.email "push@gha"
git config --local user.name "GHA"
echo '::endgroup::'

echo '::group::Checkout gh-pages'
git fetch
git checkout -b gh-pages origin/gh-pages
echo '::endgroup::'

echo '::group::Update content'
if [ ! -f .nojekyll ]; then
  touch .nojekyll
fi

if [ -z "$1" ]; then
  cp -vr ../dist/html5/* ./
  rm serve.sh
else
  mkdir -p doc/img
  mv ../doc/index.html doc
  cp ../doc/img/*.png ../doc/img/*.svg doc/img/
fi
echo '::endgroup::'

echo '::group::Add content'
git add .
echo '::endgroup::'

git diff --cached --exit-code && (
  echo '::group::Nothing to commit'
  git status
  echo '::endgroup::'
) || (
  echo '::group::Commit and push'
  git commit -am "update godot $GITHUB_SHA"
  git push -u origin +gh-pages
  echo '::endgroup::'
)
