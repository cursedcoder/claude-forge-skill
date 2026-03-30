# Critique Rubrics — Structured Nitpicking Checklists

Use these rubrics to evaluate generated UI components. Each question demands a specific, cited answer — not a vague assessment.

---

## Pivot Adherence Rubric (apply FIRST, before anything else)

This is the most important rubric. A component with perfect CSS but no pivot adherence is still slop.

1. **Pivot declaration**: Is there a `<!-- Pivot: ... -->` comment at the top of the component? Does it name a Rank 3+ analog with specific structural properties? If the pivot is Rank 1-2 or missing, **stop here — the component must be redesigned from scratch.**
2. **Structural derivation**: For each major visual section (header, content area, navigation, widget, card, form), identify which specific pivot property dictates its layout. If any section has no pivot-derived structure, it is **pivot-orphaned** and must be flagged.
3. **Color provenance from pivot**: Is the color palette derived from the analog's physical materials? Name the material for each color. "Amber because it's warm" is not pivot-derived. "Amber because the specimen case's felt lining was this tone" IS pivot-derived.
4. **Typography registers**: Does the component use at least 2 distinct type treatments that map to different text roles in the analog? (e.g., "printed label" vs. "handwritten annotation")
5. **Layout non-uniformity**: Does the grid/layout reflect the analog's spatial organization? If the analog has non-uniform compartments, the grid must be non-uniform. If the layout is `repeat(N, 1fr)`, justify why the analog has uniform divisions.
6. **Widget/size differentiation**: If multiple sizes exist (small, medium, large widgets), are they structurally different objects derived from different aspects of the analog — not the same layout scaled up/down?
7. **Interaction mapping**: Do state transitions (hover, focus, expand, toggle) map to physical gestures from the analog? Name the gesture for each interaction.
8. **Brand distance**: Describe the top 3 most common LLM outputs for this brief. Count how many structural decisions in this component differ from ALL of those defaults. Minimum passing score: 7 different structural decisions.
9. **Pivot coherence**: Remove the CSS colors and decorative properties (shadows, gradients, border-radius). Does the bare layout structure still feel distinct from a generic app layout? If it collapses into a standard card grid or list when stripped of decoration, the pivot only affected cosmetics, not structure.
10. **Uniqueness prediction**: If you gave this same brief to 10 different LLMs without the pivot, estimate how many would produce something structurally similar. If >0, the pivot isn't working.

## Default Rubric (apply to every component)

For each item, cite the specific line number(s) in the code that trigger the finding.

