---
name: preuve-lean
description: "Utiliser quand le chercheur veut formaliser un énoncé mathématique en Lean 4, compléter des sorry, ou vérifier et structurer des preuves dans preuves/ avec Lean Blueprint."
---

# Formalisation et Preuve Lean 4 (`preuve-lean`)

Tu formalises et démontres des résultats mathématiques en Lean 4 avec une rigueur absolue et une lisibilité maximale pour un mathématicien profane en Lean.

## Workflow obligatoire (inspiré de `lean4-skills` et *Theo*)

1. **Pré-contrôle optionnel par calcul symbolique :**
   - Si l'énoncé est complexe ou nouveau, suggère d'abord un test rapide avec `falsification-sympy` pour vérifier qu'il ne manque pas d'hypothèse avant de formaliser.
2. **Approche *Type-First* :**
   - Rédige d'abord les définitions et la signature exacte du théorème.
   - Ajoute 1 ou 2 petits lemmes tests (« sanity checks ») pour confirmer que les définitions captures bien l'objet mathématique souhaité.
3. **Boucle LSP-first via `lean-lsp-mcp` :**
   - Inspecte les buts avec `lean_goal` et `lean_diagnostic_messages`.
   - Cherche les lemmes existants via `leanSearch` et `loogle` avant d'écrire de longues preuves manuelles.
   - Teste plusieurs tactiques d'un coup avec `lean_multi_attempt`.
   - Cycle en 6 étapes : **Plan → Travail → Checkpoint → Relecture → Replanification → Arrêt**. Si le même blocage se répète 2 fois, change de décomposition en sous-lemmes (`have`).
4. **Lisibilité pour un profane en Lean :**
   - Découpe les preuves non triviales en étapes intermédiaires nommées (`have h_etape1 : ... := by ...`).
   - Commente chaque bloc en **français mathématique clair** expliquant l'idée de la preuve (ex. : `-- On montre d'abord l'inégalité triangulaire sur la composante paire`).
5. **Lean Blueprint (si présent dans `preuves/blueprint/`) :**
   - Relie chaque `\begin{theorem}` LaTeX à son nom Lean via `\lean{...}` et marque `\leanok` uniquement après certification.

## Critères d'arrêt obligatoires (Porte de certification)

Tu n'as le droit de déclarer une preuve **certifiée** que si ALL 3 vérifications suivantes passent réellement :
1. `lake build` (ou `lean <fichier>`) s'achève avec **0 erreur** ;
2. Le fichier (et ses dépendances ajoutées) ne contient **aucun `sorry` ni `admit`** ;
3. `#print axioms <nom_theoreme>` n'affiche que des axiomes standards (`propext`, `Classical.choice`, `Quot.sound`).

**Interdiction absolue :** ne modifie jamais silencieusement les hypothèses d'un théorème pour le faire compiler. Si une hypothèse supplémentaire semble nécessaire, signale-le explicitement au chercheur.
