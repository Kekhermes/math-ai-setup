#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BP_DIR="$REPO_ROOT/preuves/blueprint"

if ! command -v leanblueprint >/dev/null 2>&1; then
  echo "Erreur : leanblueprint n'est pas installé (l'environnement DevContainer l'installe automatiquement)."
  exit 1
fi

if [ ! -d "$BP_DIR" ]; then
  echo "Aucun dossier preuves/blueprint/ n'existe encore."
  echo "Pour initialiser un blueprint dans preuves/, demandez à l'assistant : « Initialise un Lean Blueprint dans preuves/ »."
  exit 0
fi

cd "$REPO_ROOT/preuves"
leanblueprint pdf
leanblueprint web
echo "Blueprint généré dans $BP_DIR/web/ et $BP_DIR/print/"
