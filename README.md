# Anti-Slop UI Forge

Claude Code plugin that kills generic LLM-generated UI. Forces every design decision through real-world pivots, banned pattern lists, entropy primers, and structured critique rubrics.

## Install

In Claude Code:

```
/plugin marketplace add cursedcoder/claude-forge-skill
/plugin install forge@anti-slop-forge
```

Or test locally:

```bash
claude --plugin-dir /path/to/claude-forge-skill
```

## Commands

| Command | What it does |
|---------|-------------|
| `/forge:anti-slop-ui <brief>` | Full pipeline: pivot selection, generation, self-critique, verify |
| `/forge:critique <file>` | 36-item rubric evaluation across 4 dimensions |
| `/forge:refine <file> — <direction>` | Rewrite with antislop fixes + your feedback |
| `/forge:debate <file>` | 4-perspective review (pivot auditor, typographer, brutalist, a11y) then rewrite |
| `/forge:entropy-prime <brief>` | Dry run — shows predicted slop vs transformed brief, no code |
| `/forge:verify <file>` | Automated pattern scan + independent quality scorecard |

## Data

Editable reference files in `data/`:

- **real-world-pivots.md** — abstraction ladder, ranking system, worked examples
- **banned-patterns.md** — 80+ UI cliches to avoid
- **entropy-primers.md** — OKLCH, asymmetric grids, custom type scales, easing curves
- **critique-rubrics.md** — 4 rubrics, 36 items

## Requirements

[Claude Code](https://claude.com/claude-code) 1.0.33+. No API keys or dependencies.
