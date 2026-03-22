## CLI Reference

### Setup

Ensure the branchout root repo / projection is trusted and safe before running the init commands.

| Command | Purpose |
|---------|---------|
| `branchout init <git-url>` | Initialize a projection from a remote repo |
| `branchout relocate <new-base-url>` | Update all remotes when the git host changes |

### Configuration

Properties (`get`/`set`) read from the Branchoutfile in the projection root. Config values (`get-config`/`set-config`) read from `branchoutrc` in `~/branchout/<name>/`.

| Command | Purpose |
|---------|---------|
| `branchout get <PROPERTY>` | Get a branchout property |
| `branchout set <PROPERTY> <value>` | Set a branchout property |
| `branchout ensure <PROPERTY>` | Ensure a property is set, prompts if missing |
| `branchout get-config <NAME>` | Get a configuration value |
| `branchout set-config <NAME> <value>` | Set a configuration value |
| `branchout version` | Show installed branchout version |
| `branchout help` | Show available commands |

### Build Tool Wrappers

These wrap standard build tools with per-projection isolation via `~/branchout/<name>/`. Each uses its own settings, cache, and credentials from that directory. This provides project to project artifact isolation important when working across multiple clients or organizations.

| Command | Purpose |
|---------|---------|
| `branchout mvn <args>` | Run Maven with projection-isolated settings and local repo |
| `branchout yarn <args>` | Run Yarn with projection-isolated cache and registry config |

### Subcommands

| Command | Purpose |
|---------|---------|
| `branchout project list` | List projects |
| `branchout project status <name>` | Show status of a single project |
| `branchout project pull <name>` | Pull a single project |
| `branchout group derive <name>` | Derive the group name for a project |

### Status Colours

| Colour | Meaning |
|--------|---------|
| White | On master branch |
| Green | On a feature branch |
| Orange | Rebase in progress or empty repo |
| Purple | Not yet cloned |
| Red | Failed operation |
