# La question :

Ok donc Je voudrais mettre en place pour le harnais Github Copilote de VSCode. De mémoire ce harnais peut être branché a Claude code et Codex, a vérifier. Je voudrais mettre en place une stack DevContainer afin de faire de la recherche en mathématiques basé sur un des framework de boucle agentique connu, prendre le plus adapté. Je veux y faire :
- de la rédaction et vérification de preuves Lean
- de la rédaction de papier scientifiques / demande de subvention Latex
- de la recherche de littérature 
- ... Et tout autre processus utile a la recherche en mathématiques, j4 suis ouvert à suggestions

# La réponse :

Oui, VS Code permet désormais de piloter **GitHub Copilot**, **Claude Code** et **Codex** depuis une interface unique. Depuis l'introduction du protocole *Agent Host* (AHP 1.0) et de la fenêtre *Agents* (`code --agents`), le sélecteur de harnais (*Session Target*) permet de lancer des sessions sur l'un ou l'autre de ces moteurs dans le même espace de travail, y compris en parallèle sur des *git worktrees* isolés.

Trois points techniques encadrent toutefois cette cohabitation :

* **Accès et facturation :** vous pouvez utiliser Claude et Codex soit à travers votre abonnement GitHub Copilot (via *Agent HQ*, décompté sur votre quota de requêtes premium), soit en authentifiant directement les CLI dans le conteneur avec vos propres comptes ou clés API Anthropic et OpenAI.
* **Cloisonnement des mémoires :** les trois harnais ne partagent ni leur historique ni leurs fichiers d'instructions natifs (`AGENTS.md` pour Codex, `CLAUDE.md` pour Claude Code, `.github/copilot-instructions.md` pour Copilot). La bonne pratique consiste à maintenir un unique fichier `AGENTS.md` à la racine et à créer des liens symboliques (`ln -s AGENTS.md CLAUDE.md`, etc.) dans le conteneur.
* **Portée des sous-agents :** la délégation automatique de sous-agents reste interne à chaque harnais. Votre orchestrateur principal doit donc tourner sur un harnais capable d'isoler le contexte de ses sous-agents (Copilot en mode Agent ou Claude Code), tandis que vous pouvez ouvrir une session Codex en parallèle sur un *worktree* dédié pour explorer une piste de preuve alternative.

---

## 1. Le cadre agentique le plus adapté à la recherche mathématique

Plutôt que d'utiliser un harnais généraliste tel quel, l'architecture la plus efficace pour les mathématiques combine la discipline par artefacts de **Superpowers** (`obra/superpowers`) avec le double pipeline d'autoformalisation de type **Theo** (introduit en 2026 pour la formalisation d'articles de recherche) :

1. **La compilation Lean comme test TDD bloquant :** dans Superpowers, aucune étape n'est validée sans test vert. Ici, le critère d'arrêt objectif est `lake build` sans erreur, sans `sorry` et sans axiome hors du noyau standard de Lean (`#print axioms`).
2. **Séparation stricte en quatre rôles à contexte isolé (style Goldfish) :** laisser un seul agent tenter une preuve complète sature sa mémoire avec les erreurs de tactiques. On découpe donc la boucle en quatre agents :
* **Formalisateur d'énoncés :** traduit les définitions et théorèmes LaTeX en signatures Lean 4.
* **Juge de fidélité (*Faithfulness Judge*, contexte vierge) :** lit uniquement le code Lean généré, le retraduit en mathématiques informelles et vérifie qu'aucune hypothèse n'a été oubliée ou affaiblie par rapport au `.tex`.
* **Architecte & Prouveur :** décompose le théorème en lemmes intermédiaires (équivalents des tests unitaires) et interagit avec le serveur LSP Lean.
* **Critique mathématique (contexte vierge, sans accès au code Lean) :** audite la démonstration rédigée en LaTeX sur le plan purement mathématique (cas dégénérés, quantificateurs, dépendances circulaires).



---

## 2. Stack DevContainer prête à l'emploi

Cette configuration installe Lean 4 (`elan`), TeX Live, Python (`uv` + `sympy`), les trois harnais CLI et monte des volumes Docker persistants pour conserver vos sessions, authentifications et caches Mathlib d'un *rebuild* à l'autre.

**`.devcontainer/devcontainer.json`**

