# Git add, commit, and push all in one (assumes you are on master branch)

```sh
git add .
git commit -m "$1"
git push origin master
```

> You can then add this alias to `.zshrc`

```zsh
alias s='bash s.sh'
```