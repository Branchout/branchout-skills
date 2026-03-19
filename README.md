# Branchout Skills

LLM coding agents work best when they understand the tools they operate. Branchout Skills teaches agents the Branchout manyrepo manager — its workspace conventions, CLI commands, and multi-repo patterns.

Agents that load these skills produce correct Branchout commands, follow naming conventions, and navigate manyrepo workspaces from the start.

Supports Claude Code, Cursor, Codex, Gemini CLI, and OpenCode.


## Skills

| Skill | Purpose |
|---|---|
| `branchout` | Entry point: environment detection, CLI reference, installation |


## Installation

### Claude Code

Register the marketplace, then install:

```
/plugin marketplace add Branchout/branchout-marketplace
/plugin install branchout-skills@branchout-marketplace
```

Or from the terminal:

```bash
claude plugin marketplace add Branchout/branchout-marketplace
claude plugin install branchout-skills@branchout-marketplace
```

### Cursor

In the Cursor IDE, go to **Dashboard > Settings > Plugins > Import** and paste:

```
https://github.com/Branchout/branchout-marketplace
```

Browse the imported marketplace and install `branchout-skills` from the plugin panel.

### Codex

Clone and symlink (full steps in `.codex/INSTALL.md`):

```bash
git clone https://github.com/Branchout/branchout-skills.git ~/.codex/branchout-skills
mkdir -p ~/.agents/skills
ln -s ~/.codex/branchout-skills/skills ~/.agents/skills/branchout-skills
```

### Gemini CLI

Install the skills repo as an extension:

```
/extensions install https://github.com/Branchout/branchout-skills
```

Or from the terminal:

```bash
gemini extensions install https://github.com/Branchout/branchout-skills
```

### OpenCode

Add to the `plugin` array in your project's `opencode.json`:

```json
{
  "plugin": ["branchout-skills@git+https://github.com/Branchout/branchout-skills.git"]
}
```


## License

MIT
