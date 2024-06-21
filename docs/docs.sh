#!/usr/bin/bash

function github_pages()
{
  module load python/3.8
  source ~/rds/public_databases/software/py38/bin/activate
# pip install pymdown-extensions
}

function install()
{
  pip install mkdocs-mermaid2-plugin
}

function my_api()
{
  git rm --cached my_api
  git submodule add my_api
}

github_pages
mkdocs build
mkdocs gh-deploy

if [ "$(uname -n | sed 's/-[0-9]*$//')" == "login-q" ]; then
   echo icelake
   module load ceuadmin/openssh/9.7p1-icelake
   module load ceuadmin/libssh/0.10.6-icelake
fi

git add .gitignore
git add docs my_api
git add mkdocs.yml
git commit -m "backup"
git push
