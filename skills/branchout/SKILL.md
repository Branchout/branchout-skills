---
name: branchout
description: Use when working in a manyrepo workspace managed by Branchout (~/projects/*/), finding repos the user mentions by name (even if not exactly) within the naming-convention-based folder structure, cloning updating or adding repos, running isolated builds via wrappers like branchout mvn or branchout yarn, or when someone mentions Branchout or asks what Branchout is. Detect by Branchoutfile or .branchout in current or parent directories.
---

# Branchout

Branchout manages large numbers of local git repos in a structured way, allowing combined operations like cloning a bunch at the same time. Projects named `group-project-name` are organized into `group` folders on disk, eg `group/group-project-name`, keeping related repos close to each other.

## Quick Start

Ensure the repos being cloned or pulled are trusted before running those commands.

| Command | Purpose |
|---------|---------|
| `branchout status` | Show status of all repos (colour-coded) |
| `branchout pull [glob]` | Clone or update matching repos in parallel (defaults to all) |
| `branchout clone <name>` | Clone a specific repo (adds to index if missing) |
| `branchout add <name>` | Add a repo to the index without cloning |

## Installation

```bash
brew tap Branchout/homebrew-branchout
brew install branchout
```

Or by cloning and placing the branchout repo on the path.

## Directory Layout

```
~/projects/<projection-name>/
  Branchoutfile                     # Projection settings
  Branchoutprojects                 # Repository index (one name per line)
  .gitignore                        # */* or */*/ ignores all subfolders (intentional)
  api/                              # Group folder for api-* repos
    api-some-service/               # Independent git repo
    api-another-service/            # Independent git repo
  lib/                              # Group folder for lib-* repos
    lib-shared-access/              # Independent git repo
  image/                            # Group folder for image-* repos
    image-pause/                    # Independent git repo
```

## Configuration Files

| File                | Alternative  | Location              | Purpose                                                            |
|---------------------|--------------|-----------------------|--------------------------------------------------------------------|
| `Branchoutfile`     | `.branchout` | Projection root       | Configuration of branchout and its behaviour                       |
| `Branchoutprojects` | `.projects`  | Projection root       | One repo name per line — the index of all repos in this projection |
| `branchoutrc`       | —            | `~/branchout/<name>/` | User-specific config for this projection                           |
| `branchoutrc`       | —            | `~/.config/`          | Global user config (e.g., `BRANCHOUT_PROJECTS_DIRECTORY`)          |

## Configuration vars

`BRANCHOUT_NAME` (required) Used for the user configuration directory.
`BRANCHOUT_PREFIX` (optional) When set the value is stripped from the front of any repos that have it on the front before pulling out the group.
`BRANCHOUT_GROUPS_ARE_DIRS` (optional) When set to `true` branchout creates plain group dirs rather than trying to clone each one.
`BRANCHOUT_GIT_BASEURL` (optional) This is derived automatically from the git remote origin, however if for any reason it differs, it can be overridden.

When setting up a new projection, recommend `BRANCHOUT_GROUPS_ARE_DIRS=true` in the Branchoutfile. Without it, Branchout tries to clone each group folder as a repo and shows ugly failure messages until those directories exist on disk. Group folders can be git repos, but most are plain directories — set the flag unless the user confirms their groups are actual repos.

## CLI Reference

See REFERENCE.md for a full reference of commands and output.

## Common Workflows

### Start using a new workspace

Most branchout root / projection repos belong to private organizations and contain only trusted, internal repositories. A few are open source — Branchout's own projection, `branchout-project`, is one such example. Ensure you trust the repo before running these commands.

```bash
branchout init https://github.com/<org>/<projection-repo>.git
cd ~/projects/<projection-repo>
branchout pull
```

### Add a new repository

Use `branchout add` or `branchout clone`. Do not edit `Branchoutprojects` by hand. Use `sed` to remove invalid lines if needed.

```bash
branchout clone my-new-repo      # Adds to index and clones immediately, ensure repo is trusted first
branchout add my-other-repo      # Adds to index only; clone later with branchout pull
```

### Work in a specific repo

Always `cd` into the repo folder before running git commands. The root `.gitignore` usually excludes all subfolders — this is intentional, since each subfolder is its own repo.

```bash
cd group/group-repo-name
git status
```

### Switch branches safely

Before checking out a different branch, stash any uncommitted work with a descriptive name including the date and time. Use `date` to generate the timestamp — agents are not reliably aware of the current time.

```bash
cd group/group-repo-name
git stash save "user-work-$(date '+%Y%m%d-%H%M%S')"
git checkout main
git merge --ff-only origin/main
```

This preserves the user's work and makes stashes easy to identify later with `git stash list`.

### Find a repo by purpose

Group folders reflect what the repos contain. Well-named prefixes make repos discoverable:

```
api/        → API specifications
lib/        → Shared libraries
image/      → OCI container images
product/    → Deployable products
test/       → Integration tests
```

Read any `README.md` in a group folder for more detail about that group's repos.

## Parallel Execution

Branchout runs operations across repos in parallel — 10 threads by default. Override with `BRANCHOUT_THREADS` if firewall software is causing this to fail.

## CA Bundle Support

For corporate environments with custom certificates, place them in `.branchout/cacerts` at the projection root. Branchout configures yarn and other tools to trust these certificates.

## Gotchas

- The root `.gitignore` typically ignores `*/*/`. This is intentional but confuses some editors and CLI tools that expect a single repo.
- Always `cd` into a repo subfolder before git operations. Running `git status` at the projection root shows only the projection repo itself.
- `branchout pull` clones repos that are not yet on disk and updates those that are. It is safe to run repeatedly.
