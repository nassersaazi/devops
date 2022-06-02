# About Git

## Resources on git

[Advanced git concepts you should know](https://link.medium.com/qQuL5FV6wqb)<br>

[How to write a good commit message git](https://chris.beams.io/posts/git-commit/)<br>

[Contributing to complex projects](https://mitchellh.com/writing/contributing-to-complex-projects)<br>

[Understanding the Git workflow](https://sandofsky.com/workflow/git-workflow/)

[Pro Git](https://git-scm.com/book/en/v2)

[Generating SSH keys for git](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)<br>

[Difference between git log and git reflog](https://stackoverflow.com/questions/17857723/whats-the-difference-between-git-reflog-and-log)<br>

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
