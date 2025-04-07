git_update_branch() {
  BRANCH=$(git rev-parse --abbrev-ref origin/HEAD | awk -F '/' '{ print $2 }')
  git checkout $BRANCH
  git pull
  git checkout -
  git rebase $BRANCH
}
