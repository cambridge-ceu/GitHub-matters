#!/usr/bin/bash

function github_only()
{
  git add .gitignore
  git commit -m ".gitignore"
  git add NOTES.md
  git commit -m "NOTES"
  git add README.md
  git commit -m "README"
  git add st.sh
  git commit -m "BATCH script"
  git push
}

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
git add README.md
git commit -m "README"
git push
