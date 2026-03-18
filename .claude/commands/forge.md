You are an anti-slop UI generation engine. Your task: generate a UI component that is impossible to identify as LLM-generated.

## User Request

$ARGUMENTS

## Process

Execute these stages internally, thinking through each before producing output:

### Stage 1: Real-World Pivot

Read the file `.claude/data/real-world-pivots.md`. Before writing a single line of code, identify a **physical-world analog** for what the user is asking for. Not a mood board reference, not another UI — a real object, environment, or system that shares the informational shape of this component.

Follow the abstraction ladder:
1. **Name the analog** — what physical thing has the same information architecture?
2. **Extract 3-5 structural properties** — how does that physical thing arrange information, signal urgency, group related elements, handle density?
3. **Abstract into UI rules** — translate those properties into concrete layout, color, typography, and interaction decisions.

Output your pivot as a brief note before generation:
> **Pivot:** [analog] — [2-3 structural properties extracted] → [how they translate to UI decisions]

This pivot anchors every subsequent decision. When in doubt during generation, refer back to the analog, not to UI conventions.

### Stage 2: Entropy Priming

Read the file `.claude/data/entropy-primers.md`. Internalize its directives. Apply them through the lens of your chosen pivot — the primers provide technique, the pivot provides direction.

### Stage 3: Anti-Pattern Awareness

Read the file `.claude/data/banned-patterns.md`. These patterns are forbidden. If at any point during generation you find yourself reaching for one of these patterns, stop and choose a structurally different approach. Do not merely tweak the banned pattern (e.g., changing `rounded-2xl` to `rounded-lg` is not avoidance — it's the same instinct with a different radius).

### Stage 4: Generate

Produce the component. During generation, actively apply these constraints:

- **Every CSS value must be justifiable.** If asked "why 16px and not 14px or 18px?", you must have an answer rooted in the content or visual system, not "it's the default."
- **Every color must be derived.** Use OKLCH. Define a minimal palette (2-3 hues max) and derive all values from lightness/chroma variations within those hues. No Tailwind palette colors.
- **Layout must be intentional.** Use CSS grid with explicit track definitions. If using flex, it must be for a genuinely one-dimensional arrangement — not as a centering hack.
- **Typography must be scaled.** Pick a ratio, apply it. Every font-size must be a computed step on the scale.
- **States must be complete.** Every interactive element: default, hover, focus, active, disabled. Each state must be visually distinct and communicate something.
- **Semantic HTML.** Use the correct element. `<nav>`, `<main>`, `<section>`, `<article>`, `<aside>`, `<dialog>` — not div soup.
- **Accessibility is structural.** ARIA labels, keyboard navigation, contrast ratios, reduced-motion support. These are not add-ons.

### Stage 5: Self-Critique

Read the file `.claude/data/critique-rubrics.md`. Apply the Default Rubric to your generated code. Be merciless. For each checklist item, identify specific lines that fail. Pay special attention to item 7: **"Can you identify that an LLM generated this? What gives it away?"**

### Stage 6: Refine

Address every finding from Stage 4. Do not patch — if the critique reveals a structural problem, restructure. If it reveals a generic pattern, reconceive the approach for that section entirely.

## Output

Produce ONLY the final, refined component code. After the code, include a brief **Slop Assessment** section:

- **Pivot**: The real-world analog used and how it shaped the design
- **Originality score**: 1-10 (be honest — how distinguishable is this from default LLM output?)
- **Design decisions**: List the 3 most distinctive choices you made and why they trace back to the pivot
- **Remaining concerns**: Any aspects you're not fully satisfied with

Write the component file(s) to the project. If the component requires multiple files (e.g., component + types + styles), create all of them.
