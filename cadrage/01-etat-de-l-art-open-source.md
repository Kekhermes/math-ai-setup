# État de l'art des solutions open-source non commerciales

Ce document synthétise une recherche approfondie sur les projets open-source et académiques existants (2025–2026) répondant à tout ou partie de notre problématique : **assister un chercheur en mathématiques avec des agents IA dans VS Code / CLI (Lean 4, rédaction LaTeX, bibliographie, enseignement)**.

---

## 1. Famille A — Preuves formelles Lean 4 & Autoformalisation

### 1.1 `cameronfreer/lean4-skills` (Licence MIT) — *Référence ergonomique Lean 4*
- **Principe :** Pack de skills et workflows agnostique de l'hôte (Claude Code, Codex, Copilot, Gemini) pilotant Lean 4.
- **Ce qu'on retient :**
  - **Interaction LSP-first** via `lean-lsp-mcp` (états de buts, diagnostics, `leanSearch`, `loogle`) plutôt que de relancer `lake build` aveuglément.
  - **Cycle de preuve unifié en 6 phases :** `Plan → Travail → Checkpoint → Relecture → Replanification → Arrêt/Suite` avec détection d'enlisement (si le même blocage revient 2 fois, l'agent change de stratégie).
  - **Garde-fous Git à 3 niveaux :** opérations sûres autorisées (`status`, `add`, `commit`), opérations collaboratives soumises à validation (`push`, PR), commandes destructrices bloquées sans appel (`git reset --hard`, `git clean -f`). Indispensable pour un non-informaticien.
  - **Workflow `/learn` intégré :** apprentissage interactif de Lean 4 et exploration de Mathlib.
- **Limites pour notre persona :** orienté utilisateurs à l'aise en CLI et commandes slash complexes ; pas de gestion LaTeX/articles/enseignement.

### 1.2 `leanprover/skills` (Apache 2.0) — *Skills officiels Lean FRO*
- **Principe :** Skills maintenus par l'équipe Lean (`lean-proof`, `lean-setup`, `lean-mwe`, `mathlib-build`, `mathlib-review`).
- **Ce qu'on retient :** discipline « un pas à la fois, cas le plus difficile en premier », gestion propre des logs `lake build`, création d'exemples minimaux reproductibles (MWE).

### 1.3 `texra-ai/texra-lean-skills` (MIT) & `LionSR/TeXRA` (Apache 2.0)
- **Principe :** Suite open-source VS Code + CLI conçue pour les théoriciens (LaTeX + Lean 4).
- **Ce qu'on retient :**
  - Skill `paper-gap-notes` : consigne explicitement les écarts entre une formalisation Lean et l'article source sous forme de notes citables.
  - Skill `lean-blueprint` : pont continu entre énoncés `.tex` et déclarations Lean.
  - Skill `find-simplification` : chasse au code mort et aux définitions redondantes.
- **Limites :** `TeXRA` installe sa propre extension VS Code lourde (SQLite + runtime Effect) ; nous préférons rester natifs sur les harnais standards VS Code (Copilot/Claude/Codex).

### 1.4 `frenzymath/Archon` (Apache 2.0) & `MerLeanProver/MerLean` (Apache 2.0)
- **Principe :** Orchestrateurs autonomes multi-agents pour la formalisation de dépôts entiers (`autoformalize → prover → polish`).
- **Ce qu'on retient :**
  - **Niveaux de preuve explicites (inspiré de MerLean) :** distinguer clairement *exploration informelle*, *ébauche Lean partiellement prouvée* (avec `sorry` tracés) et *preuve certifiée* (`lake build` vert sans `sorry`, `#print axioms` propre).
  - **Versioning isolé** ou commits d'étape fréquents pour pouvoir revenir en arrière sans crainte si l'agent s'égare.
- **Limites :** pensés pour de longs runs autonomes coûteux en tokens (Opus/Codex) sur de gros projets ; surdimensionnés comme interface par défaut pour un chercheur débutant.

### 1.5 Travaux académiques : *Theo* (arXiv:2606.31134), *AutoformBot/ATLAS* (Meta FAIR), *RobustPABench* (ICML 2026)
- **Ce qu'on retient :**
  - **Stratégie *Type-first* + tests unitaires par lemmes auxiliaires** (*Theo*) : valider les définitions Lean par de petits lemmes tests *avant* d'attaquer le théorème principal, afin d'éviter de prouver un théorème sur une définition mathématiquement fausse.
  - **Juge de fidélité en contexte vierge & rétention des trous (*RobustPABench*)** : vérifier qu'un agent n'a pas « résolu » une preuve en affaiblissant discrètement une hypothèse ou en supprimant une étape non triviale.

---

## 2. Famille B — Recherche théorique, Rédaction LaTeX & Enseignement

