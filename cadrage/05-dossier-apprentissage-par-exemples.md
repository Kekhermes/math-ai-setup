# Spécification du dossier d'apprentissage par l'exemple (`exemples/`)

Conformément aux décisions **D-08** et **D-13**, le futur dépôt `math-ai-setup` inclut un dossier `exemples/` contenant **un module d'initiation à Lean 4 (Module 0)** suivi des **3 mini-scénarios guidés pas-à-pas**. Chaque exercice est autonome, court (10 à 15 minutes), et permet au chercheur d'apprendre par la pratique sans risquer de casser ses vrais travaux.

---

## 1. Structure du dossier `exemples/`

```text
exemples/
├── LISEZ-MOI.md                          # Guide d'utilisation des exercices + boutons à cliquer
├── 00-initiation-lean/                   # Module 0 (décision D-13) : découvrir Lean 4 depuis zéro
│   ├── GUIDE-EXERCICE.md                 # Lire l'Infoview, 5 tactiques de base, prompts tuteur-lean
│   ├── BacASableLean.lean                # 3 mini-lemmes progressifs (réécriture, logique, arithmétique)
│   └── solutions/
│       └── BacASableLeanCorrige.lean     # Version commentée ligne par ligne en français
├── 01-preuve-lean-et-sympy/
│   ├── GUIDE-EXERCICE.md                 # Énoncé, objectif, prompts exacts à copier dans le chat
│   ├── enonce.tex                        # Petit théorème informel + variante volontairement fausse
│   ├── test_sympy.py                     # Script de départ (ou à générer) montrant la falsification rapide
│   ├── ExemplePreuve.lean                # Squelette Lean 4 avec 1 `sorry` guidé
│   └── solution-attendue/
│       └── ExemplePreuveComplet.lean     # Référence vérifiée pour comparer après coup
├── 02-article-arxiv-et-drift/
│   ├── GUIDE-EXERCICE.md                 # Prompts exacts pour biblio arXiv + Drift Report + TikZ
│   ├── article-brouillon.tex             # Brouillon avec 1 citation manquante `[CIT?]` et 1 trou `\unproven{}`
│   ├── macros.tex                        # Macros contenant 1 divergence volontaire avec le Lean
│   ├── definition_associee.lean          # Définition Lean légèrement plus restrictive (piège à détecter)
│   └── references.bib                    # Fichier BibTeX quasi vide à enrichir via MCP arXiv
└── 03-cours-beamer-et-td/
    ├── GUIDE-EXERCICE.md                 # Prompts exacts pour cours, revue pédagogique, audit visuel et TD
    ├── seance-01-slides.tex              # Mini-cours Beamer (4 slides) avec 1 débordement volontaire
    ├── td-01.tex                         # Planche de TD (2 exercices) utilisant `\begin{corrige}`
    └── attendu.md                        # Résultats attendus (sujet.pdf + corrigé.pdf + liste anomalies)
```

---

## 2. Détail du module d'initiation et des 3 mini-scénarios

### Module 0 (préliminaire) — *Découvrir Lean 4 depuis zéro* (`00-initiation-lean/`)
- **Objectif pédagogique :** lever la barrière d'entrée pour un mathématicien qui n'a jamais ouvert Lean 4 : comprendre le panneau *Lean Infoview* (hypothèses au-dessus du trait `⊢`, objectif en dessous), apprivoiser 5 tactiques de base (`intro`, `rw`, `exact`, `ring`, `linarith`) et apprendre à demander de l'aide à `tuteur-lean` sans qu'il fasse tout à sa place.
- **Déroulé guidé :**
  1. Ouvrir `BacASableLean.lean` et observer le panneau droit (*Lean Infoview*).
  2. Prompt 1 : *« Explique-moi en français mathématique ce que je vois à l'écran à la ligne du premier `sorry`, sans me donner la réponse. »*
  3. Prompt 2 : *« Donne-moi seulement un indice pour la prochaine tactique du lemme 1. »*
  4. Prompt 3 (provoquer volontairement une erreur) : taper une tactique inadaptée et demander *« Traduis-moi ce message d'erreur Lean et explique comment le corriger. »*

