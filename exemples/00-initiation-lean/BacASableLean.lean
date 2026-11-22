/-
  Module 0 : Bac à sable d'initiation à Lean 4
  Placez votre curseur sur un `sorry` et regardez le panneau Lean Infoview à droite.
  Les lignes au-dessus de `⊢` sont vos hypothèses ; la ligne après `⊢` est le but à prouver.
-/

-- Lemme 1 : Transitivité simple par réécriture (essai conseillé : `rw [h1, h2]`)
theorem egalite_transitive (a b c : Nat) (h1 : a = b) (h2 : b = c) : a = c := by
  sorry

-- Lemme 2 : Calcul élémentaire sur les entiers naturels (essai conseillé : `omega`)
theorem double_egal (n : Nat) : n + n = 2 * n := by
  sorry

-- Lemme 3 : Inégalité linéaire avec hypothèses (essai conseillé : `omega`)
theorem somme_minoree (x y : Nat) (hx : x ≥ 1) (hy : y ≥ 2) : x + y ≥ 3 := by
  sorry