### 2.1 `pedrohcgs/claude-code-my-workflow` (MIT, 1700+ ★) — *Référence académique & Enseignement*
- **Principe :** Template prêt à l'emploi pour universitaires couvrant articles, analyse de données, slides Beamer/Quarto et enseignement.
- **Ce qu'on retient :**
  - **Workflows d'enseignement complets :** génération de syllabus, création de cours (`/create-lecture`), génération d'exercices (`/scaffold-exercises`), cours issu d'un article (`/teach-from-paper`).
  - **Agents de qualité dédiés :** `pedagogy-reviewer` (progression, densité de notation, rythme), `slide-auditor` (détection de débordements visuels), `proofreader` (propose d'abord, applique après accord).
  - **Dossier `explorations/` (bac à sable)** et `quality_reports/` pour séparer brouillons expérimentaux et livrables propres.
  - **Script `validate-setup.sh`** qui liste en clair les outils installés ou manquants.
- **Limites :** très orienté économétrie (R, Quarto, Stata) et centré sur Claude Code CLI. Nous adaptons le volet LaTeX/Beamer/pédagogie aux mathématiques pures/appliquées sans imposer R ni Quarto.

### 2.2 `morankor/theorist-toolbox` (MIT, arXiv:2606.22337) — *Référence recherche théorique*
- **Principe :** Boîte à outils conçue spécifiquement pour les chercheurs en théorie (économie théorique / mathématiques) utilisant Claude Code et Codex.
- **Ce qu'on retient :**
  - **Marqueur strict `\unproven{}` vs `\leanproved{}`** dans le `.tex` : interdiction pour l'agent de masquer une lacune sous un « clairement » ou « évidemment ». Tout pas non vérifié est balisé `\unproven{}`.
  - **Séparation *Justesse d'abord, Lisibilité ensuite* (`proof-readability`) :** une passe dédiée à la clarté rédactionnelle (architecture, jalons, notations, intuition) qui n'a *pas* le droit de modifier le fond mathématique sans repasser par le vérificateur.
  - **Contre-vérificateur adversarial optionnel (`codex-math`)** : quand deux modèles/harnais sont disponibles, l'un rédige et l'autre joue le rôle de rapporteur hostile cherchant un contre-exemple.
  - **Discipline de preuve :** énoncer ce qu'on va démontrer avant de le montrer, vérifier chaque signe/quantificateur, ne jamais généraliser à partir d'un exemple.

### 2.3 `Imbad0202/academic-research-skills` & `academic-research-skills-codex` (CC BY-NC 4.0)
- **Principe :** Suite multi-agents pour revue de littérature, écriture d'article et simulation de *peer review*.
- **Ce qu'on retient :** séparation entre rapporteur *fit revue*, rapporteurs techniques et *Devil's Advocate*, plus matrice de traçabilité réponse-aux-rapporteurs (R&R).
- **Limites :** trop lourd (13+12+7 agents) et licence non commerciale CC BY-NC ; nous retenons uniquement l'idée d'un mode « rapporteur exigeant / comité ANR-ERC » léger.

### 2.4 `wu1chenghui/hermes-math-template` (Open-source)
- **Principe :** Template Docker isolant Lean 4, LaTeX (Tectonic) et recherche web pour assistant mathématique.
- **Ce qu'on retient :** la valeur de tout isoler dans un conteneur persistant afin de ne jamais casser la machine hôte du chercheur.

---

## 3. Famille C — Méthodologie agentique générale

### 3.1 `obra/superpowers` (MIT)
- **Ce qu'on retient :**
  - **Raffinement socratique court** avant d'écrire des dizaines de lignes de Lean ou de LaTeX.
  - **Vérification avant clôture (*Verification before completion*)** : aucun agent ne peut déclarer « terminé » sans preuve mécanique d'exécution (`lake build` vert, `latexmk` vert, tests Python verts).

### 3.2 `CarmenSalvado/ProofMesh` (Open-source)
- **Analysé et écarté comme architecture cible :** pile web lourde (Next.js + FastAPI + Postgres + Redis + MinIO + 2 runners). Trop complexe à installer/maintenir pour un chercheur individuel ; le duo VS Code + DevContainer répond mieux au besoin avec beaucoup moins de pièces mobiles.

---

## 4. Matrice de synthèse : ce que `math-ai-setup` adopte

| Bonne pratique identifiée | Source d'inspiration | Adaptation dans `math-ai-setup` |
|---|---|---|
| Cycle LSP-first + garde-fous Git 3 niveaux + `/learn` | `cameronfreer/lean4-skills` | Adapté en français dans `preuve-lean` + règles Git strictes dans `AGENTS.md`. |
| Définition *Type-first* + lemmes tests + Juge de fidélité | *Theo* & *RobustPABench* | Intégré dans `preuve-lean` et `juge-fidelite-et-derive` (contexte isolé). |
| Balise `\unproven{}` + passe de lisibilité séparée | `morankor/theorist-toolbox` | Intégré dans les macros LaTeX et `redaction-article-et-subvention`. |
| Workflows d'enseignement + `pedagogy-reviewer` + `slide-auditor` | `pedrohcgs/claude-code-my-workflow` | Adapté sans R/Quarto dans `enseignement-maths` (Beamer + TD/examens à corrigé masquable). |
| Script de diagnostic clair de l'environnement | `pedrohcgs/claude-code-my-workflow` | `scripts/valider-setup.sh` relié à un bouton VS Code en 1 clic et au Skill Helper. |
| Vérification mécanique avant toute clôture | `obra/superpowers` | Règle d'or non négociable dans `AGENTS.md` (`lake build`, `latexmk`, `#print axioms`, SymPy). |
| Dossier bac à sable vs livrables propres | `pedrohcgs` (`explorations/`) | Dossiers séparés dans le Hub (`exemples/`, `recherches/`, `preuves/`, `enseignement/`). |
