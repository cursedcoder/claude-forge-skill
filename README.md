# Anti-Slop UI Forge

Claude Code plugin that makes LLM-generated UI impossible to identify as LLM-generated.

## The Problem

Every vibecoded app looks the same. `rounded-2xl shadow-lg`, blue-500 buttons, 3-column card grids, hero sections with centered h1 + subtitle + CTA. LLMs reach for high-probability UI patterns, producing generic output indistinguishable from any other AI-generated interface.

## The Solution

A Claude Code plugin that injects anti-slop constraints into UI generation: real-world pivots, banned pattern lists, low-frequency design vocabulary (entropy primers), and structured critique rubrics. The pipeline forces Claude to ground every design decision in a physical-world referent — the way all visual language evolves from reality through progressive abstraction (envelope -> mail icon -> email emoji).

## Install

Requires Claude Code 1.0.33+.

**From local directory** (for development/testing):

```bash
git clone https://github.com/cursedcoder/claude-forge-skill.git
claude --plugin-dir ./claude-forge-skill
```

**From a marketplace** (when available):

```bash
claude plugin install claude-forge
```

## Skills

All commands are namespaced as `/claude-forge:<command>`.

### `/claude-forge:forge` — Generate distinctive UI

```
/claude-forge:forge build a settings page with user preferences and notification controls
```

Full anti-slop pipeline in a single turn:
1. **Real-world pivot** — identifies a physical analog (cockpit, pharmacy, departure board) and extracts structural properties
2. Reads entropy primers (OKLCH color systems, asymmetric grids, custom type scales)
3. Reads banned patterns (80+ specific UI cliches to avoid)
4. Generates the component anchored to the pivot
5. Self-critiques against the rubric ("Can you identify that an LLM generated this?")
6. Refines, addressing every finding
7. Runs automated verification via `verify.sh`
8. Outputs final code + slop assessment with pivot documentation and originality score

### `/claude-forge:critique` — Nitpick existing code

```
/claude-forge:critique src/routes/settings/+page.svelte
```

Applies 4 rubrics (36 checklist items) against any component:
- Default (pixel justification, color provenance, LLM fingerprint analysis)
- Typography (scale consistency, measure, leading, weight discipline)
- Accessibility (WCAG AAA contrast, keyboard traversal, ARIA, motion sensitivity)
- Interaction design (transition timing, easing audit, hover substance)

Outputs line-by-line findings, originality score (1-10), slop density percentage, and top 3 high-impact changes.

### `/claude-forge:refine` — Iterate with feedback

```
/claude-forge:refine src/components/Header.svelte — the navigation feels too conventional, break the grid
```

Reads the file, runs antislop scan + critique internally, then rewrites addressing all findings plus your specific direction. Writes the improved version back to the file.

### `/claude-forge:debate` — Multi-perspective review

```
/claude-forge:debate src/routes/+page.svelte
```

Reviews the component from four professional lenses:
1. **Pivot Auditor** — structural identity, pivot rank verification, brand sufficiency
2. **Typographer** — type scale, measure, leading, hierarchy, pairing
3. **Brutalist** — strips decoration, assesses structural integrity without ornament
4. **Accessibility Auditor** — WCAG AAA, keyboard nav, screen reader experience, touch targets

Synthesizes findings, resolves trade-offs between perspectives, and rewrites the component.

### `/claude-forge:entropy-prime` — Dry run (no generation)

```
/claude-forge:entropy-prime build me a dashboard with charts
```

Shows what slop a naive LLM would produce for your prompt, which banned patterns are highest risk, and how entropy primers would transform the request. Useful for understanding and tuning the system without spending a generation cycle.

### `/claude-forge:verify` — Automated verification

```
/claude-forge:verify src/components/Card.html
```

Runs the `verify.sh` script (pure pattern matching, no LLM) then applies independent skeptical review with quality scorecards. Verdicts: SHIP / REFINE / REBUILD.

## Data Files

| File | Contents |
|------|----------|
| `data/real-world-pivots.md` | Abstraction ladder methodology, example analogs, structural property extraction, anti-patterns in pivoting |
| `data/banned-patterns.md` | 80+ UI slop patterns: CSS classes, layout cliches, color cliches, component cliches, structural anti-patterns, animation cliches |
| `data/entropy-primers.md` | Design vocabulary: OKLCH color systems, asymmetric grids, custom easing curves, logical properties, type scale ratios, subgrid, container queries |
| `data/critique-rubrics.md` | 4 rubrics with 36 total checklist items for evaluating component originality and quality |

## Workflow

**Quick generation:**
```
/claude-forge:forge <description>
```

**Thorough iteration:**
```
/claude-forge:forge <description>
/claude-forge:critique <generated-file>
/claude-forge:refine <generated-file> — <specific direction>
```

**Deep review:**
```
/claude-forge:forge <description>
/claude-forge:debate <generated-file>
```

**Understanding the pipeline:**
```
/claude-forge:entropy-prime <description>
```

## Plugin Structure

```
claude-forge/
├── .claude-plugin/
│   └── plugin.json         # Plugin manifest
├── commands/               # Slash commands
│   ├── forge.md
│   ├── critique.md
│   ├── debate.md
│   ├── entropy-prime.md
│   ├── refine.md
│   └── verify.md
├── data/                   # Reference data files
│   ├── banned-patterns.md
│   ├── critique-rubrics.md
│   ├── entropy-primers.md
│   └── real-world-pivots.md
├── scripts/
│   └── verify.sh           # Automated pattern-matching verifier
├── LICENSE
└── README.md
```

## Tuning

The system improves as you expand the data files:

- Add new real-world analogs and abstraction examples to `data/real-world-pivots.md`
- Add patterns you keep seeing to `data/banned-patterns.md`
- Add design directives that produce good results to `data/entropy-primers.md`
- Sharpen critique questions in `data/critique-rubrics.md`

## Requirements

- [Claude Code](https://claude.com/claude-code) 1.0.33+ with an active subscription
- No API keys, servers, or dependencies — just markdown files and a bash script
