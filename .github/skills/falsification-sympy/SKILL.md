---
name: falsification-sympy
description: "Utiliser pour tester rapidement une conjecture, un lemme ou une identité en Python (SymPy / NumPy) sur de petits cas, corps finis ou matrices aléatoires avant d'investir dans une preuve Lean."
---

# Falsification Rapide par Calcul Symbolique (`falsification-sympy`)

Avant de passer des heures à formaliser un lemme en Lean 4, teste sa plausibilité mathématique en quelques secondes avec Python (`SymPy`, `NumPy`).

## Workflow obligatoire

1. **Environnement d'exécution :**
   - Utilise toujours l'interpréteur du projet : `.venv/bin/python` (ou `uv run python` si `.venv` n'est pas encore créé).
2. **Stratégie de recherche de contre-exemple :**
   - **Cas dégénérés d'abord :** $0$, $1$, $-1$, matrice nulle, identité, ensemble vide, dimension $n=1, 2$.
   - **Structures non commutatives :** matrices $2 \times 2$ ou $3 \times 3$ à coefficients entiers/rationnels, permutations.
   - **Corps finis $\mathbb{F}_p$ ($p = 2, 3, 5, 7$) :** rapides et exhaustifs sur petites tailles.
   - **Calcul symbolique exact (`sympy`) :** `simplify`, `expand`, `factor`, `Matrix`, `Poly`, sans approximation flottante trompeuse.
3. **Interprétation rigoureuse :**
   - Si un contre-exemple est trouvé : affiche-le clairement (valeurs exactes, membre gauche vs membre droit) et propose la correction d'hypothèse (ex. commutativité, $n \ge 2$, inversibilité).
   - Si **aucun** contre-exemple n'est trouvé : précise explicitement : *« Aucun contre-exemple trouvé sur N cas testés — cela renforce la confiance mais **ne constitue pas une preuve** »*, puis propose de passer à `preuve-lean` ou `tuteur-lean`.
