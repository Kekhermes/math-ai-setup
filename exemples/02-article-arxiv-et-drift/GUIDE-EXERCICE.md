# Scénario 2 — Article LaTeX + BibTeX arXiv + Drift Report (`02-article-arxiv-et-drift/`)

**Objectif (15 minutes) :** tester les trois garde-fous d'un article sérieux :
1. Trouver une vraie référence sur arXiv sans inventer de citation ;
2. Détecter une divergence cachée entre l'article LaTeX et le code Lean (*Drift Report*) ;
3. Contrôler visuellement un diagramme TikZ qui a deux étiquettes qui se chevauchent.

---

## Prompts à copier-coller dans le chat

1. **Bibliographie certifiée via arXiv :**
   > `Dans exemples/02-article-arxiv-et-drift/article-brouillon.tex, remplace le marqueur [À CITER] par une vraie référence arXiv pertinente sur l'autoformalisation Lean 4, après avoir vérifié l'article et ajouté son BibTeX dans references.bib.`

2. **Détection de dérive (`.tex` ↔ `.lean`) :**
   > `Lance un Drift Report entre exemples/02-article-arxiv-et-drift/article-brouillon.tex et definition_associee.lean sans modifier les fichiers.`
   *(Résultat attendu : l'agent repère que l'article suppose $n \ge 1$ alors que Lean impose `n ≥ 2`.)*

3. **Contrôle visuel TikZ :**
   > `Compile exemples/02-article-arxiv-et-drift/article-brouillon.tex, inspecte visuellement le diagramme TikZ et corrige le chevauchement d'étiquettes.`
