This is my personal vim setup using [git submodule based pathogen](http://usevim.com/2012/03/01/using-pathogen-with-git-submodules/) to manage a subset of resources in [spf13-vim](https://github.com/spf13/spf13-vim), to use a smaller bundle collection and manual upgrade.

To use
```sh
git clone git@github.com:thinkingfish/dotvim.git ~/.vim
cd ~/.vim
git submodule init
git submodule update
./setup.sh
```

To add a module
```sh
GIT_REPO_URL=<repo_url> MODULE=<module>
git submodule add $GIT_REPO_URL bundle/$MODULE
git commit -m 'Added $MODULE'
git push
```
