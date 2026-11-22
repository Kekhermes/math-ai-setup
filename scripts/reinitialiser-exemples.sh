#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Impossible de réinitialiser automatiquement via Git (dépôt Git non initialisé)."
  exit 1
fi

if ! git ls-files --error-unmatch exemples/LISEZ-MOI.md >/dev/null 2>&1; then
  echo "Le dossier exemples/ n'a pas encore été enregistré dans Git."
  echo "Effectuez d'abord une première sauvegarde Git pour figer l'état de référence."
  exit 1
fi

git checkout -- exemples/
echo "Le dossier exemples/ a été restauré à son état initial (recherches/, preuves/ et enseignement/ sont intacts)."