```json
{
  "name": "Math Research Agentic Stack",
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu-24.04",
  "features": {
    "ghcr.io/devcontainers/features/node:1": { "version": "22" },
    "ghcr.io/devcontainers/features/python:1": { "version": "3.12" },
    "ghcr.io/devcontainers/features/github-cli:1": {}
  },
  "postCreateCommand": "bash .devcontainer/setup.sh",
  "mounts": [
    "source=math-elan-${devcontainerId},target=/home/vscode/.elan,type=volume",
    "source=math-copilot-${devcontainerId},target=/home/vscode/.copilot,type=volume",
    "source=math-claude-${devcontainerId},target=/home/vscode/.claude,type=volume",
    "source=math-codex-${devcontainerId},target=/home/vscode/.codex,type=volume"
  ],
  "remoteEnv": {
    "PATH": "/home/vscode/.elan/bin:/home/vscode/.local/bin:${containerEnv:PATH}"
  },
  "customizations": {
    "vscode": {
      "settings": {
        "chat.useAgentSkills": true,
        "latex-workshop.latex.autoBuild.run": "onSave"
      },
      "extensions": [
        "leanprover.lean4",
        "James-Yu.latex-workshop",
        "GitHub.copilot",
        "GitHub.copilot-chat"
      ]
    }
  }
}

```

**`.devcontainer/setup.sh`**

```bash
#!/usr/bin/env bash
set -euo pipefail

sudo apt-get update && sudo apt-get install -y --no-install-recommends \
  ripgrep curl git jq graphviz \
  texlive-latex-extra texlive-science texlive-bibtex-extra \
  texlive-fonts-recommended latexmk biber

# Gestionnaire Python rapide + calcul symbolique
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"
uv tool install sympy
uv tool install leanblueprint

# Toolchain Lean 4 (elan)
curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh -s -- -y --default-toolchain leanprover/lean4:stable

# Harnais CLI (Copilot, Claude Code, Codex)
npm install -g @github/copilot @anthropic-ai/claude-code @openai/codex

# Si un projet Lean est déjà présent, récupérer le cache Mathlib
if [ -f "lakefile.toml" ] || [ -f "lakefile.lean" ]; then
  lake exe cache get || true
  lake build || true
fi

```

**`.vscode/mcp.json` (ponts outils pour les agents)**

```json
{
  "servers": {
    "lean-lsp": {
      "type": "stdio",
      "command": "uvx",
      "args": ["lean-lsp-mcp"]
    },
    "arxiv": {
      "type": "stdio",
      "command": "uvx",
      "args": ["arxiv-mcp-server"]
    }
  }
}

```

Le serveur `lean-lsp-mcp` expose directement aux agents l'état des buts (*goal states*), les diagnostics du compilateur, l'outil `lean_multi_attempt` (qui teste plusieurs tactiques sur une ligne en une passe) ainsi que les moteurs **Loogle** et **LeanSearch** pour interroger Mathlib.

---

## 3. Organisation des processus et suggestions complémentaires

| Domaine | Workflow recommandé dans le conteneur |
| --- | --- |
| **Preuves Lean 4** | Utilisez **Lean Blueprint** (`leanblueprint`) pour lier chaque `\begin{theorem}` de votre fichier `.tex` à sa déclaration Lean via `\lean{...}` et `\leanok`. L'agent génère un graphe de dépendances visuel montrant exactement quels lemmes bloquent le théorème principal. |
| **Articles & Subventions (ANR, ERC)** | Séparez les fichiers de contenu (`sections/*.tex`) des grilles d'évaluation (`grants/criteria.md`). Faites auditer chaque brouillon par un sous-agent « rapporteur ERC/ANR » au contexte vierge qui vérifie l'adéquation entre les jalons annoncés, la faisabilité et les risques. |
| **Littérature & BibTeX** | Imposez une règle stricte dans `AGENTS.md` : interdiction d'écrire une clé `\cite{...}` à la volée. L'agent interroge d'abord le MCP arXiv / Semantic Scholar, récupère l'entrée BibTeX officielle, puis vérifie que l'énoncé exact cité figure bien dans le résumé ou le PDF source. |

### Trois processus additionnels à forte valeur ajoutée

* **Falsification rapide par calcul symbolique (pré-Lean) :** avant d'investir des heures dans la formalisation d'un lemme intermédiaire, demandez à l'agent d'écrire un script Python (`SymPy`) ou SageMath qui teste l'énoncé sur des petites dimensions, des corps finis $\mathbb{F}_p$ ou des matrices aléatoires. Éliminer une hypothèse trop optimiste en dix secondes économise des dizaines d'itérations Lean.
* **Détection de dérive sémantique (*Drift Report*) :** à mesure qu'un papier évolue, les notations du `.tex` divergent souvent des définitions Lean. Planifiez une commande dédiée qui compare vos macros LaTeX (`macros.tex`) et vos structures Lean pour signaler toute hypothèse ajoutée dans le code mais oubliée dans l'article.
* **Génération de diagrammes commutatifs et figures avec contrôle visuel :** pour les diagrammes `tikz-cd` ou graphiques asymptotiques complexes, faites compiler l'agent en PDF, convertir la page en PNG (`pdftoppm -png`) et relire l'image produite pour corriger les chevauchements d'étiquettes avant intégration.
