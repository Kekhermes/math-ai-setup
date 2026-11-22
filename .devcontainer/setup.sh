#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

echo "=== [0/6] Permissions des volumes Docker persistants ==="
sudo mkdir -p "$HOME/.elan" "$HOME/.copilot" "$HOME/.claude" "$HOME/.codex" "$HOME/.cache/uv" "$HOME/.local/bin"
sudo chown -R "$(id -u):$(id -g)" "$HOME/.elan" "$HOME/.copilot" "$HOME/.claude" "$HOME/.codex" "$HOME/.cache" "$HOME/.local"

echo "=== [1/6] Paquets système (LaTeX, poppler, graphviz, ripgrep) ==="
sudo apt-get update && sudo apt-get install -y --no-install-recommends \
  ripgrep curl git jq graphviz \
  texlive-latex-extra texlive-science texlive-bibtex-extra \
  texlive-fonts-recommended texlive-lang-french latexmk biber \
  poppler-utils pdf2svg

echo "=== [2/6] Python rapide (uv) + environnement virtuel SymPy ==="
if ! command -v uv >/dev/null 2>&1; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi
export PATH="$HOME/.local/bin:$HOME/.elan/bin:$PATH"
export UV_LINK_MODE=copy

uv sync --frozen || uv sync
uv tool install --upgrade leanblueprint || true
uv tool install --upgrade lean-lsp-mcp || true
uv tool install --upgrade arxiv-mcp-server || true

echo "=== [3/6] Lean 4 (elan) ==="
if ! command -v elan >/dev/null 2>&1; then
  curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh -s -- -y --default-toolchain leanprover/lean4:stable
fi
export PATH="$HOME/.elan/bin:$PATH"

echo "=== [4/6] Harnais IA CLI (Copilot, Claude Code, Codex) ==="
if [ -w "$(npm prefix -g 2>/dev/null || echo /usr/local)" ]; then
  npm install -g @github/copilot @anthropic-ai/claude-code @openai/codex || true
else
  sudo "$(command -v npm)" install -g @github/copilot @anthropic-ai/claude-code @openai/codex || true
fi

echo "=== [5/6] Liens symboliques unifiés (AGENTS.md & skills) ==="
bash "$REPO_ROOT/scripts/lier-instructions.sh"

echo "=== [6/6] Préparation du projet Lean 4 et cache Mathlib ==="
if [ -d "$REPO_ROOT/preuves" ] && [ -f "$REPO_ROOT/scripts/activer-mathlib.sh" ]; then
  bash "$REPO_ROOT/scripts/activer-mathlib.sh" || true
fi

echo "=== Validation finale ==="
bash "$REPO_ROOT/scripts/valider-setup.sh" || true
