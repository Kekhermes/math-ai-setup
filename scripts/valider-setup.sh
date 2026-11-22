#!/usr/bin/env bash
set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

OK_COUNT=0
WARN_COUNT=0
ERR_COUNT=0

ok()   { printf "  [OK]        %-32s %s\n" "$1" "${2:-}"; OK_COUNT=$((OK_COUNT+1)); }
warn() { printf "  [ATTENTION] %-32s %s\n" "$1" "${2:-}"; WARN_COUNT=$((WARN_COUNT+1)); }
err()  { printf "  [MANQUANT]  %-32s %s\n" "$1" "${2:-}"; ERR_COUNT=$((ERR_COUNT+1)); }

echo "====================================================================="
echo " Diagnostic du bureau de recherche math-ai-setup"
echo "====================================================================="

echo ""
echo "1. Outils de base & synchronisation des règles :"
command -v git >/dev/null 2>&1 && ok "Git" "$(git --version | head -n1)" || err "Git" "Installez git"
command -v gh  >/dev/null 2>&1 && ok "GitHub CLI (gh)" "$(gh --version | head -n1)" || warn "GitHub CLI (gh)" "Optionnel hors DevContainer"
if [ -L CLAUDE.md ] && [ -L .github/copilot-instructions.md ] && [ -L .claude/skills ] && [ -L .agents/skills ]; then
  ok "Liens AGENTS.md & skills" "Synchronisés"
else
  warn "Liens AGENTS.md & skills" "Lancez : bash scripts/lier-instructions.sh"
fi

echo ""
echo "2. Chaîne LaTeX & audit visuel :"
if command -v latexmk >/dev/null 2>&1; then
  ok "latexmk" "$(latexmk --version | head -n1)"
elif command -v pdflatex >/dev/null 2>&1; then
  warn "pdflatex (sans latexmk)" "Fonctionnel via scripts/compiler-latex.sh ; installez latexmk dans le DevContainer"
else
  err "LaTeX (pdflatex/latexmk)" "Ouvrez le projet dans le DevContainer"
fi
command -v biber >/dev/null 2>&1 && ok "biber" "Installé" || warn "biber" "Recommandé pour BibLaTeX (inclus dans DevContainer)"
command -v pdftoppm >/dev/null 2>&1 && ok "pdftoppm (audit PNG)" "Installé" || err "pdftoppm" "Paquet poppler-utils requis"
command -v pdf2svg >/dev/null 2>&1 && ok "pdf2svg" "Installé" || warn "pdf2svg" "Inclus dans le DevContainer"

echo ""
echo "3. Lean 4 & outils formels :"
command -v elan >/dev/null 2>&1 && ok "elan" "$(elan --version | head -n1)" || err "elan" "Toolchain Lean 4 manquante"
command -v lean >/dev/null 2>&1 && ok "lean" "$(lean --version | head -n1)" || err "lean" "Compilateur Lean 4 manquant"
command -v lake >/dev/null 2>&1 && ok "lake" "$(lake --version | head -n1)" || err "lake" "Outil de build Lean manquant"
command -v leanblueprint >/dev/null 2>&1 && ok "leanblueprint" "Installé" || warn "leanblueprint" "Installé automatiquement dans le DevContainer (uv tool install leanblueprint)"

echo ""
echo "4. Python & calcul symbolique (SymPy) :"
command -v uv >/dev/null 2>&1 && ok "uv" "$(uv --version | head -n1)" || warn "uv" "Requis pour MCP (uvx) et .venv"
if [ -x "$REPO_ROOT/.venv/bin/python" ] && "$REPO_ROOT/.venv/bin/python" -c "import sympy" >/dev/null 2>&1; then
  SYMPY_V="$("$REPO_ROOT/.venv/bin/python" -c "import sympy; print(sympy.__version__)")"
  ok "Python .venv + SymPy" "v$SYMPY_V"
elif python3 -c "import sympy" >/dev/null 2>&1; then
  warn "Python système + SymPy" "Préférez créer .venv avec : uv sync"
else
  err "SymPy (.venv)" "Lancez : uv sync"
fi

echo ""
echo "5. Assistants IA (1 seul actif suffit) :"
FOUND_HARNESS=0
if command -v copilot >/dev/null 2>&1 || gh copilot --version >/dev/null 2>&1; then
  ok "GitHub Copilot CLI" "Installé"
  FOUND_HARNESS=1
else
  warn "GitHub Copilot CLI" "Utilisable via l'extension VS Code ou npm install -g @github/copilot"
fi
if command -v claude >/dev/null 2>&1; then
  ok "Claude Code CLI" "$(claude --version 2>/dev/null | head -n1 || echo 'installé')"
  FOUND_HARNESS=1
else
  warn "Claude Code CLI" "Optionnel si vous utilisez Copilot ou Codex"
fi
if command -v codex >/dev/null 2>&1; then
  ok "OpenAI Codex CLI" "$(codex --version 2>/dev/null | head -n1 || echo 'installé')"
  FOUND_HARNESS=1
else
  warn "OpenAI Codex CLI" "Optionnel si vous utilisez Copilot ou Claude"
fi
if [ -n "${ANTHROPIC_API_KEY:-}" ]; then
  warn "Variable ANTHROPIC_API_KEY" "Détectée ! Si vous avez un abonnement Claude Pro/Max/Team, supprimez cette variable pour éviter la facturation API."
fi

echo ""
echo "====================================================================="
echo " Bilan : $OK_COUNT OK | $WARN_COUNT avertissement(s) | $ERR_COUNT manquant(s)"
if [ "$ERR_COUNT" -eq 0 ]; then
  echo " -> Environnement opérationnel."
else
  echo " -> Conseil : ouvrez le projet dans le DevContainer (icône >< en bas à gauche)."
fi
echo "====================================================================="
exit 0
