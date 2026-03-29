# Anti-Slop UI Forge

Claude Code skills that make LLM-generated UI impossible to identify as LLM-generated.

## The Problem

Every vibecoded app looks the same. `rounded-2xl shadow-lg`, blue-500 buttons, 3-column card grids, hero sections with centered h1 + subtitle + CTA. LLMs reach for high-probability UI patterns, producing generic output indistinguishable from any other AI-generated interface.

## The Solution

A set of Claude Code slash commands that inject anti-slop constraints into UI generation: real-world pivots, banned pattern lists, low-frequency design vocabulary (entropy primers), and structured critique rubrics. The pipeline forces Claude to ground every design decision in a physical-world referent — the way all visual language evolves from reality through progressive abstraction (envelope → ✉ → 📧).

## Skills

### `/project:forge` — Generate distinctive UI

```
/project:forge build a settings page with user preferences and notification controls
```

Full anti-slop pipeline in a single turn:
1. **Real-world pivot** — identifies a physical analog (cockpit, pharmacy, departure board) and extracts structural properties
2. Reads entropy primers (OKLCH color systems, asymmetric grids, custom type scales)
3. Reads banned patterns (80+ specific UI clichés to avoid)
4. Generates the component anchored to the pivot
5. Self-critiques against the rubric ("Can you identify that an LLM generated this?")
6. Refines, addressing every finding
7. Outputs final code + slop assessment with pivot documentation and originality score

### `/project:critique` — Nitpick existing code

```
/project:critique src/routes/settings/+page.svelte
```

Applies 4 rubrics (36 checklist items) against any component:
- Default (pixel justification, color provenance, LLM fingerprint analysis)
- Typography (scale consistency, measure, leading, weight discipline)
- Accessibility (WCAG AAA contrast, keyboard traversal, ARIA, motion sensitivity)
- Interaction design (transition timing, easing audit, hover substance)

Outputs line-by-line findings, originality score (1-10), slop density percentage, and top 3 high-impact changes.

### `/project:refine` — Iterate with feedback

```
/project:refine src/components/Header.svelte — the navigation feels too conventional, break the grid
```

Reads the file, runs antislop scan + critique internally, then rewrites addressing all findings plus your specific direction. Writes the improved version back to the file.

### `/project:debate` — Multi-perspective review

```
/project:debate src/routes/+page.svelte
```

Reviews the component from three professional lenses:
1. **Typographer** — type scale, measure, leading, hierarchy, pairing
2. **Brutalist** — strips decoration, assesses structural integrity without ornament
3. **Accessibility Auditor** — WCAG AAA, keyboard nav, screen reader experience, touch targets

Synthesizes findings, resolves trade-offs between perspectives, and rewrites the component.

### `/project:entropy-prime` — Dry run (no generation)

```
/project:entropy-prime build me a dashboard with charts
```

Shows what slop a naive LLM would produce for your prompt, which banned patterns are highest risk, and how entropy primers would transform the request. Useful for understanding and tuning the system without spending a generation cycle.

## Data Files

All in `.claude/data/`:

| File | Contents |
|------|----------|
| `real-world-pivots.md` | Abstraction ladder methodology, example analogs (cockpit, pharmacy, cartographer, departure board), structural property extraction, anti-patterns in pivoting |
| `banned-patterns.md` | 80+ UI slop patterns: CSS classes, layout clichés, color clichés, component clichés, structural anti-patterns, animation clichés |
| `entropy-primers.md` | Design vocabulary: OKLCH color systems, asymmetric grids, custom easing curves, logical properties, type scale ratios, subgrid, container queries |
| `critique-rubrics.md` | 4 rubrics with 36 total checklist items for evaluating component originality and quality |

## Workflow

**Quick generation:**
```
/project:forge <description>
```

**Thorough iteration:**
```
/project:forge <description>
/project:critique <generated-file>
/project:refine <generated-file> — <specific direction>
```

**Deep review:**
```
/project:forge <description>
/project:debate <generated-file>
```

**Understanding the pipeline:**
```
/project:entropy-prime <description>
```

## Install

**Global** (available in all projects as `/user:forge`, `/user:critique`, etc.):

```bash
git clone https://github.com/cursedcoder/claude-forge-skill.git
cd claude-forge-skill
./install.sh
```

**Per-project** (available as `/project:forge`, `/project:critique`, etc.):

```bash
git clone https://github.com/cursedcoder/claude-forge-skill.git
cd claude-forge-skill
./install.sh --project /path/to/your/project
```

This copies the skill commands and data files into the appropriate `.claude/` directory. No dependencies required.

## Tuning

The system improves as you expand the data files:

- Add new real-world analogs and abstraction examples to `real-world-pivots.md`
- Add patterns you keep seeing to `banned-patterns.md`
- Add design directives that produce good results to `entropy-primers.md`
- Sharpen critique questions in `critique-rubrics.md`

## Requirements

- [Claude Code](https://claude.com/claude-code) with an active subscription
- No API keys, servers, or dependencies — just markdown files
