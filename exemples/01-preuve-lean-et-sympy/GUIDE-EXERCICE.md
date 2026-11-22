# Scénario 1 — Pré-test SymPy + Preuve Lean 4 (`01-preuve-lean-et-sympy/`)

**Objectif (10 minutes) :** voir comment un test Python/SymPy de 2 secondes évite de perdre des heures à formaliser un énoncé faux en Lean, puis prouver et certifier la variante correcte.

---

## Étape 1 — Falsification rapide avant Lean
Copiez ce prompt dans le chat :
> `Teste les variantes A et B de exemples/01-preuve-lean-et-sympy/enonce.tex avec Python/SymPy avant toute formalisation Lean.`

**Résultat attendu :** l'assistant exécute `test_sympy.py` (ou un script équivalent), confirme que la **Variante A** (commutativité sur $\mathbb{Z}$) tient symboliquement, et exhibe un **contre-exemple matriciel $2 \times 2$ explicite** qui réfute la **Variante B** (sans hypothèse de commutativité).

---

## Étape 2 — Compléter et certifier la preuve Lean 4
Copiez ce prompt dans le chat :
> `Complète la preuve de la variante vraie dans exemples/01-preuve-lean-et-sympy/ExemplePreuve.lean avec des commentaires en français, vérifie qu'il n'y a plus de sorry et affiche #print axioms.`

Vous pouvez ensuite comparer avec `solution-attendue/ExemplePreuveComplet.lean`.