1. **Pixel justification**: Does every element earn its screen space? Identify any element that could be removed without information loss.
2. **Spacing audit**: Is any spacing value a framework default (4px, 8px, 16px, 24px from a utility class) when a custom value would better serve the content's visual rhythm? List every spacing value and whether it's deliberate or defaulted.
3. **Color provenance**: Is any color a palette preset (Tailwind's `blue-500`, `gray-100`, etc.) rather than a purposeful custom value derived from the design's color system? Every hex/oklch value should be traceable to a design decision.
4. **Layout strategy**: Is the layout achievable with CSS grid (including subgrid) instead of nested flex containers? Is there unnecessary nesting?
5. **State coverage**: Does every interactive element have visually distinct `focus`, `hover`, `active`, and `disabled` states? List any elements missing states.
6. **Hierarchy speed**: Is the visual hierarchy readable in under 200ms? What is the intended reading order, and does the visual weight actually enforce it?
7. **LLM fingerprint**: Can you identify that an LLM generated this? What specific patterns give it away? This is the most important question.
8. **Decorative audit**: Is any animation, transition, shadow, or gradient purely decorative — communicating nothing about state, hierarchy, or affordance?
9. **Structural repetition**: Are any two components structurally identical with only content swapped? This indicates template-thinking rather than content-driven design.
10. **Responsive intentionality**: Does the responsive behavior degrade thoughtfully (restructuring hierarchy, changing interaction models) or just stack everything vertically?

## Typography Rubric

1. **Scale consistency**: Is the type scale derived from a single ratio, or are sizes arbitrary? List all font sizes used and check if they form a coherent progression.
2. **Line-height per size**: Is line-height calibrated per font size (tighter for larger, looser for smaller), or is one value applied uniformly?
3. **Reading order**: Is there a clear reading order established by visual hierarchy, without relying solely on size? Does weight, color, or spatial position contribute?
4. **Weight discipline**: Are font weights limited to 2-3 values, or scattered? Every additional weight should serve a distinct semantic role.
5. **Measure check**: Is any text block wider than 75ch? If so, the layout surrounding it needs restructuring.
6. **Numeric treatment**: Do tabular contexts (prices, counts, dates) use `tabular-nums`? Are numbers set in a typeface designed for numerical legibility?

## Accessibility Rubric

1. **Contrast**: Does every text element meet WCAG AAA contrast (7:1 for normal text, 4.5:1 for large text)? Check against APCA if possible. List every failing pair.
2. **Keyboard traversal**: Are all interactive elements reachable via Tab, operable via Enter/Space, and dismissible via Escape where appropriate? Is the tab order logical?
3. **Semantic HTML**: Is `<div>` used where `<section>`, `<article>`, `<nav>`, `<aside>`, `<main>`, `<header>`, `<footer>`, or `<dialog>` is semantically correct?
4. **ARIA completeness**: Where visual context is unavailable to screen readers, are `aria-label`, `aria-labelledby`, `aria-describedby`, or `aria-live` applied? Are they accurate, not pro-forma?
5. **Motion sensitivity**: Does every animation/transition respect `prefers-reduced-motion`? Is there a `@media (prefers-reduced-motion: reduce)` block?
6. **Touch targets**: Are all interactive elements at least 44x44px (ideally 48x48px) in touch target size, even if visually smaller?
7. **Error communication**: Are form errors communicated via `aria-invalid`, `aria-errormessage`, and visible text — not just color change?
8. **Language**: Is the `lang` attribute set correctly? Are any content sections in a different language marked with their own `lang`?

## Interaction Design Rubric

1. **Transition timing**: Are state transitions under 150ms for discrete changes and 200-350ms for spatial changes? List any transition using the default `300ms` or exceeding 500ms.
2. **Easing audit**: Is any element using `ease-in-out`, `linear`, or `ease` when a custom cubic-bezier would better match the motion's purpose? The default easing is almost never correct.
3. **Hover substance**: Do hover states reveal information, expose actions, or restructure hierarchy — or do they just change a background color?
4. **Loading states**: Do loading indicators communicate actual progress or just "something is happening"? Skeleton loaders should match the shape of the content they replace.
5. **Error recovery**: When something fails, does the UI indicate what went wrong, what the user can do about it, and preserve any input they've already provided?
6. **Scroll behavior**: Are scroll positions preserved across navigation? Do anchor links account for sticky header height via `scroll-margin-top`?

## Quality Scorecard

Score each dimension 1-10 with one-sentence evidence.

| Dimension | What 1 means | What 10 means |
|-----------|-------------|---------------|
| **Simplicity** | Overloaded, excessive nesting, defensive styling. Every problem solved by adding more. | Every element earns its place. Removing anything would lose information. |
| **Authenticity** | Generic LLM output. No pivot, or pivot is cosmetic. Could be produced by any model. | Every decision traces to the pivot. Impossible to replicate by accident. |
| **Clear UI** | Hierarchy unreadable. Can't find key information within 2 seconds. Elements compete for attention. | Hierarchy is instant. One clear reading path. Nothing competes. |
| **Visual Noise** | Gratuitous decoration: shadows, gradients, animations that communicate nothing. Busy. | Every visual property communicates state, hierarchy, or grouping. Quiet surfaces. |
| **Alignment** | Elements float independently. No grid discipline. Spacing is arbitrary. | Everything snaps to a grid. Baseline alignment in tabular data. Spatial rhythm is audible. |

**Composite score**: Average of all 5. Below 6 = structural rework. 6-7 = acceptable with fixes. 8+ = production-quality.

## Additional Scoring

- **Originality score** (1-10): 1 = indistinguishable from default LLM output. 5 = some considered decisions. 10 = impossible to identify as LLM-generated.
- **Slop density**: Findings / total lines of code as percentage.
- **Top 3 changes**: Ordered by impact.
