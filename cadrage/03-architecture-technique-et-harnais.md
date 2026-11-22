# Architecture Technique, DevContainer et Multi-Harnais

---

## 1. Architecture VS Code Agent Host & Compatibilité Multi-Harnais

### 1.1 Principe « 1 seul abonnement suffit »
L'utilisateur ouvre un seul éditeur (**VS Code** dans le DevContainer) et choisit dans le sélecteur de session (*Session Target*) le harnais correspondant à la licence dont il dispose :

| Harnais | Licence compatible | Extension / CLI dans le conteneur | Notes techniques vérifiées |
|---|---|---|---|
| **GitHub Copilot** | Copilot Pro (gratuit via *GitHub Education* enseignant/chercheur), Free (limité), Pro+, Max | Extensions `GitHub.copilot` + `GitHub.copilot-chat` + CLI `@github/copilot` | Support natif de `AGENTS.md` et `.github/skills/`. Sert aussi de routeur pour Claude/Codex (mais Codex via Copilot exige **Copilot Pro+**). |
| **Claude Code** | Claude Pro / Max / Ultra, Claude Team for Scientists, Claude for Education SSO, ou clé API Anthropic | CLI `@anthropic-ai/claude-code` + harnais Agent Host VS Code (`chat.agentHost.claudeAgent.enabled`) | **Attention :** dans VS Code Agent Host, le harnais Claude utilise soit Copilot, soit une clé API (`ANTHROPIC_API_KEY`). En terminal intégré (`claude`), l'abonnement Pro/Max/Team/Edu fonctionne directement via `claude auth login` (sans clé API). |
| **OpenAI Codex** | ChatGPT Plus / Pro / Edu (ou clé API OpenAI) | CLI `@openai/codex` + (au choix) extension OpenAI Codex ou `chat.agentHost.codexAgent.enabled` | Fonctionne avec login ChatGPT direct (`codex login --device-auth` en conteneur). Ne pas activer simultanément l'extension Codex et l'Agent Host Codex sans `chat.editor.codex.preferAgentHost`. |

### 1.2 Source unique d'instructions et de skills
Pour éviter toute divergence entre harnais, le dépôt maintient **une seule source canonique** :

- **Instructions permanentes :** `AGENTS.md` à la racine du workspace.
  - Liens symboliques créés automatiquement au setup :
    - `CLAUDE.md -> AGENTS.md`
    - `.github/copilot-instructions.md -> ../AGENTS.md`
- **Skills modulaires (chargés à la demande) :** stockés dans `.github/skills/<nom-skill>/SKILL.md`.
  - Liens symboliques créés automatiquement :
    - `.claude/skills -> ../.github/skills`
    - `.agents/skills -> ../.github/skills` (convention Codex CLI)
  - Paramètre VS Code activé : `"chat.useAgentSkills": true` et `"chat.agentSkillsLocations"`.

### 1.3 Mode Solo vs Mode Duo Adversarial (optionnel)
- **Mode Solo (nominal — 1 seul abonnement) :** toutes les tâches (y compris *Juge de fidélité* et *Critique mathématique*) fonctionnent sur l'unique harnais disponible, en lançant une **nouvelle conversation vierge** (ou un sous-agent isolé quand le harnais le supporte) pour éviter la contamination de contexte.
- **Mode Duo Adversarial (optionnel — si le chercheur a 2 abonnements, ex. Claude + Codex ou Copilot + Codex) :** un second harnais dans un onglet/session parallèle audite la preuve ou l'article produit par le premier (modèle inspiré de `morankor/theorist-toolbox`).

---

## 2. Spécification corrigée du DevContainer

### 2.1 `.devcontainer/devcontainer.json` (spécification cible)
- **Image de base :** `mcr.microsoft.com/devcontainers/base:ubuntu-24.04`
- **Features :**
  - `ghcr.io/devcontainers/features/node:1` (`version: "22"`)
  - `ghcr.io/devcontainers/features/python:1` (`version: "3.12"`)
  - `ghcr.io/devcontainers/features/github-cli:1`
- **Volumes Docker persistants (`mounts`) :**
  - `math-elan-${devcontainerId}` → `/home/vscode/.elan` (toolchains Lean 4)
  - `math-copilot-${devcontainerId}` → `/home/vscode/.copilot`
  - `math-claude-${devcontainerId}` → `/home/vscode/.claude`
  - `math-codex-${devcontainerId}` → `/home/vscode/.codex`
  - `math-uv-cache-${devcontainerId}` → `/home/vscode/.cache/uv` (accélère `uvx` et les paquets Python)
- **Note importante sur le cache Mathlib :** le dossier `.lake/` du projet Lean dans `preuves/` reste sur le système de fichiers du workspace monté afin que l'éditeur et `lake` y accèdent directement sans copie supplémentaire.
- **Extensions VS Code installées d'office :**
  - `leanprover.lean4`
  - `James-Yu.latex-workshop`
  - `GitHub.copilot`
  - `GitHub.copilot-chat`
  - `streetsidesoftware.code-spell-checker` + `streetsidesoftware.code-spell-checker-french` (confort rédactionnel français/anglais)
- **Réglages VS Code par défaut (`.devcontainer/devcontainer.json` / `.vscode/settings.json`) :**
  - `"chat.useAgentSkills": true`
  - `"chat.useAgentsMdFile": true`
  - `"latex-workshop.latex.autoBuild.run": "onSave"`
  - `"latex-workshop.view.pdf.viewer": "tab"`
  - `"chat.agentHost.claudeAgent.enabled": true`

