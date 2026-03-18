#!/bin/bash
# Automated anti-slop verification — no LLM involved, pure pattern matching
# Usage: ./verify.sh <file.html>
# Returns exit code 0 if clean, 1 if slop detected

set -e

FILE="${1:?Usage: ./verify.sh <file.html>}"

if [ ! -f "$FILE" ]; then
  echo "ERROR: File not found: $FILE"
  exit 2
fi

LINES=$(wc -l < "$FILE")
FINDINGS=0
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m'

echo ""
echo "${BOLD}Anti-Slop Verification: ${FILE}${NC}"
echo "═══════════════════════════════════════════════════"
echo ""

# ── 1. Pivot declaration ──────────────────────────────
echo "${BOLD}1. Pivot Declaration${NC}"
if grep -q '<!-- Pivot:' "$FILE"; then
  PIVOT=$(grep '<!-- Pivot:' "$FILE" | head -1)
  echo "   ${GREEN}FOUND${NC}: $PIVOT"
  if echo "$PIVOT" | grep -qi 'Rank 4'; then
    echo "   ${GREEN}Rank 4${NC}"
  elif echo "$PIVOT" | grep -qi 'Rank 3'; then
    echo "   ${YELLOW}Rank 3 — acceptable but not ideal${NC}"
  else
    echo "   ${RED}Rank below 3 or unspecified — FAIL${NC}"
    FINDINGS=$((FINDINGS + 3))
  fi
else
  echo "   ${RED}MISSING — no pivot declaration found${NC}"
  FINDINGS=$((FINDINGS + 5))
fi
echo ""

# ── 2. Banned CSS patterns ───────────────────────────
echo "${BOLD}2. Banned CSS Patterns${NC}"

declare -a PATTERNS=(
  "rounded-2xl:generic card radius"
  "rounded-xl:generic card radius"
  "shadow-lg:generic card shadow"
  "shadow-md:generic card shadow"
  "shadow-xl:generic card shadow"
  "bg-gradient-to:gratuitous gradient"
  "hover:scale-:meaningless zoom on hover"
  "scale-105:zoom scale cliché"
  "scale-110:zoom scale cliché"
  "transition-all:lazy transition"
  "duration-300:default duration"
  "backdrop-filter.*blur:glassmorphism"
  "backdrop-blur:glassmorphism"
  "animate-pulse:generic loading"
  "animate-bounce:generic animation"
  "ease-in-out:default easing"
  "text-gray-500:Tailwind default"
  "text-gray-400:Tailwind default"
  "bg-gray-50:Tailwind default"
  "bg-gray-100:Tailwind default"
  "blue-500:Tailwind default primary"
  "blue-600:Tailwind default primary"
  "indigo-600:Tailwind default"
  "space-y-4:unthinking spacing"
  "gap-4:unthinking spacing (check if justified)"
  "max-w-7xl mx-auto:copy-paste container"
)

PATTERN_HITS=0
for entry in "${PATTERNS[@]}"; do
  PATTERN="${entry%%:*}"
  DESC="${entry##*:}"
  COUNT=$(grep -c "$PATTERN" "$FILE" 2>/dev/null || true)
  if [ "$COUNT" -gt 0 ]; then
    echo "   ${RED}✗${NC} ${PATTERN} (${COUNT}x) — ${DESC}"
    LINES_FOUND=$(grep -n "$PATTERN" "$FILE" | head -3 | awk -F: '{print "     line "$1}')
    echo "$LINES_FOUND"
    PATTERN_HITS=$((PATTERN_HITS + COUNT))
  fi
done

if [ "$PATTERN_HITS" -eq 0 ]; then
  echo "   ${GREEN}No banned CSS patterns found${NC}"
else
  echo ""
  echo "   ${RED}${PATTERN_HITS} banned pattern matches${NC}"
  FINDINGS=$((FINDINGS + PATTERN_HITS))
fi
echo ""

# ── 3. Color provenance ──────────────────────────────
echo "${BOLD}3. Color Provenance${NC}"

OKLCH_COUNT=$(grep -c 'oklch' "$FILE" 2>/dev/null || true)
HEX_COUNT=$(grep -oE '#[0-9a-fA-F]{3,8}' "$FILE" 2>/dev/null | wc -l | tr -d ' ')
TAILWIND_COLOR=$(grep -oE '(red|blue|green|yellow|purple|pink|indigo|emerald|slate|gray|zinc|neutral)-[0-9]\{2,3\}' "$FILE" 2>/dev/null | wc -l | tr -d ' ')

