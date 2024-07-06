---
"lang": "en",
"title": "Resolving incorrect rebase in Git",
"subtitle": "Reflogging tangled merge conflicts",
"description": "Reflog reset in Git"
---

While working in a downstream (forked) Git repository, you might get merge conflicts in your remote origin, resulting from interactively rebasing to a wrong HEAD. In most cases, you can fix the problem by reverting to the last clean commit, and then push further modifications to the remote. However, the situation becomes tricky when the working commit has been squashed, and the squashed commit has been pushed to the remote. To restore the local and the remote to a conflict-free state, execute the steps in the example below:

1. Staring with the current HEAD, check the number of steps that git has performed since the last conflict-free commit.
```
$ git reflog
```

Sample output:
```
c0599683b (HEAD -> rhdevdocs_1860, origin/rhdevdocs_1860) HEAD@{0}: commit: Testing if merge conflict is resolved
8a1a732e2 HEAD@{1}: checkout: moving from master to rhdevdocs_1860
cc4e5c27d (upstream/master, origin/master, origin/HEAD, master) HEAD@{2}: checkout: moving from rhdevdocs_1860 to master
8a1a732e2 HEAD@{3}: revert: Revert "Updaing documentation based on https://github.com/openshift/pipelines-tutorial/pull/138/files"
e7041c559 HEAD@{4}: checkout: moving from 62db5137c5544aaa6f8aac7981a14f811022abde to rhdevdocs_1860
62db5137c HEAD@{5}: checkout: moving from rhdevdocs_1860 to HEAD@{31}
e7041c559 HEAD@{6}: rebase (finish): returning to refs/heads/rhdevdocs_1860
e7041c559 HEAD@{7}: rebase (squash): Modifying Creating CI/CD Pipelines based on revised tutorial
0098ed517 HEAD@{8}: rebase (squash): # This is a combination of 2 commits.
28cc6ba1d HEAD@{9}: rebase (start): checkout HEAD~3
ac155afe6 HEAD@{10}: commit: Remove - Dummy modification to clean commits.
3a22b8f93 HEAD@{11}: commit: Remove - Dummy modification to clean commits.
28cc6ba1d HEAD@{12}: checkout: moving from master to rhdevdocs_1860
cc4e5c27d (upstream/master, origin/master, origin/HEAD, master) HEAD@{13}: rebase (finish): returning to refs/heads/master
cc4e5c27d (upstream/master, origin/master, origin/HEAD, master) HEAD@{14}: rebase (start): checkout upstream/master
a6f1c54c0 HEAD@{15}: checkout: moving from rhdevdocs_1860 to master
28cc6ba1d HEAD@{16}: rebase (finish): returning to refs/heads/rhdevdocs_1860
28cc6ba1d HEAD@{17}: rebase (squash): Modifying Creating CI/CD Pipelines based on revised tutorial
2a264c090 HEAD@{18}: rebase (start): checkout HEAD~2
d4ed242c3 HEAD@{19}: rebase (finish): returning to refs/heads/rhdevdocs_1860
d4ed242c3 HEAD@{20}: rebase (pick): Resolving ore comments from Pavol
2a264c090 HEAD@{21}: rebase (pick): Modifying Creating CI/CD Pipelines based on revised tutorial
5dc9f5d45 HEAD@{22}: rebase (pick): Bug 1871802: customer feedback to make yaml filename consistent
c9c275b1e HEAD@{23}: rebase (pick): OSDOCS-1168 vSphere IPI in restricted networks
78eb32971 HEAD@{24}: rebase (pick): updated OKD distros
7feeb412a HEAD@{25}: rebase (pick): These changes address BZ185249, which detailed a missing template parameter for generating non-alphabetical symbols.
688387054 HEAD@{26}: rebase (pick): GitHub issue-28150/issue-29904 update PVC command for registry
146fa0a5f HEAD@{27}: rebase (pick): Removes MTU network link
967129887 HEAD@{28}: rebase (start): checkout HEAD~8
0e0750317 HEAD@{29}: rebase (finish): returning to refs/heads/rhdevdocs_1860
0e0750317 HEAD@{30}: rebase (start): checkout HEAD~2
0e0750317 HEAD@{31}: commit: Resolving ore comments from Pavol
671b9466b HEAD@{32}: rebase (finish): returning to refs/heads/rhdevdocs_1860
671b9466b HEAD@{33}: rebase (squash): Modifying Creating CI/CD Pipelines based on revised tutorial
2b58efa69 HEAD@{34}: rebase (squash): # This is a combination of 3 commits.
d0692e73f HEAD@{35}: rebase (squash): # This is a combination of 2 commits.
4d5aa1d81 HEAD@{36}: rebase (start): checkout HEAD~4
62db5137c HEAD@{37}: commit: Updaing documentation based on https://github.com/openshift/pipelines-tutorial/pull/138/files
6782bebf2 HEAD@{38}: commit: Resolving comments from Pavol and Preeti
d61ec1e41 HEAD@{39}: commit: Testing if links work with substitution in the preview builds.
4d5aa1d81 HEAD@{40}: checkout: moving from master to rhdevdocs_1860
a6f1c54c0 HEAD@{41}: rebase (finish): returning to refs/heads/master
a6f1c54c0 HEAD@{42}: rebase (start): checkout upstream/master
627719037 HEAD@{43}: checkout: moving from rhdevdocs_1860 to master

```
In the above output, the problem created by rebasing to wrong head is revealed in the lines containing `HEAD@{22}` to `HEAD@{28}`. In fact, it is the step containing `HEAD@{28}` where I messed up by rebasing my HEAD to a commit made by someone else in the upstream. 

However, the point at which everything was conflict-free is indicated in the line containing `62db5137c HEAD@{37}: commit: Updaing documentation based on https://github.com/openshift/pipelines-tutorial/pull/138/files`. This is where I want my HEAD to be, and I also want all subsequent changes to be discarded.

2. Reset the HEAD to the point where everything was working:
```
$ git reset --hard HEAD@{37}

```

Sample output:
```
HEAD is now at 62db5137c Updaing documentation based on https://github.com/openshift/pipelines-tutorial/pull/138/files`

```

3. Make further changes in any of the local files.

4. Stage the files and commit them:
```
$ git add .
$ git commit -m "Testing if merge conflict is resolved by hard resetting head from the result of reflog."
```

5. Force push the commit to the remote origin:
```
git push origin rhdevdocs_1860 -f
```

6. Check the remote to see if the conflict is resolved. If everything works well, you should see a message like this:
```
All checks have passed
1 successful check

This branch has no conflicts with the base branch
Only those with write access to this repository can merge pull requests.
```