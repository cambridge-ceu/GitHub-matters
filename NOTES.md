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

To use cambridge-ceu repositories, try these in case of permission issues

ssh -vT git@github.com
ssh -T GitHub-username@github.com
git remote -v
git remote set-url origin https://github.com/cambridge-ceu/csd3.git