echo "   OKLCH values: ${OKLCH_COUNT}"
echo "   Hex values: ${HEX_COUNT}"
echo "   Tailwind palette references: ${TAILWIND_COLOR}"

if [ "$OKLCH_COUNT" -gt 0 ] && [ "$TAILWIND_COLOR" -eq 0 ]; then
  echo "   ${GREEN}Color system looks intentional${NC}"
elif [ "$TAILWIND_COLOR" -gt 0 ]; then
  echo "   ${RED}Tailwind palette colors detected — not pivot-derived${NC}"
  FINDINGS=$((FINDINGS + TAILWIND_COLOR))
elif [ "$OKLCH_COUNT" -eq 0 ]; then
  echo "   ${YELLOW}No OKLCH — colors may be defaults${NC}"
  FINDINGS=$((FINDINGS + 1))
fi
echo ""

# ── 4. Layout analysis ───────────────────────────────
echo "${BOLD}4. Layout Analysis${NC}"

REPEAT_1FR=$(grep -c 'repeat.*1fr' "$FILE" 2>/dev/null || true)
GRID_TEMPLATE=$(grep -c 'grid-template' "$FILE" 2>/dev/null || true)
FLEX_CENTER=$(grep -c 'items-center justify-center' "$FILE" 2>/dev/null || true)
NESTED_FLEX=$(grep -c 'display:\s*flex' "$FILE" 2>/dev/null || true)

echo "   Grid template definitions: ${GRID_TEMPLATE}"
echo "   repeat(N, 1fr) uniform grids: ${REPEAT_1FR}"
echo "   Flex containers: ${NESTED_FLEX}"
echo "   Flex centering combos: ${FLEX_CENTER}"

if [ "$REPEAT_1FR" -gt 2 ]; then
  echo "   ${YELLOW}Multiple uniform grids — check if pivot justifies uniformity${NC}"
  FINDINGS=$((FINDINGS + 1))
fi
if [ "$FLEX_CENTER" -gt 3 ]; then
  echo "   ${YELLOW}Heavy flex centering — layout may be generic${NC}"
  FINDINGS=$((FINDINGS + 1))
fi
echo ""

# ── 5. Typography registers ──────────────────────────
echo "${BOLD}5. Typography Registers${NC}"

FONT_FAMILIES=$(grep -oE "font-family:[^;]+" "$FILE" 2>/dev/null | sort -u | wc -l | tr -d ' ')
FONT_VARS=$(grep -oE "var\(--f[fo][no]t[^)]*\)" "$FILE" 2>/dev/null | sort -u | wc -l | tr -d ' ')

echo "   Distinct font-family declarations: ${FONT_FAMILIES}"
echo "   Font custom properties used: ${FONT_VARS}"

if [ "$FONT_FAMILIES" -lt 2 ] && [ "$FONT_VARS" -lt 2 ]; then
  echo "   ${YELLOW}Single type register — pivot may require dual registers${NC}"
  FINDINGS=$((FINDINGS + 1))
else
  echo "   ${GREEN}Multiple type registers detected${NC}"
fi
echo ""

# ── 6. Structural clichés ────────────────────────────
echo "${BOLD}6. Structural Clichés${NC}"

HERO_PATTERN=$(grep -c 'hero' "$FILE" 2>/dev/null || true)
CARD_GRID=$(grep -c 'card' "$FILE" 2>/dev/null || true)
TESTIMONIAL=$(grep -c -i 'testimonial' "$FILE" 2>/dev/null || true)

if [ "$HERO_PATTERN" -gt 0 ]; then
  echo "   ${YELLOW}'hero' referenced ${HERO_PATTERN}x — check if structural or just a class name${NC}"
fi
if [ "$CARD_GRID" -gt 2 ]; then
  echo "   ${YELLOW}'card' referenced ${CARD_GRID}x — likely card-grid pattern${NC}"
  FINDINGS=$((FINDINGS + 1))
fi
if [ "$TESTIMONIAL" -gt 0 ]; then
  echo "   ${RED}'testimonial' detected — classic cliché${NC}"
  FINDINGS=$((FINDINGS + 2))
fi
if [ "$HERO_PATTERN" -eq 0 ] && [ "$CARD_GRID" -le 2 ] && [ "$TESTIMONIAL" -eq 0 ]; then
  echo "   ${GREEN}No obvious structural clichés${NC}"
fi
echo ""

# ── 7. Pivot Leakage (analog vocabulary in code) ─────
echo "${BOLD}7. Pivot Leakage${NC}"

