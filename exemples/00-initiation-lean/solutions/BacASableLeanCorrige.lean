/-
  Module 0 : Solution commentée en français
-/

-- Lemme 1 : On remplace `a` par `b` grâce à `h1`, puis `b` par `c` grâce à `h2`.
theorem egalite_transitive (a b c : Nat) (h1 : a = b) (h2 : b = c) : a = c := by
  rw [h1, h2]

-- Lemme 2 : `omega` résout automatiquement les égalités et inégalités linéaires sur ℕ et ℤ.
theorem double_egal (n : Nat) : n + n = 2 * n := by
  omega

-- Lemme 3 : `omega` combine directement `hx : x ≥ 1` et `hy : y ≥ 2`.
theorem somme_minoree (x y : Nat) (hx : x ≥ 1) (hy : y ≥ 2) : x + y ≥ 3 := by
  omega

#print axioms egalite_transitive
#print axioms double_egal
#print axioms somme_minoree
