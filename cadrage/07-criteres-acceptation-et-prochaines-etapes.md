# Critères d'acceptation et prochaines étapes

Ce document définit les **portes de vérification objectives** qui permettront de valider le futur dépôt `math-ai-setup` lors de sa phase d'implémentation (hors périmètre de ce cadrage).

---

## 1. Critères d'acceptation de l'environnement (DevContainer & VS Code)

| ID | Critère | Preuve attendue lors de la future implémentation |
|---|---|---|
| **AC-01** | Reconstruction reproductible du DevContainer | `devcontainer up` réussit sans intervention manuelle ; aucune erreur dans `.devcontainer/setup.sh`. |
| **AC-02** | Environnement Python & SymPy fonctionnel | `.venv/bin/python -c "import sympy, numpy, scipy, matplotlib; print(sympy.__version__)"` réussit (correction du bug `uv tool install sympy`). |
| **AC-03** | Chaîne Lean 4 + Mathlib opérationnelle | `lake build` dans `preuves/` réussit sans télécharger/recompiler tout Mathlib à chaud ; `lean-lsp-mcp` répond sur un fichier test. |
| **AC-04** | Chaîne LaTeX + contrôle visuel complète | `latexmk -pdf`, `biber`, `pdftoppm -v`, `pdf2svg -v` fonctionnent y compris avec paquets français (`babel`/accents). |
| **AC-05** | Cohérence multi-harnais | `AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md` et les dossiers de skills pointent vers la même source sans lien cassé (`scripts/valider-setup.sh` vert). |
| **AC-06** | Boutons 1-clic VS Code | Chaque tâche de `.vscode/tasks.json` (diagnostic, compilation LaTeX, double PDF sujet/corrigé, `lake build`, `leanblueprint`, sauvegarde Git guidée) s'exécute sans erreur. |

---

## 2. Critères d'acceptation pédagogiques et métier

| ID | Critère | Preuve attendue |
|---|---|---|
| **AC-07** | Skill `helper-chercheur` | Sur une requête novice (*« Je suis perdu, je veux commencer un TD »*), le Helper diagnostique, répond en français sans jargon et propose une action concrète dans `enseignement/`. |
| **AC-08** | Garde-fous Git et véracité | Les règles `AGENTS.md` interdisent `git reset --hard` / `git clean -fd`, interdisent tout `\cite{}` non vérifié et imposent `lake build` + `#print axioms` avant toute déclaration de preuve réussie. |
| **AC-09** | Scénario `exemples/01-preuve-lean-et-sympy` | SymPy attrape volontairement la variante fausse ; la preuve Lean complète passe `lake build` sans `sorry`. |
| **AC-10** | Scénario `exemples/02-article-arxiv-et-drift` | Le Drift Report détecte la divergence d'hypothèse `.tex` vs `.lean` ; le flux arXiv produit une entrée BibTeX valide ; le contrôle TikZ détecte le chevauchement. |
| **AC-11** | Scénario `exemples/03-cours-beamer-et-td` | La compilation produit deux PDF distincts (`sujet` sans solutions, `corrige` avec solutions) et l'audit visuel repère le débordement Beamer volontaire. |
| **AC-12** | Test utilisateur « niveau informatique limité » | Simulation ou relecture complète de `GUIDE-DEMARRAGE.md` et `ANNEXE-LICENCES.md` : aucune commande terminal obligatoire au quotidien pour le chercheur. |
| **AC-13** | Formation Lean (`tuteur-lean` + `00-initiation-lean`) | Sur un fichier Lean contenant un `sorry` ou une erreur volontaire, `tuteur-lean` traduit l'Infoview et l'erreur en français mathématique sans résoudre l'exercice sans accord. |

---

## 3. Ce qui reste volontairement hors périmètre (décisions assumées)

- Aucune pile web multi-services (pas de base de données Postgres/Redis ni d'interface web externe à maintenir).
- Aucune dépendance obligatoire à R ou Quarto (l'enseignement reste centré sur LaTeX/Beamer + corrigés masquables, familiers à tout mathématicien).
- Aucun appel réseau payant ni aucune création de fichiers d'implémentation réalisés pendant cette phase de cadrage.

---

## 4. Prochaine étape après validation de `/cadrage`

Une fois que Kevin valide (ou ajuste) les documents présents dans `/cadrage/` :
1. Passer en phase **Implémentation du Hub `math-ai-setup`** à la racine du dépôt (`.devcontainer/`, `.vscode/`, `AGENTS.md`, `.github/skills/`, `preambles/`, `scripts/`, `exemples/`, `GUIDE-DEMARRAGE.md`, `ANNEXE-LICENCES.md`).
2. Valider mécaniquement l'ensemble des critères **AC-01 à AC-13** avant la session d'installation chez le chercheur.
