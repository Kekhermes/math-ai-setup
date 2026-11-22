#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ] || [ -z "${1:-}" ]; then
  echo "Usage : bash scripts/compiler-sujet-corrige.sh <chemin/td-ou-examen.tex>"
  exit 1
fi

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="$(realpath "$1")"
if [ ! -f "$TARGET" ] || [[ "$TARGET" != *.tex ]]; then
  echo "Erreur : ouvrez un fichier TD ou Examen (.tex) avant de lancer cette tâche."
  exit 1
fi

DIR="$(dirname "$TARGET")"
BASE="$(basename "$TARGET" .tex)"
export TEXINPUTS="${REPO_ROOT}/preambles:${DIR}:"

cd "$DIR"

compile_variant() {
  local mode="$1"
  local suffix="$2"
  local flag_cmd="$3"
  local job="${BASE}-${suffix}"
  echo "=== Génération du PDF ($mode) -> ${job}.pdf ==="
  if command -v latexmk >/dev/null 2>&1; then
    latexmk -pdf -interaction=nonstopmode -halt-on-error -jobname="$job" \
      -pdflatex="pdflatex %O \"${flag_cmd}\\input{%S}\"" "$BASE.tex"
  else
    pdflatex -interaction=nonstopmode -halt-on-error -jobname="$job" "${flag_cmd}\\input{${BASE}.tex}"
    pdflatex -interaction=nonstopmode -halt-on-error -jobname="$job" "${flag_cmd}\\input{${BASE}.tex}"
  fi
}

compile_variant "Sujet seul (sans corrigé)" "sujet" "\\def\\FORCERCORRIGES{0}"
compile_variant "Version avec corrigés" "corrige" "\\def\\FORCERCORRIGES{1}"

echo ""
echo "Terminé :"
echo "  - Sujet seul : $DIR/${BASE}-sujet.pdf"
echo "  - Corrigé    : $DIR/${BASE}-corrige.pdf"
