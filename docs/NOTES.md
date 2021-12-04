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
wget -qO- https://cache.ruby-lang.org/pub/ruby/3.0/ruby-3.0.2.tar.gz | tar xvfz -
cd ruby-3.0.2
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
When there is a conflict with `Gemfile`, we could use
```bash
mkdir docs
cd docs
/rds/user/${USER}/hpc-work/bin/jekyll new .
bundle update
# update Gemfile/_config.yml
```

Consider [YAML Validator](https://codebeautify.org/yaml-validator) and [data files](https://jekyllrb.com/docs/datafiles/).

To generate a site map, follow these steps with jekyll/minima theme,

1. Add gem "jekyll-sitemap" to the plugin_groups of `Gemfile`.
2. Add `- jekyll-sitemap` to the plugins of `_config.yml`.
3. Modify `assets/css/style.scss` -- uncomment the default such that
```
@import
  "minima/skins/{{ site.minima.skin | default: 'classic' }}",
  "minima/initialize";
```

and `cp -r ../../_sass/minima .`, then we have the file `sitemap.xml`.

One may attempt to enable Google search, e.g., [the post here](https://victor2code.github.io/blog/2019/07/04/jekyll-github-pages-appear-on-Google.html).

The banner at cambridge-ceu.github.io is created as follows,

- Visit [curtsy-alice-alice-in-wonderland-disney.gif](https://tenor.com/view/curtsy-alice-alice-in-wonderland-disney-gif-4946558).
- Select **CAPTION** at the bottom of the image, enter text with a customised color, and **CREATE GIF**.
- Crop the gif via [https://onlinegiftools.com/crop-gif](https://onlinegiftools.com/crop-gif) and embed it in the page.

## gitkraken

```bash
cd ${HPC_WORK}
wget -qO- https://release.gitkraken.com/linux/gitkraken-amd64.tar.gz | \
tar xvfz -
cd bin
echo ${HPC_WORK}/gitkraken/gitkraken --no-sandbox $@ > gitkraken
chmod +x gitkraken
```

## Permissions

It may happen that you cannot enter your own directory: `cd: v4: Permission denied`, then it is fixed with

```bash
chmod u+rx,go-w v4
```

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

## ssh

The use of ssh involves several steps,

1. Generate private and public keys via ssh-keygen.
2. Paste the public key into your GitHub account profile.
3. Replace the url address at the .git/config locally with the repository address from its Code section (i.e., `git@github.com:<username>`/`<repositoryname>.git`).

This should enable code updates without request for the access token.
