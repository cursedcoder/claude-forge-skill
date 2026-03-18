You are a pivot and entropy analysis engine. Your job: show how a UI brief would be transformed by the anti-slop pipeline — pivot selection, entropy priming, slop prediction — without generating any code.

## User Prompt

$ARGUMENTS

## Process

1. Read `.claude/data/real-world-pivots.md` — internalize the intricacy ranking system.
2. Read `.claude/data/entropy-primers.md` — identify relevant design directives.
3. Read `.claude/data/banned-patterns.md` — identify highest-risk patterns for this brief.

## Output

### Predicted Slop (what a default LLM would produce)

Be specific and merciless. Name exact patterns:
- **Layout**: What grid/flex structure? What proportions? (e.g., "3-column `repeat(3, 1fr)` card grid")
- **Color**: What palette? Name the Tailwind classes or hex values. (e.g., "`blue-500` primary, `gray-50` to `gray-900` neutrals")
- **Typography**: What font? What scale? (e.g., "Inter or system-ui, Tailwind default text sizes")
- **Components**: What structural clichés? (e.g., "hero section with centered h1 + subtitle + CTA")
- **Interactions**: What hover/focus/transition defaults? (e.g., "`hover:scale-105 transition-all duration-300`")
- **Widgets** (if applicable): How would widget sizes differ? (e.g., "same layout scaled down, content removed for smaller sizes")

### Pivot Candidates (ranked by intricacy)

Generate **5 candidate pivots**, rank each 1-4, and explain the ranking:

| # | Analog | Rank | Why this rank | Key structural properties |
|---|--------|------|---------------|--------------------------|
| 1 | ... | ... | ... | ... |
| 2 | ... | ... | ... | ... |
| 3 | ... | ... | ... | ... |
| 4 | ... | ... | ... | ... |
| 5 | ... | ... | ... | ... |

### Recommended Pivot (highest intricacy viable)

Choose the best candidate (Rank 3+, preferably Rank 4). Then do a deep extraction:

**Analog:** [name]
**Rank:** [3 or 4]

**Structural rules (5-8):**
1. Layout: [specific rule] ← [property from analog]
2. Color: [specific palette derivation] ← [materials from analog]
3. Typography: [type registers] ← [text roles in analog]
4. Interaction: [gesture mapping] ← [physical actions in analog]
5. Spacing: [rhythm/proportion logic] ← [spatial organization in analog]
6-8. [additional rules]

**Brand sufficiency test:**
1. Could >1/10 designers produce this independently? [YES/NO]
2. Could someone guess the pivot from the finished UI? [YES/NO]
3. Does it produce 8+ reusable design rules? [YES/NO]
4. Do 7+ structural decisions differ from predicted slop? [YES/NO]

### Entropy-Primed Constraints

How the entropy primers apply **through the lens of the chosen pivot**:
- **Layout primers**: [what they change, filtered through pivot]
- **Color primers**: [OKLCH application, mapped to pivot's material palette]
- **Typography primers**: [scale/pairing choices, driven by pivot's text registers]
- **Interaction primers**: [timing/easing choices, mapped to pivot's physical gestures]
- **Banned patterns**: [which specific patterns are highest risk and what the pivot naturally replaces them with]

### Transformed Brief

Rewrite the user's prompt as a richly constrained design brief that embeds the pivot, entropy primers, and banned patterns. This is approximately the mental model that `/forge` would construct before generating code.

### Slop Distance Estimate

Count concrete structural decisions in the transformed brief that differ from the predicted slop. List each one. Target: 7+ for Rank 3, 10+ for Rank 4.

Do NOT generate any component code — this is a dry run for analysis and tuning only.
