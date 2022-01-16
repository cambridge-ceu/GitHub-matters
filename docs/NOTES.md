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

A specific plugin may also be installed, e.g., 

```bash
gem install jekyll-paginate
```

through which an appropriate version can be added to `Gemfile` followed by `bundle` above.

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

### ruby-install

By default, it is for root user and it is possible to do this locally,

```bash
mkdir -p $HOME/src
cd $HOME/src
wget -qO- ruby-install-0.8.3.tar.gz https://github.com/postmodern/ruby-install/archive/v0.8.3.tar.gz | \
tar -xzvf -
cd ruby-install-0.8.3/
PREFIX=${HPC_WORK} make install
ruby-install --latest --no-install-deps ruby
```

### rvm

Web: [https://rvm.io/](https://rvm.io/).

Ruby Version Manager (RVM) `is a command-line tool which allows you to easily install, manage, and work with multiple ruby environments from interpreters to sets of gems`.

```bash
curl -sSL https://get.rvm.io | bash -s stable --rails
```

Note that for various ways of ruby installations, one may encounter problems with `dtrace` 

```
linking miniruby
array.o: In function `empty_ary_alloc':
/home/jhz22/ruby-3.1.0/array.c:713: undefined reference to `ruby_array__create_semaphore'
array.o: In function `ary_new':
/home/jhz22/ruby-3.1.0/array.c:729: undefined reference to `ruby_array__create_semaphore'
/home/jhz22/ruby-3.1.0/array.c:729: undefined reference to `ruby_array__create_semaphore'
/home/jhz22/ruby-3.1.0/array.c:729: undefined reference to `ruby_array__create_semaphore'
array.o: In function `ec_ary_new':
/home/jhz22/ruby-3.1.0/array.c:817: undefined reference to `ruby_array__create_semaphore'
array.o:/home/jhz22/ruby-3.1.0/array.c:729: more undefined references to `ruby_array__create_semaphore' follow
eval.o: In function `setup_exception':
/home/jhz22/ruby-3.1.0/eval.c:618: undefined reference to `ruby_raise_semaphore'
eval.o:(.note.stapsdt+0x24): undefined reference to `ruby_raise_semaphore'
gc.o: In function `gc_prof_sweep_timer_start':
/home/jhz22/ruby-3.1.0/gc.c:12537: undefined reference to `ruby_gc__sweep__begin_semaphore'
gc.o: In function `gc_prof_sweep_timer_stop':
/home/jhz22/ruby-3.1.0/gc.c:12550: undefined reference to `ruby_gc__sweep__end_semaphore'
/home/jhz22/ruby-3.1.0/gc.c:12550: undefined reference to `ruby_gc__sweep__end_semaphore'
gc.o: In function `gc_prof_mark_timer_start':
/home/jhz22/ruby-3.1.0/gc.c:12514: undefined reference to `ruby_gc__mark__begin_semaphore'
gc.o: In function `gc_prof_mark_timer_stop':
/home/jhz22/ruby-3.1.0/gc.c:12525: undefined reference to `ruby_gc__mark__end_semaphore'
gc.o:(.note.stapsdt+0x24): undefined reference to `ruby_gc__sweep__end_semaphore'
gc.o:(.note.stapsdt+0x68): undefined reference to `ruby_gc__sweep__begin_semaphore'
gc.o:(.note.stapsdt+0xac): undefined reference to `ruby_gc__mark__end_semaphore'
gc.o:(.note.stapsdt+0xec): undefined reference to `ruby_gc__mark__begin_semaphore'
hash.o: In function `empty_hash_alloc':
/home/jhz22/ruby-3.1.0/hash.c:1542: undefined reference to `ruby_hash__create_semaphore'
hash.o:(.note.stapsdt+0x24): undefined reference to `ruby_hash__create_semaphore'
load.o: In function `rb_f_load':
/home/jhz22/ruby-3.1.0/load.c:784: undefined reference to `ruby_load__entry_semaphore'
/home/jhz22/ruby-3.1.0/load.c:794: undefined reference to `ruby_load__return_semaphore'
load.o: In function `require_internal':
/home/jhz22/ruby-3.1.0/load.c:1103: undefined reference to `ruby_require__entry_semaphore'
/home/jhz22/ruby-3.1.0/load.c:1113: undefined reference to `ruby_find__require__entry_semaphore'
/home/jhz22/ruby-3.1.0/load.c:1115: undefined reference to `ruby_find__require__return_semaphore'
/home/jhz22/ruby-3.1.0/load.c:1115: undefined reference to `ruby_find__require__return_semaphore'
/home/jhz22/ruby-3.1.0/load.c:1189: undefined reference to `ruby_require__return_semaphore'
/home/jhz22/ruby-3.1.0/load.c:1115: undefined reference to `ruby_find__require__return_semaphore'
load.o:(.note.stapsdt+0x24): undefined reference to `ruby_load__entry_semaphore'
load.o:(.note.stapsdt+0x7c): undefined reference to `ruby_load__return_semaphore'
load.o:(.note.stapsdt+0xd4): undefined reference to `ruby_require__entry_semaphore'
load.o:(.note.stapsdt+0x138): undefined reference to `ruby_find__require__entry_semaphore'
load.o:(.note.stapsdt+0x1a4): undefined reference to `ruby_find__require__return_semaphore'
load.o:(.note.stapsdt+0x210): undefined reference to `ruby_require__return_semaphore'
object.o: In function `class_call_alloc_func':
/home/jhz22/ruby-3.1.0/object.c:1958: undefined reference to `ruby_object__create_semaphore'
object.o:(.note.stapsdt+0x24): undefined reference to `ruby_object__create_semaphore'
parse.o: In function `yycompile0':
/home/jhz22/ruby-3.1.0/parse.y:6348: undefined reference to `ruby_parse__begin_semaphore'
/home/jhz22/ruby-3.1.0/parse.y:6350: undefined reference to `ruby_parse__end_semaphore'
parse.o:(.note.stapsdt+0x24): undefined reference to `ruby_parse__end_semaphore'
parse.o:(.note.stapsdt+0x7c): undefined reference to `ruby_parse__begin_semaphore'
string.o: In function `empty_str_alloc':
/home/jhz22/ruby-3.1.0/string.c:870: undefined reference to `ruby_string__create_semaphore'
string.o: In function `str_new0':
/home/jhz22/ruby-3.1.0/string.c:885: undefined reference to `ruby_string__create_semaphore'
/home/jhz22/ruby-3.1.0/string.c:885: undefined reference to `ruby_string__create_semaphore'
string.o: In function `str_new_static':
/home/jhz22/ruby-3.1.0/string.c:1003: undefined reference to `ruby_string__create_semaphore'
string.o: In function `rb_str_resurrect':
/home/jhz22/ruby-3.1.0/string.c:1816: undefined reference to `ruby_string__create_semaphore'
string.o:/home/jhz22/ruby-3.1.0/string.c:1823: more undefined references to `ruby_string__create_semaphore' follow
symbol.o: In function `dsymbol_alloc':
/home/jhz22/ruby-3.1.0/symbol.c:622: undefined reference to `ruby_symbol__create_semaphore'
symbol.o: In function `register_static_symid_str':
/home/jhz22/ruby-3.1.0/symbol.c:550: undefined reference to `ruby_symbol__create_semaphore'
symbol.o:(.note.stapsdt+0x24): undefined reference to `ruby_symbol__create_semaphore'
symbol.o:(.note.stapsdt+0x80): undefined reference to `ruby_symbol__create_semaphore'
vm.o: In function `vm_call_cfunc_with_frame':
/home/jhz22/ruby-3.1.0/vm_insnhelper.c:3027: undefined reference to `ruby_cmethod__entry_semaphore'
/home/jhz22/ruby-3.1.0/vm_insnhelper.c:3044: undefined reference to `ruby_cmethod__return_semaphore'
vm.o: In function `vm_dtrace':
/home/jhz22/ruby-3.1.0/vm_insnhelper.c:4432: undefined reference to `ruby_method__entry_semaphore'
/home/jhz22/ruby-3.1.0/vm_insnhelper.c:4432: undefined reference to `ruby_method__return_semaphore'
/home/jhz22/ruby-3.1.0/vm_insnhelper.c:4433: undefined reference to `ruby_cmethod__entry_semaphore'
/home/jhz22/ruby-3.1.0/vm_insnhelper.c:4434: undefined reference to `ruby_cmethod__return_semaphore'
/home/jhz22/ruby-3.1.0/vm_insnhelper.c:4448: undefined reference to `ruby_cmethod__return_semaphore'
/home/jhz22/ruby-3.1.0/vm_insnhelper.c:4445: undefined reference to `ruby_method__return_semaphore'
/home/jhz22/ruby-3.1.0/vm_insnhelper.c:4442: undefined reference to `ruby_cmethod__entry_semaphore'
vm.o: In function `rb_vm_pop_cfunc_frame':
/home/jhz22/ruby-3.1.0/vm.c:667: undefined reference to `ruby_cmethod__return_semaphore'
/home/jhz22/ruby-3.1.0/vm.c:667: undefined reference to `ruby_cmethod__return_semaphore'
vm.o: In function `hook_before_rewind':
/home/jhz22/ruby-3.1.0/vm.c:2051: undefined reference to `ruby_method__return_semaphore'
vm.o: In function `vm_exec_handle_exception':
/home/jhz22/ruby-3.1.0/vm.c:2257: undefined reference to `ruby_cmethod__return_semaphore'
vm.o: In function `vm_call0_cfunc_with_frame':
/home/jhz22/ruby-3.1.0/vm_eval.c:138: undefined reference to `ruby_cmethod__entry_semaphore'
/home/jhz22/ruby-3.1.0/vm_eval.c:155: undefined reference to `ruby_cmethod__return_semaphore'
vm.o: In function `vm_exec_core':
/home/jhz22/ruby-3.1.0/insns.def:462: undefined reference to `ruby_array__create_semaphore'
/home/jhz22/ruby-3.1.0/insns.def:473: undefined reference to `ruby_hash__create_semaphore'
/home/jhz22/ruby-3.1.0/insns.def:528: undefined reference to `ruby_hash__create_semaphore'
vm.o:(.note.stapsdt+0x24): undefined reference to `ruby_cmethod__entry_semaphore'
vm.o:(.note.stapsdt+0x94): undefined reference to `ruby_cmethod__return_semaphore'
vm.o:(.note.stapsdt+0x104): undefined reference to `ruby_cmethod__return_semaphore'
vm.o:(.note.stapsdt+0x174): undefined reference to `ruby_method__entry_semaphore'
vm.o:(.note.stapsdt+0x1e0): undefined reference to `ruby_method__return_semaphore'
vm.o:(.note.stapsdt+0x250): undefined reference to `ruby_cmethod__entry_semaphore'
vm.o:(.note.stapsdt+0x2c0): undefined reference to `ruby_cmethod__return_semaphore'
vm.o:(.note.stapsdt+0x330): undefined reference to `ruby_method__return_semaphore'
vm.o:(.note.stapsdt+0x3a0): undefined reference to `ruby_cmethod__return_semaphore'
vm.o:(.note.stapsdt+0x418): undefined reference to `ruby_cmethod__return_semaphore'
vm.o:(.note.stapsdt+0x48c): undefined reference to `ruby_cmethod__entry_semaphore'
vm.o:(.note.stapsdt+0x4fc): undefined reference to `ruby_array__create_semaphore'
vm.o:(.note.stapsdt+0x558): undefined reference to `ruby_hash__create_semaphore'
vm.o:(.note.stapsdt+0x5b0): undefined reference to `ruby_hash__create_semaphore'
yjit.o: In function `full_cfunc_return':
/home/jhz22/ruby-3.1.0/yjit_codegen.c:504: undefined reference to `ruby_cmethod__return_semaphore'
yjit.o:(.note.stapsdt+0x24): undefined reference to `ruby_cmethod__return_semaphore'
collect2: error: ld returned 1 exit status
make: *** [miniruby] Error 1
```

To get around one can use

```bash
configure --disable-dtrace --enable-shared --prefix=${HPC_WORK}
make
make install
```

Some details are described at [here](https://udzura.hatenablog.jp/entry/2021/03/02/180234).

Finally, one can modify ext/Setup by uncommenting various options such as `openssl`, `readline`, `zlib` there, and also

```bash
configure --disable-dtrace --enable-shared --with-openssl --with-openssl-dir=${HPC_WORK}/openssl-1.1.1h --prefix=${HPC_WORK}
make
make install
```

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

Equally, there might be problem to remove your own file, e.g., `rm: cannot remove 'urls.txt': Permission denied`, which can be resolved with resetting parent directory, i.e., `chmod -R 777 v4`.

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

## REST API

Representational State Transfer (REST) allows for various operations on repositories, see [https://docs.github.com/en/rest](https://docs.github.com/en/rest).

Example uses involve the [cambridge-ceu](https://cambridge-ceu.github.io/) site information with curl, [https://curl.se/](https://curl.se/):

```bash
curl --version
curl https://api.github.com/ | jq
curl https://api.github.com/users/cambridge-ceu
curl https://api.github.com/users/cambridge-ceu/repos
curl https://api.github.com/users/cambridge-ceu/repos\?sort\=pushed
curl -X POST https://api.github.com/user/repos -i
```

Where `jq` is the command-line JavaScript Object Notation (JSON) processor.

Some more useful examples are as follows,

```bash
curl -X GET https://www.ebi.ac.uk/eqtl/api/studies | jq
curl -X GET https://www.ebi.ac.uk/eqtl/api/associations?variant_id=rs12075 > rs12075.json
curl -X GET https://www.ebi.ac.uk/eqtl/api/associations?variant_id=rs12075&study=Alasoo
curl -X 'POST' \
  'https://api.epigraphdb.org/protein/ppi' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "uniprot_id_list": [
    "O14625", "P13500"
  ]
}' | jq
```

Other examples relate to an implementation in [epigraphdb](https://api.epigraphdb.org/) and [catalogueR](https://rajlabmssm.github.io/catalogueR/), e.g.,

```r
options(width=150)
data.frame(epigraphdb::mr(outcome_trait = "Multiple sclerosis", pval_threshold = 1e-8))
library(catalogueR)
qtl.subset1 <- fetch_restAPI(unique_id=meta$unique_id[1], gwas_data=BST1)
qtl.subset2 <- fetch_tabix(unique_id=meta$unique_id[2], gwas_data=BST1)
```

where the last two statements wrap up the following lines,

```
http://www.ebi.ac.uk/eqtl/api/chromosomes/4/associations?paginate=False&study=Alasoo_2018&qtl_group=macrophage_naive&quant_method=ge&bp_lower=14737349&bp_upper=16737284
tabix ftp://ftp.ebi.ac.uk/pub/databases/spot/eQTL/csv/Alasoo_2018/ge/Alasoo_2018_ge_macrophage_naive.all.tsv.gz 4:14737349-16737284
```

respectively.

We carry on to postprocess the output above,

```r
rs12075 <- jsonlite::fromJSON("rs12075.json")
link <- rs12075$`_links`$`next`$href
result <- do.call(rbind, lapply(rs12075$`_embedded`$associations, rbind))
```

and the results are as follows,

```
> link
[1] "http://www.ebi.ac.uk/eqtl/api/associations?size=20&start=20&links=False&variant_id=rs12075"
> result
      beta        maf      type  neg_log10_pvalue median_tpm pvalue   ref rsid      chromosome position  alt se        r2      ac
 [1,] 0.0103601   0.458333 "SNP" 0.1120341        0.6        0.77262  "G" "rs12075" "1"        159205564 "A" 0.0357159 0.99927 91
 [2,] 0.10655     0.458333 "SNP" 0.5001521        1.513      0.316117 "G" "rs12075" "1"        159205564 "A" 0.105527  0.99927 91
 [3,] 0.00471216  0.458333 "SNP" 0.02100965       5.229      0.952775 "G" "rs12075" "1"        159205564 "A" 0.0792819 0.99927 91
 [4,] 0.103534    0.458333 "SNP" 0.4388091        2.34       0.364075 "G" "rs12075" "1"        159205564 "A" 0.113328  0.99927 91
 [5,] 0.0322011   0.458333 "SNP" 0.1128161        0.827      0.77123  "G" "rs12075" "1"        159205564 "A" 0.110317  0.99927 91
 [6,] 0.0434981   0.458333 "SNP" 0.7434626        288.439    0.180525 "G" "rs12075" "1"        159205564 "A" 0.032158  0.99927 91
 [7,] -0.0241876  0.458333 "SNP" 0.5827094        195.988    0.261391 "G" "rs12075" "1"        159205564 "A" 0.0213623 0.99927 91
 [8,] -0.141131   0.458333 "SNP" 0.5962517        16.849     0.253366 "G" "rs12075" "1"        159205564 "A" 0.122543  0.99927 91
 [9,] 0.245207    0.458333 "SNP" 0.7806198        0.345      0.165722 "G" "rs12075" "1"        159205564 "A" 0.175061  0.99927 91
[10,] -0.0559002  0.458333 "SNP" 0.7160569        79.94      0.192284 "G" "rs12075" "1"        159205564 "A" 0.0424596 0.99927 91
[11,] -0.00890871 0.458333 "SNP" 0.0812611        991.08     0.829352 "G" "rs12075" "1"        159205564 "A" 0.0411791 0.99927 91
[12,] 0.0319441   0.458333 "SNP" 0.07365961       30.138     0.843996 "G" "rs12075" "1"        159205564 "A" 0.161729  0.99927 91
[13,] 0.0572641   0.458333 "SNP" 0.1638298        0.176      0.685757 "G" "rs12075" "1"        159205564 "A" 0.140938  0.99927 91
[14,] -0.00221514 0.458333 "SNP" 0.02556661       105.229    0.94283  "G" "rs12075" "1"        159205564 "A" 0.030778  0.99927 91
[15,] 0.148251    0.458333 "SNP" 0.85642          165.336    0.139181 "G" "rs12075" "1"        159205564 "A" 0.0991063 0.99927 91
[16,] -0.0631594  0.458333 "SNP" 0.1534025        0.089      0.702421 "G" "rs12075" "1"        159205564 "A" 0.16464   0.99927 91
[17,] 0.0820197   0.458333 "SNP" 0.4129235        0.048      0.386435 "G" "rs12075" "1"        159205564 "A" 0.0941081 0.99927 91
[18,] 0.130461    0.458333 "SNP" 0.7431741        0.559      0.180645 "G" "rs12075" "1"        159205564 "A" 0.0964765 0.99927 91
[19,] 0.0136613   0.458333 "SNP" 0.06425197       0.122      0.862478 "G" "rs12075" "1"        159205564 "A" 0.0785769 0.99927 91
[20,] -0.0935604  0.458333 "SNP" 0.6328566        0.6        0.232886 "G" "rs12075" "1"        159205564 "A" 0.0777485 0.99927 91
      variant              an  study_id      qtl_group         molecular_trait_id gene_id           tissue
 [1,] "chr1_159205564_G_A" 168 "Alasoo_2018" "macrophage_IFNg" "ENSG00000143315"  "ENSG00000143315" "CL_0000235"
 [2,] "chr1_159205564_G_A" 168 "Alasoo_2018" "macrophage_IFNg" "ENSG00000158477"  "ENSG00000158477" "CL_0000235"
 [3,] "chr1_159205564_G_A" 168 "Alasoo_2018" "macrophage_IFNg" "ENSG00000158481"  "ENSG00000158481" "CL_0000235"
 [4,] "chr1_159205564_G_A" 168 "Alasoo_2018" "macrophage_IFNg" "ENSG00000158485"  "ENSG00000158485" "CL_0000235"
 [5,] "chr1_159205564_G_A" 168 "Alasoo_2018" "macrophage_IFNg" "ENSG00000158488"  "ENSG00000158488" "CL_0000235"
 [6,] "chr1_159205564_G_A" 168 "Alasoo_2018" "macrophage_IFNg" "ENSG00000158710"  "ENSG00000158710" "CL_0000235"
 [7,] "chr1_159205564_G_A" 168 "Alasoo_2018" "macrophage_IFNg" "ENSG00000158714"  "ENSG00000158714" "CL_0000235"
 [8,] "chr1_159205564_G_A" 168 "Alasoo_2018" "macrophage_IFNg" "ENSG00000158716"  "ENSG00000158716" "CL_0000235"
 [9,] "chr1_159205564_G_A" 168 "Alasoo_2018" "macrophage_IFNg" "ENSG00000162706"  "ENSG00000162706" "CL_0000235"
[10,] "chr1_159205564_G_A" 168 "Alasoo_2018" "macrophage_IFNg" "ENSG00000162729"  "ENSG00000162729" "CL_0000235"
[11,] "chr1_159205564_G_A" 168 "Alasoo_2018" "macrophage_IFNg" "ENSG00000162734"  "ENSG00000162734" "CL_0000235"
[12,] "chr1_159205564_G_A" 168 "Alasoo_2018" "macrophage_IFNg" "ENSG00000163563"  "ENSG00000163563" "CL_0000235"
[13,] "chr1_159205564_G_A" 168 "Alasoo_2018" "macrophage_IFNg" "ENSG00000163564"  "ENSG00000163564" "CL_0000235"
[14,] "chr1_159205564_G_A" 168 "Alasoo_2018" "macrophage_IFNg" "ENSG00000163565"  "ENSG00000163565" "CL_0000235"
[15,] "chr1_159205564_G_A" 168 "Alasoo_2018" "macrophage_IFNg" "ENSG00000163568"  "ENSG00000163568" "CL_0000235"
[16,] "chr1_159205564_G_A" 168 "Alasoo_2018" "macrophage_IFNg" "ENSG00000177807"  "ENSG00000177807" "CL_0000235"
[17,] "chr1_159205564_G_A" 168 "Alasoo_2018" "macrophage_IFNg" "ENSG00000181036"  "ENSG00000181036" "CL_0000235"
[18,] "chr1_159205564_G_A" 168 "Alasoo_2018" "macrophage_IFNg" "ENSG00000213085"  "ENSG00000213085" "CL_0000235"
[19,] "chr1_159205564_G_A" 168 "Alasoo_2018" "macrophage_IFNg" "ENSG00000256029"  "ENSG00000256029" "CL_0000235"
[20,] "chr1_159205564_G_A" 168 "Alasoo_2018" "macrophage_IFNg" "ENSG00000143315"  "ENSG00000143315" "CL_0000235"
>
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