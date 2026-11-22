# Cadrage — `math-ai-setup` : Index et Registre des Décisions

> **Statut :** Livrable de cadrage complet (hors implémentation).
> **Langue :** Français (cadrage et futur dépôt cible `math-ai-setup`).
> **Source initiale conservée :** `archive/first-conv.md` (préservée sans modification).

---

## 1. Ordre de lecture recommandé

1. **`00-index-et-registre-decisions.md`** (ce document) — Périmètre, décisions actées, écarts relevés dans `archive/first-conv.md` et checklist de cohérence.
2. **`01-etat-de-l-art-open-source.md`** — Benchmark approfondi des solutions non commerciales existantes (Lean 4, recherche théorique, rédaction LaTeX, enseignement) et matrice de réutilisation.
3. **`02-persona-ux-et-parcours.md`** — Profil du chercheur, frontière entre la session d'installation de Kevin et l'autonomie quotidienne, architecture du Hub multi-projets et garde-fous.
4. **`03-architecture-technique-et-harnais.md`** — Stack DevContainer corrigée, VS Code Agent Host, stratégie multi-harnais agnostique, serveurs MCP, tâches 1-clic et rôles d'agents.
5. **`04-catalogue-skills-et-helper.md`** — Spécification du Skill Helper pédagogique et des 7 skills métier (dont la formation dédiée à Lean 4 via `tuteur-lean`, recherche, preuve Lean, SymPy, biblio, articles/subventions, enseignement).
6. **`05-dossier-apprentissage-par-exemples.md`** — Spécification du dossier `exemples/` (3 mini-scénarios guidés pas-à-pas).
7. **`06-annexe-licences-et-authentification.md`** — Guide complet des licences académiques et personnelles (GitHub Copilot, Anthropic Claude, OpenAI Codex) + checklist d'installation pour Kevin.
8. **`07-criteres-acceptation-et-prochaines-etapes.md`** — Critères d'acceptation vérifiables pour la phase d'implémentation future.

---

## 2. Périmètre et frontière d'intervention

- **Ce qui est livré maintenant :** uniquement le dossier `/cadrage` spécifiant l'architecture, l'UX, les skills, les exemples et les licences. Aucun squelette applicatif, conteneur ou exécution de modèle n'est lancé à ce stade.
- **Frontière de déploiement chez le chercheur :**
  - **Session initiale (réalisée par Kevin) :** installation de GitHub, VS Code, Docker/DevContainer, ouverture du workspace Hub et première authentification.
  - **Utilisation quotidienne (chercheur autonome) :** quasi zéro terminal ; pilotage par boutons/tâches VS Code, chat guidé et Skill Helper.

---

## 3. Registre des décisions actées

| ID | Thème | Décision actée | Source |
|---|---|---|---|
| **D-01** | Persona | Chercheur en mathématiques (recherche + enseignement éventuel) avec connaissances informatiques limitées **et profane en Lean 4**. | Exigence initiale + complément |
| **D-02** | Périmètre installation | Kevin installe GitHub + VS Code lors d'une session dédiée ; le chercheur doit ensuite être autonome. | Exigence initiale |
| **D-03** | Structure du dépôt | **Workspace unique multi-projets (« Hub »)** : 1 seul dépôt et 1 seul DevContainer avec sous-dossiers (`recherches/`, `preuves/`, `enseignement/`, `exemples/`), zéro rebuild Docker entre deux projets. | Arbitrage Vague 2 (Q1) |
| **D-04** | Expérience quotidienne (UX) | **VS Code tout-en-un** : boutons/tâches en 1 clic, chat guidé et Skill Helper très pédagogique, quasi zéro terminal au quotidien. | Arbitrage Vague 1 (Q2) |
| **D-05** | Périmètre Enseignement | **Complet LaTeX/Beamer** : cours/syllabus, diapositives Beamer, planches de TD et sujets d'examens avec corrigés masquables, revue pédagogique et audit visuel. | Arbitrage Vague 1 (Q3) |
| **D-06** | Harnais & licences | **Agnostique « 1 seul abonnement suffit »** : tout fonctionne avec Copilot seul, OU Claude Code seul, OU Codex seul ; mode duo/adversarial optionnel si plusieurs harnais sont connectés. | Arbitrage Vague 2 (Q2) |
| **D-07** | Stack Lean 4 / Mathlib | **Toujours complète dès le départ** : Lean 4 (`elan`), cache Mathlib pré-téléchargé et `leanblueprint` activés d'office dans le DevContainer. | Arbitrage Vague 2 (Q3) |
| **D-08** | Apprentissage par l'exemple | **3 mini-scénarios guidés** dans `exemples/` : (1) Preuve Lean + SymPy, (2) Article LaTeX + arXiv + Drift, (3) Cours Beamer + TD/corrigé, avec fichiers de départ, cible et prompts types. | Arbitrage Vague 2 (Q4) |
| **D-09** | Langue | **Tout en français** : cadrage, documentation, Skill Helper, autres skills, `AGENTS.md` et exemples (le chercheur reste libre de rédiger ses articles scientifiques en anglais dans `recherches/`). | Arbitrage Vague 1 (Q5) |
| **D-10** | Helper pédagogique | Présence obligatoire d'un **Skill Helper** dédié qui accueille, oriente, explique sans jargon et traduit les besoins en actions. | Exigence initiale |
| **D-11** | Annexe licences | Présence d'une annexe expliquant comment obtenir/activer les licences OpenAI/Codex, Claude Code et GitHub Copilot (y compris voies académiques gratuites/réduites). | Exigence initiale |
| **D-12** | État de l'art | Synthèse approfondie des solutions open-source non commerciales existantes pour en reprendre les meilleures pratiques. | Exigence initiale |
| **D-13** | Formation Lean 4 | Accompagnement pédagogique dédié à la montée en compétence sur Lean 4 (skill `tuteur-lean`, traduction de l'Infoview/erreurs en français, module d'initiation dédié). | Complément persona |

