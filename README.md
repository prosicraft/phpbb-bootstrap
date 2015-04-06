# phpbb-Euphoria
## Bright, minimal and responsive theme for phpBB
based on prosilver, forked from phpbbstrap, heavily redone.  

### 1. Getting it into your repository
```git
$ git remote add -f phpbbeuphoria https://github.com/prosicraft/phpbb-euphoria.git
$ git checkout integrationBranch
$ git merge -s ours --no-commit phpbbeuphoria/master
$ git read-tree --prefix=styles/euphoria/ -u phpbbeuphoria/master
$ git commit -m "Add phpBBEuphoria style"
```
If you want to get a specific release, e.g. if you want version dev3.5, just use the specific tag, e.g. `euphoria-dev3.5` instead of `phpbbeuphoria/master`.

### 2. Updating it
This rebases all commits from the last update to the current state of phpbbeuphoria/master (run on your integration branch):
```git
$ git checkout integrationBranch
$ git fetch phpbbeuphoria
$ git merge -Xsubtree=styles/euphoria phpbbeuphoria/master
```
You can thereby make your own changes on the integration branch, revert commits from this repository or switch back to another version.

### 3. The branches
Development is done on the dev branches. When merging into master, the css files are rolled out and minified to provide resources that are as small as possible. If you have merged in from a dev branch, you might want to pack the css files on your own using the packtheme.sh script.