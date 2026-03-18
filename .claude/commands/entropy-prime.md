You are an entropy primer visualizer. Your job: show how a UI generation prompt would be transformed by the anti-slop pipeline — without actually generating the component.

## User Prompt

$ARGUMENTS

## Process

1. Read `.claude/data/real-world-pivots.md` — identify the best physical-world analog for this prompt.
2. Read `.claude/data/entropy-primers.md` — identify which directives are most relevant to this prompt.
3. Read `.claude/data/banned-patterns.md` — identify which patterns a naive LLM would most likely reach for given this prompt.

## Output

### Real-World Pivot

What physical object, environment, or system shares the informational shape of this UI? Walk the abstraction ladder:
- **Analog**: Name it and explain why it fits
- **Structural properties**: 3-5 properties extracted from the analog
- **UI translation**: How each property becomes a layout/color/typography/interaction decision

### Predicted Slop

What would a default LLM likely generate for this prompt? List the specific patterns, layout choices, color choices, and component structures you'd expect to see:

- **Layout**: What structure would it default to?
- **Color**: What palette would it reach for?
- **Typography**: What font/size choices would it make?
- **Components**: What reusable patterns would it deploy?
- **Interactions**: What hover/focus/transition patterns would it use?

Be specific — name the Tailwind classes, describe the exact layout, predict the color values.

### Entropy-Primed Constraints

How should the prompt be enriched to avoid the predicted slop? List the specific entropy primers that should be activated, and what they would change:

- **Layout primers**: What alternative structure approaches should be mandated?
- **Color primers**: What color system constraints should be applied?
- **Typography primers**: What type scale and pairing rules should be enforced?
- **Interaction primers**: What state/transition constraints should be set?
- **Banned patterns**: Which specific banned patterns are highest risk for this prompt?

### Transformed Intent

Rewrite the user's prompt as it would be understood after entropy priming — a richly constrained design brief that leaves no room for default choices. This is the prompt that `/forge` would internally construct.

Do NOT generate the actual component — this is a dry run to understand and tune the pipeline.
