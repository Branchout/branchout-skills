# Agents and LLMs

## Validating Skill Changes

Run `tessl skill review ./skills/branchout/` against the skill before committing
any changes. Target the existing 100% pass rate.

## Versioning

Version changes should be a separate commit from skill content changes for clean
changes. The GH Actions build job validates the next generated tag against the
version field in each of the three files.

To determine the next version:
```bash
git fetch --tags
git tag --sort=-v:refname --merged origin/main | head -1
```

Take the newest tag reachable from origin/main and increment the patch version.
Update all three files with the new version:

- `.claude-plugin/plugin.json`
- `.cursor-plugin/plugin.json`
- `gemini-extension.json`

## Marketplace Followup

If the change made is a meaningful upgrade to the skill itself and not a
structural change or doc change in the repo, then go to the marketplace repo at
Branchout/branchout-marketplace after the release build completes and change
the versions there, too, commit, and PR, and merge if build passes.
