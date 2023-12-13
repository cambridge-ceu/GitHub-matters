#!/usr/bin/bash

function github_pages()
{
  module load python/3.8
  source ~/rds/public_databases/software/py38/bin/activate
}

function install()
{
  pip install mkdocs-mermaid2-plugin
}

github_pages
mkdocs build
mkdocs gh-deploy

git add .gitignore my_api
git add docs
git add mkdocs.yml
git commit -m "backup"
git push
