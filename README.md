# `math-ai-setup` — Bureau de recherche mathématique augmenté

Bienvenue dans votre espace de travail tout-en-un pour la **recherche mathématique**, la **preuve formelle en Lean 4**, la **rédaction LaTeX (articles & subventions)**, la **bibliographie arXiv** et l'**enseignement (Beamer, TD & examens)**.

## Prérequis sur la machine (Windows ou macOS)

> Pour le chercheur : cette installation est réalisée **une seule fois** lors de la session de mise en place initiale ; au quotidien, rien d'autre n'est à installer.

1. **Docker Desktop** (indispensable pour lancer le DevContainer tout-en-un) :
   - **Windows :** installer [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop/) (active automatiquement le sous-système Linux **WSL 2** ; prévoir un redémarrage du PC si demandé) et le laisser démarré avant d'ouvrir VS Code.
   - **macOS :** installer [Docker Desktop for Mac](https://www.docker.com/products/docker-desktop/) (choisir Apple Silicon M1/M2/M3/M4 ou Intel selon le Mac) et le lancer.
   - **Espace disque :** prévoir **au moins 15 Go libres** (image Ubuntu + TeX Live + Lean 4 + cache Mathlib).
2. **Git** :
   - **Windows :** installer [Git for Windows](https://git-scm.com/downloads/win).
   - **macOS :** `xcode-select --install` dans le Terminal (ou via Homebrew `brew install git`).
3. **Visual Studio Code + extension Dev Containers :**
   - Installer [VS Code](https://code.visualstudio.com/), puis installer l'extension officielle **`Dev Containers`** (`ms-vscode-remote.remote-containers`).
4. **Compte GitHub + au moins 1 licence IA** (voir [`ANNEXE-LICENCES.md`](ANNEXE-LICENCES.md) — GitHub Copilot Pro est gratuit pour les enseignants/chercheurs vérifiés).

## Par où commencer ?
1. **Nouveau dans cet espace ?** Lisez [`GUIDE-DEMARRAGE.md`](GUIDE-DEMARRAGE.md) (2 minutes).
2. **Besoin de connecter un compte IA (Copilot, Claude, Codex) ?** Lisez [`ANNEXE-LICENCES.md`](ANNEXE-LICENCES.md).
3. **Apprendre par la pratique :** ouvrez le dossier [`exemples/LISEZ-MOI.md`](exemples/LISEZ-MOI.md).

## Structure de votre espace
- `exemples/` — Module 0 d'initiation à Lean 4 + 3 scénarios guidés pour prendre l'outil en main sans risque.
- `recherches/` — Vos articles scientifiques, notes et dossiers de subventions (ANR, ERC).
- `preuves/` — Vos projets de formalisation Lean 4 (+ Lean Blueprints).
- `enseignement/` — Vos cours Beamer, planches de TD et examens (avec génération automatique Sujet + Corrigé).
- `preambles/` — Modèles LaTeX prêts à l'emploi.
- `cadrage/` — Documentation de conception initiale du projet.
