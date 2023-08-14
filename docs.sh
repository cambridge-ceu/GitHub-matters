#!/usr/bin/bash

function github_pages()
{
  module load python/3.7
  source ~/COVID-19/py37/bin/activate
}

function install()
{
  pip install mkdocs-mermaid2-plugin
}

github_pages
mkdocs build
mkdocs gh-deploy

git add .gitignore
git add docs
git add mkdocs.yml
git commit -m "backup"
git push