### Scénario 1 — *Preuve Lean 4 + Pré-test SymPy* (`01-preuve-lean-et-sympy/`)
- **Objectif pédagogique :** comprendre pourquoi tester un énoncé avec Python/`SymPy` *avant* de lancer Lean fait gagner un temps considérable, puis voir comment l'agent résout un `sorry` via `lean-lsp-mcp` et vérifie `#print axioms`.
- **Contenu mathématique choisi :** simple mais non trivial (ex. : une identité algébrique ou un lemme élémentaire sur les matrices $2 \times 2$ / sommes finies, plus une variante où il manque l'hypothèse de commutativité).
- **Déroulé guidé pour le chercheur :**
  1. Copier-coller le Prompt 1 : *« Teste d'abord la variante A et la variante B de `exemples/01-preuve-lean-et-sympy/enonce.tex` avec SymPy. »* → L'agent exhibe un contre-exemple matriciel sur la variante sans commutativité !
  2. Copier-coller le Prompt 2 : *« Complète la preuve dans `ExemplePreuve.lean`, vérifie qu'il n'y a plus de `sorry` et affiche les axiomes utilisés. »*
  3. Cliquer sur le bouton VS Code `4. Vérifier toutes les preuves Lean` pour voir la validation mécanique verte.

### Scénario 2 — *Article LaTeX + BibTeX arXiv + Drift Report* (`02-article-arxiv-et-drift/`)
- **Objectif pédagogique :** apprendre les trois garde-fous de rédaction scientifique : citation vérifiée par MCP arXiv, détection de dérive sémantique (`.tex` vs `.lean`) et contrôle visuel d'un petit diagramme `tikz-cd`.
- **Pièges volontaires intégrés :**
  1. Un marqueur `[À CITER : papier sur ...]` dans `article-brouillon.tex`.
  2. Une divergence volontaire : dans `article-brouillon.tex`, l'hypothèse porte sur « tout entier $n \ge 1$ », alors que `definition_associee.lean` suppose `$n \ge 2$` (ou `Odd n`).
  3. Un petit diagramme TikZ avec deux étiquettes qui se chevauchent volontairement.
- **Déroulé guidé :**
  1. Prompt 1 : *« Trouve sur arXiv une référence pertinente pour `[À CITER]`, vérifie l'énoncé dans le papier et ajoute l'entrée dans `references.bib`. »*
  2. Prompt 2 : *« Lance un Drift Report entre `article-brouillon.tex` et `definition_associee.lean` sans modifier les fichiers. »* → L'agent doit signaler l'écart d'hypothèse.
  3. Prompt 3 : *« Vérifie visuellement le diagramme TikZ du brouillon et corrige le chevauchement d'étiquettes. »*

### Scénario 3 — *Cours Beamer + TD/Examen à corrigé masquable* (`03-cours-beamer-et-td/`)
- **Objectif pédagogique :** prendre en main le volet enseignement complet : double compilation Sujet/Corrigé, revue pédagogique et audit visuel de slides Beamer.
- **Pièges volontaires intégrés :**
  1. Dans `seance-01-slides.tex`, la slide 3 introduit une notation avant sa définition et contient une formule trop longue qui déborde de la frame Beamer.
  2. `td-01.tex` utilise les macros de corrigé masquable avec un premier exercice complet et un deuxième exercice à rédiger/vérifier.
- **Déroulé guidé :**
  1. Cliquer sur la tâche VS Code `3. Compiler TD/Examen : Sujet seul + Corrigé` → observer la génération de `td-01-sujet.pdf` (sans solutions) et `td-01-corrige.pdf` (avec solutions).
  2. Prompt 1 : *« Fais une revue pédagogique et un audit visuel de `seance-01-slides.tex`. »* → L'agent compile en PNG, repère le débordement et la notation prématurée, puis propose les corrections.
  3. Prompt 2 : *« Ajoute un exercice progressif sur le même thème dans `td-01.tex` avec son corrigé masquable et vérifie la compilation. »*

---

## 3. Règle de réinitialisation des exemples

Le script `scripts/reinitialiser-exemples.sh` (accessible aussi via le Helper : *« Remets les exemples à zéro »*) permet de restaurer uniquement `exemples/` à son état initial propre sans toucher à `recherches/`, `preuves/` ni `enseignement/`.
