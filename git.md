About Git

`git reset --hard HEAD~1` - gets you back by one commit from the latest

`git remote add upstream forked-repo.git` - add an upstream of the original in case you have forked a repo

# Sync your fork
```
git fetch upstream
git checkout master
git merge upstream/master
```
`git add -p` - always use this command instead of `git add .`

`git checkout -b ＜new-branch＞` - create and switch to new branch<br>

`git config --global credential.helper cache` - configure credential caching

`git config --global --unset credential.helper cache` - clear the access token from the local computer<br>

`git branch -vv` - check branch tracking activity<br>

`git push -u origin branch-name` - set upstream remote branch
```
```
