#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

if [ $# -ge 1 ] && [ -n "${1:-}" ]; then
  TARGET="$(realpath "$1")"
  echo "Vérification du fichier Lean : $TARGET"
  lean "$TARGET"
  if grep -nE '\b(sorry|admit)\b' "$TARGET"; then
    echo "ATTENTION : le fichier contient encore au moins un sorry/admit."
    exit 2
  fi
  echo "OK : aucune erreur et aucun sorry dans $TARGET."
  exit 0
fi

if [ ! -d "$REPO_ROOT/preuves" ]; then
  echo "Dossier preuves/ introuvable."
  exit 1
fi

echo "=== Vérification complète dans preuves/ (lake build) ==="
(cd "$REPO_ROOT/preuves" && lake build)

echo "=== Recherche de sorry / admit résiduels dans preuves/ ==="
if grep -rnE '\b(sorry|admit)\b' "$REPO_ROOT/preuves" --include="*.lean"; then
  echo "ATTENTION : des preuves restent incomplètes (sorry/admit ci-dessus)."
  exit 2
else
  echo "OK : build Lean vert et aucun sorry résiduel dans preuves/."
fi
