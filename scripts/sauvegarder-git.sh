#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Ce dossier n'est pas encore relié à Git."
  echo "Demandez à Kevin ou à l'assistant : « Initialise le dépôt Git privé pour ce workspace »."
  exit 1
fi

echo "=== Fichiers modifiés ou ajoutés ==="
STATUS="$(git status --short)"
if [ -z "$STATUS" ]; then
  echo "Aucune modification à sauvegarder : tout est déjà à jour."
  exit 0
fi
echo "$STATUS"
echo ""

read -r -p "Voulez-vous sauvegarder ces modifications localement (commit) ? [o/N] " REP
if [[ ! "$REP" =~ ^[oOyY]$ ]]; then
  echo "Sauvegarde annulée. Aucun fichier n'a été modifié."
  exit 0
fi

read -r -p "Décrivez en une phrase ce que vous venez de faire (ex: Brouillon section 2) : " MSG
if [ -z "$MSG" ]; then
  MSG="Sauvegarde d'étape ($(date '+%Y-%m-%d %H:%M'))"
fi

# Ajout ciblé : respecte .gitignore et exclut fichiers temporaires
git add -u
git add recherches/ preuves/ enseignement/ exemples/ preambles/ AGENTS.md GUIDE-DEMARRAGE.md ANNEXE-LICENCES.md 2>/dev/null || true

if git diff --cached --quiet; then
  echo "Aucun fichier suivi/autorisé à enregistrer."
  exit 0
fi

git commit -m "$MSG"
echo "Sauvegarde locale enregistrée."

if git remote get-url origin >/dev/null 2>&1; then
  read -r -p "Voulez-vous aussi envoyer cette sauvegarde sur GitHub (git push) ? [o/N] " PUSH_REP
  if [[ "$PUSH_REP" =~ ^[oOyY]$ ]]; then
    git push
    echo "Synchronisé sur GitHub."
  else
    echo "Sauvegarde conservée en local uniquement."
  fi
fi
