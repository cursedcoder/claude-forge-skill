# Entropy Primers — Design Vocabulary for Specificity

These instructions and vocabulary push generated UI away from high-probability defaults toward considered, specific design decisions. Inject relevant sections into generation prompts based on context.

---

## Layout Principles

- Employ asymmetric grid subdivision — no column should mirror another's proportions. A 5:3 or 7:4 split communicates visual intention; 1:1:1 communicates nothing.
- Use CSS `subgrid` to enforce cross-component alignment at the cell level. Nested grids without subgrid are structurally dishonest.
- Anchor visual weight to the page's optical dead-center (roughly 1/3 from top), not the geometric center. Geometric centering reads as floating.
- Negative space is load-bearing structure, not absence of content. A 60px gap communicates hierarchy differently than a 24px gap — choose deliberately.
- Stagger element placement within grid tracks. Not everything that shares a row needs to share a baseline.
- Use `min()`, `max()`, and `clamp()` for every dimension that must respond to viewport — no fixed breakpoint jumps.
- Prefer `container` queries (`@container`) over media queries. Components should respond to their own context, not the window.
- For dense interfaces: establish a spatial rhythm (e.g., 6px base unit) and derive every measurement from it. If 6px is the atom, 12/18/24/36/48 are the molecules.

## Typography Directives

- Use type scale ratios that aren't 1.25 (major third) or 1.333 (perfect fourth). Consider 1.172 (minor second), 1.414 (augmented fourth), or a custom ratio derived from the golden section applied to your base size.
- Pair typefaces by contrast of construction, not genre. A grotesque sans (Helvetica, Aktiv Grotesk) with a humanist sans (Gill Sans, Fira Sans) creates tension. A geometric sans (Futura, Inter) with a transitional serif (Times, Charter) creates dialogue. A sans with a slab is redundant.
- Set body measure at 45-75ch. Measure above 75ch degrades tracking accuracy per saccade. If the layout demands wider, the layout is wrong.
- Line-height contracts with size: 1.5-1.7 for body (14-18px), 1.2-1.3 for subheads (20-28px), 1.0-1.1 for display (36px+). One `leading-relaxed` for everything is laziness.
- Tracking (letter-spacing): tighten display sizes by -0.02em to -0.04em. Loosen small caps and all-caps by +0.04em to +0.08em. Default tracking at display sizes is always too loose.
- Use `font-variant-numeric: tabular-nums` for any column of numbers. Proportional figures in tables are a legibility defect.
- Establish no more than 3 font weights in a system. 400/600/700 or 300/500/800 — not the full spectrum.

## Color System

- Derive the entire palette from OKLCH color space. OKLCH provides perceptual uniformity — two colors at the same lightness value actually appear equally bright, unlike HSL.
- Build chromatic grays: grays with 2-5% chroma tinted toward the primary hue. `oklch(55% 0.02 250)` reads as gray but carries warmth/coolness that pure `oklch(55% 0 0)` lacks.
- Create a lightness scale with perceptual equidistance: L=95, 85, 75, 65, 55, 45, 35, 25, 15. Map semantic roles (surface, text, border, accent) to specific lightness stops.
- Reserve full saturation (chroma > 0.15 in OKLCH) for exactly one semantic role: the primary action, or the critical alert, never both simultaneously.
- For dark themes: surface at `oklch(18-22% 0.005-0.015 {hue})`, not pure black. Text at `oklch(85-92% 0-0.01 {hue})`, not pure white. Pure black/white creates afterimage fatigue.
- Test every color pair against APCA (Advanced Perceptual Contrast Algorithm), not just WCAG 2.x AA. APCA accounts for polarity (light-on-dark vs dark-on-light) and spatial frequency.
- Semantic color should be derived, not assigned. If your primary is `oklch(55% 0.18 260)`, your danger color shouldn't be an unrelated `red-500` — derive it: same lightness and chroma, rotate hue to ~30.

## Interaction Design

- Every state transition under 150ms for discrete changes (toggle, select, enable). Reserve 200-350ms for spatial transitions (expand, slide, reflow). Nothing should take 500ms.
- Easing: use `cubic-bezier(0.22, 1, 0.36, 1)` for exits (fast start, gentle settle), `cubic-bezier(0.61, 1, 0.88, 1)` for entries (gentle start, natural arrival). Never `ease-in-out` — it lingers in the middle.
- Hover states must communicate affordance, not just acknowledge the cursor. Reveal supplementary information, shift spatial hierarchy, or expose an action — don't just darken a background.
- Focus indicators: 2px solid `outline` with `outline-offset: 2px`. Use `outline` not `box-shadow` — outline respects `border-radius` in modern browsers and doesn't affect layout. Color: primary action color at full opacity.
- Disabled states: reduce opacity to 0.4 AND change cursor. Opacity alone is ambiguous. Add `aria-disabled="true"` and remove from tab order.
- Touch targets: minimum 44x44px (WCAG) but 48x48px is the defensible target. If the visual element is smaller, expand the hit area with padding or pseudo-elements.
- Scroll behavior: `scroll-behavior: smooth` only on elements with `prefers-reduced-motion: no-preference`. Use `scroll-margin-top` on anchor targets to account for sticky headers.

## CSS Architecture

- Define a design token layer as CSS custom properties on `:root`. Every visual decision traces back to a token. If a value appears as a magic number, it's a missing token.
- Use `clamp(min, preferred, max)` for fluid typography and spacing: `font-size: clamp(1rem, 0.5rem + 1.5vw, 1.25rem)`. No media query needed.
- Logical properties everywhere: `margin-inline-start` not `margin-left`, `padding-block` not `padding-top/bottom`, `inline-size` not `width`. This is not aspirational — it's the baseline for internationalization.
- `color-scheme: light dark` on `:root` to opt into UA stylesheet awareness. Then use `light-dark()` function for values that flip between modes.
- Layer your CSS with `@layer`: `@layer reset, tokens, base, components, utilities`. Specificity wars indicate missing architecture.
- Prefer `:where()` for low-specificity selectors (resettable defaults) and `:is()` for convenience grouping. Understanding the specificity difference between them is non-negotiable.
- Use `@scope` for component-level styling boundaries where Shadow DOM is overkill.

## Anti-Patterns to Actively Subvert

- If the first layout instinct is "flexbox with centered children" — stop. Try grid with named areas, or absolute positioning within a relative container, or `float` with shape-outside.
- If the first color instinct is "blue for primary" — stop. Derive the primary from the content's semantic domain. Finance doesn't need green. Health doesn't need teal.
- If the first typography instinct is "Inter" or "system-ui" — stop. Choose a typeface that has a historical or structural reason to exist in this context.
- If the first spacing instinct is "p-4 m-4 gap-4" — stop. Each gap should reflect the informational relationship between the elements it separates.
- If the first responsive instinct is "stack vertically on mobile" — stop. Consider whether the component should transform its presentation model entirely, not just linearize.