---

## 4. Audit de `archive/first-conv.md` : points validés vs écarts à corriger

L'extrait initial `archive/first-conv.md` pose une excellente base mais contient plusieurs affirmations à corriger ou nuancer avant implémentation :

| Élément de `archive/first-conv.md` | Verdict après vérification | Correction retenue dans ce cadrage |
|---|---|---|
| VS Code Agent Host (AHP 1.0) pilotant Copilot, Claude et Codex | **Validé** (l'architecture Agent Host et les adaptateurs Copilot/Claude/Codex existent dans VS Code). | Documenter les réglages exacts (`chat.agentHost.claudeAgent.enabled`, `chat.agentHost.codexAgent.enabled`) et noter que le routage Codex via Copilot exige **Copilot Pro+**, alors qu'un compte ChatGPT Plus/Pro/Edu fonctionne directement. |
| `AGENTS.md` + liens symboliques `CLAUDE.md` et `.github/copilot-instructions.md` | **Validé et renforcé**. | Conserver `AGENTS.md` comme source unique + liens symboliques pour compatibilité CLI, et utiliser les emplacements de skills reconnus par VS Code (`chat.agentSkillsLocations` : `.github/skills/`, `.claude/skills/`, `.agents/skills/`). |
| `lean-lsp-mcp` et `arxiv-mcp-server` via `uvx` | **Validé**. | `oOo0oOo/lean-lsp-mcp` (MIT) et `blazickjp/arxiv-mcp-server` (Apache 2.0) existent et fonctionnent via `uvx`. Ajouter une règle de sécurité contre l'injection de prompt dans les LaTeX/PDF externes téléchargés. |
| `uv tool install sympy` dans `setup.sh` | **Erreur technique**. | `sympy` est une bibliothèque Python, pas un outil CLI : `uv tool install sympy` ne rend pas `sympy` importable dans les scripts du projet. Remplacer par un environnement virtuel `uv` dédié au workspace (`.venv` via `pyproject.toml` contenant `sympy`, `numpy`, `scipy`, `matplotlib`). |
| Contrôle visuel TikZ via `pdftoppm -png` | **Dépendance manquante**. | `poppler-utils` (qui fournit `pdftoppm`) et `pdf2svg` manquent dans le `apt-get install` de `archive/first-conv.md`. Les ajouter explicitement. |
| Authentification des harnais dans un DevContainer | **Angle mort UX**. | `archive/first-conv.md` ne traite pas la connexion interactive dans un conteneur sans navigateur direct (ex. `codex login --device-auth`, copie d'URL `claude auth login`, piège de `ANTHROPIC_API_KEY` qui court-circuite l'abonnement Pro/Max). Traité intégralement dans `06-annexe-licences-et-authentification.md`. |
| Sécurité Git pour un non-informaticien | **Manquant**. | Un agent autonome peut exécuter des commandes Git destructrices (`git reset --hard`, `git clean -f`). Intégration de garde-fous Git à 3 niveaux inspirés de `lean4-skills`. |
