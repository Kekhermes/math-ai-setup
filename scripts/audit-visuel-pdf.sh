#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ] || [ -z "${1:-}" ]; then
  echo "Usage : bash scripts/audit-visuel-pdf.sh <fichier.pdf>"
  exit 1
fi

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PDF="$(realpath "$1")"
if [ ! -f "$PDF" ]; then
  echo "Erreur : PDF introuvable : $1"
  exit 1
fi

STEM="$(basename "$PDF" .pdf)"
DIR="$(dirname "$PDF")"
OUT_DIR="$REPO_ROOT/.audit-visuel/$STEM"
rm -rf "$OUT_DIR"
mkdir -p "$OUT_DIR"

echo "=== Conversion en PNG (150 DPI) ==="
pdftoppm -png -r 150 "$PDF" "$OUT_DIR/page"
ls -1 "$OUT_DIR"/page*.png

LOG_FILE="$DIR/$STEM.log"
if [ -f "$LOG_FILE" ]; then
  echo ""
  echo "=== Alertes de débordement dans $STEM.log ==="
  grep -nE "Overfull \\\\hbox|Overfull \\\\vbox" "$LOG_FILE" || echo "Aucun débordement signalé dans le log."
fi
