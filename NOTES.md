## Git installation

```bash
wget -qO- https://github.com/git/git/archive/v2.30.0.tar.gz | tar xfz -
cd git-2.30.0
make NO_GETTEXT=YesPlease install
```
and the executables will be put to ~/bin.

## gitkraken

```bash
wget -qO- https://release.gitkraken.com/linux/gitkraken-amd64.tar.gz | \
tar xvfz -
echo /rds-d4/user/jhz22/hpc-work/gitkraken/gitkraken --no-sandbox $@ > gitkraken
chmod +x gitkraken
```

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
