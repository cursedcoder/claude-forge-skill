# Banned UI Patterns — Slop Database

These patterns appear with overwhelming frequency in LLM-generated UI. Their presence is a reliable signal of generic, unconsidered output. Avoid all of them unless the user explicitly requests one.

---

## CSS Class Patterns

- `rounded-2xl shadow-lg` or `rounded-xl shadow-md` combos — the "generic card" look
- `bg-gradient-to-r from-{color}-{n} to-{color}-{n}` — gratuitous gradients with no communicative purpose
- `hover:scale-105 transition-transform` — meaningless zoom-on-hover that adds no information
- `hover:shadow-xl transition-shadow` — shadow inflation as lazy hover feedback
- `text-gray-500 text-sm` as the default treatment for any secondary text
- `space-y-4` / `gap-4` as universal, unthinking spacing
- `max-w-7xl mx-auto px-4` — the copy-paste container pattern
- `transition-all duration-300` — everything transitions, nothing needs to
- `backdrop-blur-sm bg-white/80` — frosted glass as decoration, not function
- `ring-2 ring-offset-2` — ring as the only focus indicator strategy
- `truncate` on text that should be allowed to wrap
- `animate-pulse` / `animate-bounce` for loading states (no actual progress indication)

## Layout Clichés

- Centered hero section with h1 + subtitle paragraph + single CTA button
- Three-column card grid with icon + title + description per card
- Sidebar navigation with hamburger collapse on mobile
- Dashboard with exactly 4 KPI cards spanning the top row
- Footer with 3-4 columns of links + copyright bar
- Split layout: text left, image/illustration right (or vice versa)
- Full-width banner → content section → full-width banner alternation
- Sticky header with logo left, nav center, CTA button right
- Two-column form: labels left, inputs right
- Masonry grid for any "gallery" or "portfolio" context

## Color Clichés

- `blue-500` / `blue-600` as primary action color (the "default primary" smell)
- `gray-50` through `gray-900` as the entire neutral scale with no chromatic variation
- Green = success, red = error, yellow = warning (unexamined semaphore)
- `white` background with blue accents as the default light theme
- `slate-900` / `gray-900` background for dark themes with no warmth or character
- `indigo-600` as the "I wanted something other than blue but didn't think hard" choice
- Purple-to-pink gradients for "creative" or "modern" contexts
- `emerald-500` for anything finance/money related

## Component Clichés

- Testimonial carousel with circular avatar + italic quote + person's name and title
- Pricing table with exactly 3 tiers, the middle one highlighted as "Most Popular"
- Feature grid with colorful rounded-square icons in a 2x3 or 3x3 grid
- "Get Started" / "Learn More" button pairs where neither has a clear action
- Modal as centered card + backdrop blur, always the same proportions
- Toast notifications stacked in bottom-right corner
- Tab bar where all tabs are equal width regardless of label length
- Accordion/FAQ section as the default "lots of text" solution
- Progress stepper with circles connected by lines
- Empty state with centered illustration + "No items yet" + action button
- Search bar with magnifying glass icon inside the input
- Avatar with green dot for "online" status
- Breadcrumb trail as the only wayfinding mechanism
- "Load more" button instead of thoughtful pagination or infinite scroll with indicators

## Structural Patterns

- Every section wrapped in its own `<div>` with padding and max-width
- Nesting more than 3 levels of flex/grid containers
- `<div>` where `<section>`, `<article>`, `<nav>`, or `<aside>` is semantically correct
- Event handlers as anonymous inline functions for every interaction
- Component files that are just wrappers around a single styled div
- Props drilling through 3+ levels instead of composition
- `className` strings longer than 80 characters (style-as-string-soup)

## Animation/Interaction Clichés

- Fade-in-up on scroll for every section (the "AOS default" pattern)
- Parallax background images
- Counter animations that count from 0 to a big number
- Typewriter effect for hero text
- Confetti on form submission
- Skeleton loaders that don't match the actual content shape
- Hamburger-to-X icon animation
- Slide-in sidebar from the left on mobile
