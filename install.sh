#!/bin/bash
# Install anti-slop forge skills globally for Claude Code
# Usage: ./install.sh [--project /path/to/project]

set -e

if [ "$1" = "--project" ] && [ -n "$2" ]; then
  TARGET="$2/.claude"
  echo "Installing to project: $2"
else
  TARGET="$HOME/.claude"
  echo "Installing globally to ~/.claude"
fi

mkdir -p "$TARGET/commands" "$TARGET/data"

cp .claude/data/banned-patterns.md "$TARGET/data/"
cp .claude/data/entropy-primers.md "$TARGET/data/"
cp .claude/data/critique-rubrics.md "$TARGET/data/"
cp .claude/data/real-world-pivots.md "$TARGET/data/"

cp .claude/commands/forge.md "$TARGET/commands/"
cp .claude/commands/critique.md "$TARGET/commands/"
cp .claude/commands/refine.md "$TARGET/commands/"
cp .claude/commands/debate.md "$TARGET/commands/"
cp .claude/commands/entropy-prime.md "$TARGET/commands/"
cp .claude/commands/verify.md "$TARGET/commands/"

# Install verify script to project root or home bin
if [ "$1" = "--project" ] && [ -n "$2" ]; then
  cp verify.sh "$2/verify.sh"
  chmod +x "$2/verify.sh"
else
  cp verify.sh "$HOME/.claude/verify.sh"
  chmod +x "$HOME/.claude/verify.sh"
fi

echo ""
echo "Installed:"
echo "  Commands: forge, critique, refine, debate, entropy-prime, verify"
echo "  Data:     banned-patterns, entropy-primers, critique-rubrics, real-world-pivots"
echo "  Script:   verify.sh"
echo ""
if [ "$1" = "--project" ]; then
  echo "Use as: /project:forge <description>"
else
  echo "Use as: /user:forge <description>"
fi
