#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PREUVES_DIR="$REPO_ROOT/preuves"
cd "$PREUVES_DIR"

if ! grep -q 'name = "mathlib"' lakefile.toml; then
  cat >> lakefile.toml <<'EOF'

[[require]]
name = "mathlib"
scope = "leanprover-community"
EOF
fi

echo "=== Mise à jour et téléchargement du cache Mathlib ==="
lake update mathlib || true
lake exe cache get || true
lake build || true
