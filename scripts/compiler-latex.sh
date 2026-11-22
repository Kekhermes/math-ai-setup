#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ] || [ -z "${1:-}" ]; then
  echo "Usage : bash scripts/compiler-latex.sh <chemin/fichier.tex>"
  exit 1
fi

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="$(realpath "$1")"
if [ ! -f "$TARGET" ]; then
  echo "Erreur : fichier introuvable : $1"
  exit 1
fi
if [[ "$TARGET" != *.tex ]]; then
  echo "Erreur : veuillez ouvrir un fichier .tex avant de lancer la compilation (fichier actif : $1)."
  exit 1
fi

DIR="$(dirname "$TARGET")"
BASE="$(basename "$TARGET" .tex)"
export TEXINPUTS="${REPO_ROOT}/preambles:${DIR}:"

cd "$DIR"
echo "Compilation de $BASE.tex ..."
if command -v latexmk >/dev/null 2>&1; then
  latexmk -pdf -interaction=nonstopmode -halt-on-error "$BASE.tex"
else
  pdflatex -interaction=nonstopmode -halt-on-error "$BASE.tex"
  if grep -q '\\bibliography{' "$BASE.tex" && command -v bibtex >/dev/null 2>&1; then
    bibtex "$BASE" || true
  fi
  pdflatex -interaction=nonstopmode -halt-on-error "$BASE.tex"
  pdflatex -interaction=nonstopmode -halt-on-error "$BASE.tex"
fi

echo "PDF généré : $DIR/$BASE.pdf"
