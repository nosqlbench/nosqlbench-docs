# Dev Guide: Pull Requests

- use a name like nosqlbench-<issueno>-mnemonic
- expect feature branches for PRs to be deleted from origin on merge


- use merges rather than rebases
- If you don't know the build is green, leave the PR in draft mode until all checks are green.
- If you have done a full verify locally, it is ok to skip draft mode.
- verify locally in general
- ensure your up to date on main, and then make your feature branch from that
- If you have multiple kinds of changes in a feature branch for a PR, try to group them together 
  thematically in each commit, for easier review.
- If subsequent changes are merged to main, resolve any conflicts and push an update to the PR 
  branch.

