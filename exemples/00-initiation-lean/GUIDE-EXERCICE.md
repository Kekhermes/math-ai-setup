# Module 0 — Découvrir Lean 4 depuis zéro (`00-initiation-lean/`)

**Objectif (10 minutes) :** apprivoiser l'écran de Lean 4 (*Lean Infoview*) et dialoguer avec le skill **`tuteur-lean`** sans avoir besoin de connaître l'informatique.

---

## Étape 1 — Ouvrir le fichier et voir l'écran Lean
1. Cliquez sur le fichier `exemples/00-initiation-lean/BacASableLean.lean` dans l'explorateur à gauche.
2. Si le panneau de droite (**Lean Infoview**) n'apparaît pas tout seul, cliquez sur l'icône `∀` en haut à droite de l'éditeur.
3. Placez votre curseur sur la ligne du premier `sorry`.

---

## Étape 2 — Tester le mode Tuteur (copiez-collez ces prompts dans le chat)

1. **Comprendre ce qu'on voit à l'écran :**
   > `Explique-moi en français mathématique ce que je vois dans l'Infoview à la ligne du premier sorry de exemples/00-initiation-lean/BacASableLean.lean, sans me donner la solution.`

2. **Avancer d'un pas avec un indice :**
   > `Donne-moi juste un indice de tactique pour avancer sur ce premier lemme.`

3. **Comprendre une erreur Lean volontaire :**
   Remplacez le premier `sorry` par un mot au hasard (par exemple `tactique_bidon`) puis demandez :
   > `Traduis-moi l'erreur Lean à cette ligne en français simple et explique comment la corriger.`

4. **Compléter les 3 mini-lemmes (ou comparer avec la solution) :**
   Quand vous avez fini (ou si vous voulez voir la solution commentée), ouvrez `exemples/00-initiation-lean/solutions/BacASableLeanCorrige.lean`.
