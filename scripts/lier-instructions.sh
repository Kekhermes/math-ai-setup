#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

mkdir -p .github .claude .agents

ln -sfn AGENTS.md CLAUDE.md
ln -sfn ../AGENTS.md .github/copilot-instructions.md
ln -sfn ../.github/skills .claude/skills
ln -sfn ../.github/skills .agents/skills

echo "Liens symboliques synchronisés :"
ls -l CLAUDE.md .github/copilot-instructions.md .claude/skills .agents/skills