# Common analog material/domain words that shouldn't appear in CSS/class names
declare -a ANALOG_WORDS=(
  "brass:analog material"
  "felt:analog material"
  "marble:analog material"
  "ink:analog material (use 'text' or 'foreground')"
  "wood:analog material"
  "specimen:analog domain"
  "tray:analog domain"
  "cabinet:analog domain"
  "ledger:analog domain"
  "stamp:analog domain"
  "bezel:analog domain"
  "loupe:analog domain"
  "bench:analog domain"
  "linen:analog material"
  "parchment:analog material"
  "vellum:analog material"
  "patina:analog material"
)

LEAKS=0
# Only check inside style/class attributes, not the pivot comment
CONTENT_WITHOUT_PIVOT=$(grep -v '<!-- Pivot:' "$FILE")
for entry in "${ANALOG_WORDS[@]}"; do
  WORD="${entry%%:*}"
  DESC="${entry##*:}"
  # Check CSS variables and class names (excluding the pivot comment line)
  COUNT=$(echo "$CONTENT_WITHOUT_PIVOT" | grep -ci "\-\-${WORD}\|\.${WORD}\|${WORD}-\|${WORD}_" 2>/dev/null || true)
  if [ "$COUNT" -gt 0 ]; then
    echo "   ${RED}✗${NC} '${WORD}' in code (${COUNT}x) — ${DESC}"
    LEAK_LINES=$(echo "$CONTENT_WITHOUT_PIVOT" | grep -ni "\-\-${WORD}\|\.${WORD}\|${WORD}-\|${WORD}_" | head -3 | awk -F: '{print "     line "$1": "$2}')
    echo "$LEAK_LINES"
    LEAKS=$((LEAKS + COUNT))
  fi
done

if [ "$LEAKS" -eq 0 ]; then
  echo "   ${GREEN}No analog vocabulary leaked into code${NC}"
else
  echo ""
  echo "   ${RED}${LEAKS} analog leaks — pivot used literally, not as derivative${NC}"
  FINDINGS=$((FINDINGS + LEAKS))
fi
echo ""

# ── 8. Accessibility basics ──────────────────────────
echo "${BOLD}8. Accessibility Basics${NC}"

ARIA_COUNT=$(grep -c 'aria-' "$FILE" 2>/dev/null || true)
ROLE_COUNT=$(grep -c 'role=' "$FILE" 2>/dev/null || true)
LANG_ATTR=$(grep -c 'lang=' "$FILE" 2>/dev/null || true)
REDUCED_MOTION=$(grep -c 'prefers-reduced-motion' "$FILE" 2>/dev/null || true)
SEMANTIC=$(grep -cE '<(nav|main|section|article|aside|header|footer|dialog)[ >]' "$FILE" 2>/dev/null || true)

echo "   ARIA attributes: ${ARIA_COUNT}"
echo "   Role attributes: ${ROLE_COUNT}"
echo "   Semantic elements: ${SEMANTIC}"
echo "   lang attribute: ${LANG_ATTR}"
echo "   prefers-reduced-motion: ${REDUCED_MOTION}"

if [ "$REDUCED_MOTION" -eq 0 ]; then
  echo "   ${RED}Missing prefers-reduced-motion${NC}"
  FINDINGS=$((FINDINGS + 1))
fi
if [ "$SEMANTIC" -lt 3 ]; then
  echo "   ${YELLOW}Low semantic element count — possible div soup${NC}"
  FINDINGS=$((FINDINGS + 1))
fi
if [ "$LANG_ATTR" -eq 0 ]; then
  echo "   ${RED}Missing lang attribute${NC}"
  FINDINGS=$((FINDINGS + 1))
fi
echo ""

# ── Summary ──────────────────────────────────────────
echo "═══════════════════════════════════════════════════"
SLOP_DENSITY=$(echo "scale=1; $FINDINGS * 100 / $LINES" | bc 2>/dev/null || echo "?")
echo "${BOLD}Total findings: ${FINDINGS}${NC} across ${LINES} lines (slop density: ${SLOP_DENSITY}%)"
echo ""

if [ "$FINDINGS" -eq 0 ]; then
  echo "${GREEN}${BOLD}CLEAN${NC} — no automated slop detected"
  echo "Run /critique for LLM-based deep review."
elif [ "$FINDINGS" -le 3 ]; then
  echo "${YELLOW}${BOLD}MINOR${NC} — a few patterns to address"
  echo "Run /critique for detailed findings."
else
  echo "${RED}${BOLD}SLOP DETECTED${NC} — ${FINDINGS} issues found"
  echo "Run /refine to address structural problems."
fi
echo ""

exit $([ "$FINDINGS" -le 3 ] && echo 0 || echo 1)