### 2.2 `.devcontainer/setup.sh` (corrections par rapport à `first-conv.md`)
1. **Paquets système (`apt-get`) :**
   - `ripgrep curl git jq graphviz`
   - `texlive-latex-extra texlive-science texlive-bibtex-extra texlive-fonts-recommended texlive-lang-french latexmk biber` *(ajout de `texlive-lang-french` pour les cours et articles en français !)*
   - `poppler-utils pdf2svg` *(ajout indispensables pour `pdftoppm` — contrôle visuel TikZ et audit visuel de slides Beamer)*
2. **Python via `uv` (correction du bug `uv tool install sympy` de `first-conv.md`) :**
   - Installer `uv` (`https://astral.sh/uv/install.sh`).
   - Créer un environnement virtuel projet `.venv` via `uv sync` à partir d'un `pyproject.toml` à la racine incluant : `sympy`, `numpy`, `scipy`, `matplotlib` (et `ipykernel` si besoin de scripts).
   - Installer les outils CLI indépendants via `uv tool install` : `leanblueprint` (et pré-chauffer `lean-lsp-mcp` et `arxiv-mcp-server` via `uv tool install` ou `uvx`).
3. **Lean 4 & Mathlib (toujours complet dès le départ, D-07) :**
   - Installer `elan` (`leanprover/lean4:stable`).
   - Initialiser ou préparer le projet Lean du Hub (`preuves/`) avec `lean-toolchain` épinglé et exécuter `lake exe cache get` + `lake build` dès le `postCreateCommand` pour que la session de Kevin livre un cache Mathlib déjà chaud.
4. **Harnais CLI :**
   - `npm install -g @github/copilot @anthropic-ai/claude-code @openai/codex`
5. **Liens symboliques & validation :**
   - Créer les symlinks `CLAUDE.md`, `.github/copilot-instructions.md`, `.claude/skills`, `.agents/skills`.
   - Exécuter `bash scripts/valider-setup.sh --quiet` en fin d'installation pour produire un rapport d'état lisible.

---

## 3. Serveurs MCP configurés (`.mcp.json` à la racine)

Format portable natif du runtime Agent Host Copilot et de Claude Code (remplace l'ancien `.vscode/mcp.json` déprécié) :

```json
{
  "mcpServers": {
    "lean-lsp": {
      "type": "stdio",
      "command": "uvx",
      "args": ["lean-lsp-mcp"],
      "tools": ["*"]
    },
    "arxiv": {
      "type": "stdio",
      "command": "bash",
      "args": ["scripts/run-arxiv-mcp.sh"],
      "tools": ["*"]
    }
  }
}
```

- **`lean-lsp-mcp` :** donne accès aux buts Lean (`lean_goal`), diagnostics, `lean_multi_attempt`, `leanSearch`, `loogle`, `lean_verify`. *Prérequis :* `lake build` initial déjà exécuté dans `preuves/`.
- **`arxiv-mcp-server` :** recherche arXiv, lecture section par section du **LaTeX source des auteurs** (`get_paper_latex`), export BibTeX officiel (`export_citations`), graphe de citations Semantic Scholar. Le stockage est mis dans `.cache/arxiv-papers` (ignoré par `.gitignore`) pour rester propre dans le Hub.
- **Note compatibilité CLI :** prévoir également un petit script d'enregistrement MCP (ou configuration `.mcp.json` / `~/.codex/config.toml`) si le chercheur utilise Claude Code CLI ou Codex CLI directement.

---

## 4. Rôles isolés (Architecture logique des agents)

Inspirée de *Theo*, `theorist-toolbox` et `pedrohcgs/claude-code-my-workflow`, l'architecture distingue **6 rôles stricts** à contexte séparé (implémentés par sous-agents lorsque le harnais le permet, ou par sessions de chat dédiées guidées par le Skill Helper) :

| Rôle | Contexte visible | Interdictions strictes | Critère de validation |
|---|---|---|---|
| **1. Guide / Helper** | Tout le workspace + diagnostic setup | Ne modifie jamais de preuves ou d'énoncés sans demande. | L'utilisateur comprend la prochaine étape en 1 action. |
| **2. Formalisateur Lean** | Énoncé `.tex` + `preuves/` + `lean-lsp-mcp` | Ne modifie jamais l'énoncé `.tex` pour faciliter la preuve. | Compile avec `sorry` explicites ou preuve complète. |
| **3. Juge de fidélité (contexte vierge)** | **Uniquement** le `.tex` source et le fichier `.lean` final (pas l'historique du formalisateur) | Ne corrige pas la preuve ; rend un verdict binaire + liste d'écarts d'hypothèses. | Retraduction fidèle en français/anglais mathématique validée. |
| **4. Prouveur Lean** | Fichier `.lean` + `lean-lsp-mcp` | Ne modifie pas la signature du théorème (`header` immuable). | `lake build` vert, zéro `sorry`, `#print axioms` standard. |
| **5. Critique mathématique / Rapporteur (contexte vierge)** | Brouillon `.tex` + grille (ANR/ERC ou rigueur math) — **sans accès au Lean** | Ne valide jamais un « clairement » non justifié ; balise les trous avec `\unproven{}`. | Rapport structuré par sévérité (bloquant / mineur / style). |
| **6. Auditeur pédagogique & visuel** | Slides Beamer / TD `.tex` + images PNG issues de `pdftoppm` | Ne change pas le contenu scientifique sans accord. | Zéro débordement de slide, progression claire, sujet/corrigé séparés. |
