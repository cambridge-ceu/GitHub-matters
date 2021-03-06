## Git installation

```bash
wget -qO- https://github.com/git/git/archive/v2.30.0.tar.gz | tar xfz -
cd git-2.30.0
make NO_GETTEXT=YesPlease install
```
and the executables will be put to ~/bin.

## GitHub pages

This assumes use of jekyll-rtd-theme, e.g., rundocs-jekyll-rtd-theme-v2.0.10-2-ge897694.zip.
```bash
module load python/3.7
source py37/bin/activate
pip install sphinx
pip install recommonmark
npm install --save-dev --save-exact prettier
npm install -g npm
npm install -g webpack
wget -qO- https://cache.ruby-lang.org/pub/ruby/3.0/ruby-3.0.0.tar.gz | tar xvfz -
cd ruby-3.0.0
./configure --prefix=${HPC_WORK}
make
make install
source ~/.bashrc
gem install bundler
bundle install
# unzip rundocs-jekyll-rtd-theme-v2.0.10-2-ge897694.zip
# mv rundocs-jekyll-rtd-theme-v2.0.10-2-ge897694 docs
# cd docs
# make build
```
Without the theme above, we could use
```bash
mkdir docs
cd docs
/rds/user/${USER}/hpc-work/bin/jekyll new .
bundle update
# update Gemfile/_config.yml
```

## gitkraken

```bash
wget -qO- https://release.gitkraken.com/linux/gitkraken-amd64.tar.gz | \
tar xvfz -
echo /rds-d4/user/jhz22/hpc-work/gitkraken/gitkraken --no-sandbox $@ > gitkraken
chmod +x gitkraken
```

## Permission

In case there is confusion between cambridge-ceu repositories and your own, try these for the permission issues
```bash
ssh -vT git@github.com
ssh -T GitHub-username@github.com
git remote -v
git remote set-url origin https://github.com/cambridge-ceu/GitHub-matters.git
...
git push -f
```
For more details, see [here](https://help.github.com/en/github/using-git/changing-a-remotes-url).

## Pop-up windows

A window may pop up for password, which could cause problems with command-line interface but this can be disabled with
```bash
 unset SSH_ASKPASS
```
or `unset GIT_ASKPASS` which could be part of `.bashrc`. Alternatively, this could be achieved with disabling DISPLAY, i.e.,
```bash
DISPLAY=
git push
```

## Pull request

This is exemplified with TwoSampleMR. First create a branch with
```bash
git checkout -b jhz
```
As it uses roxygen, to export `get_se` add
```
#' @export
```
ahead of `get_se` in `query.R` and do the following,
```r
devtools::install_dev_deps()
devtools::document()
```
and commit the changes. A related change to `read_data.R` regards 
```r
if ( log_pval )
{
       dat$pval <- 10^-dat$pval
}
```
which should have been
```r
if ( log_pval )
{
       dat$pval <- 10^-dat[[pval]]
}
```
```bash
git add R/query.R
git commit -m "export get_se"
git add R/read_data.R
git commit -m "dat$pval <- 10^-dat[[pval]]"
git add NAMESPACE
git commit -m "export get_se"
git push --set-upstream origin jhz
```
making sure send a pull request from branch `jhz`.

Note also that to build TwoSampleMR on csd3, the following is necessary,
```
module load pandoc/2.0.6 pandoc-citeproc/0.12.2.2
```

## certification authority (CA)

An attempt to get away with the error message `Peer's Certificate issuer is not recognized.`
is as follows,

```bash
mkdir ~/certs
curl https://curl.haxx.se/ca/cacert.pem -o ~/certs/cacert.pem
git config --global http.sslCAinfo "$HOME/certs/cacert.pem"
```

or from R

```r
library(httr)
set_config(config(ssl_verifypeer = 0L))
```
