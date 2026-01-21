#!/usr/bin/bash

#!/usr/bin/bash

function setup()
{
  export GIT_SSH_COMMAND="ssh -x"
  source ~/rds/software/py38/bin/activate
# pip install mkdocs-mermaid2-plugin
# pip install pymdown-extensions
  git rm --cached my_api
  git submodule add my_api
}

module load ceuadmin/libssh/0.10.6-icelake
module load ceuadmin/openssh/9.7p1-icelake
module load gettext/0.21/gcc/qnrcglqo
module load ceuadmin/krb5
module load libiconv/1.16/gcc/4miyzf3w

setup
mkdocs build
mkdocs gh-deploy

git add README.md
git commit -m "README"
git add .github
git commit -m ".github"
git add .gitignore
git commit -m ".gitignore"
git add docs
git commit -m "source"
git add mkdocs.yml
git commit -m "mkdocs.yml"
git push
