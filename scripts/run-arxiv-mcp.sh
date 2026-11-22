#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CACHE_DIR="$REPO_ROOT/.cache/arxiv-papers"
mkdir -p "$CACHE_DIR"

exec uvx arxiv-mcp-server --storage-path "$CACHE_DIR" "$@"
