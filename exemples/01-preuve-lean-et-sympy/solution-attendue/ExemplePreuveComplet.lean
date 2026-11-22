/-
  Scénario 1 : Solution vérifiée en Lean 4 pur (sans dépendance lourde)
-/

theorem carre_somme_int (a b : Int) :
    (a + b) * (a + b) = a * a + 2 * (a * b) + b * b := by
  -- On développe d'abord le produit à gauche : (a + b) * a + (a + b) * b
  rw [Int.mul_add]
  -- Puis on développe chacun des deux termes : a*a + b*a + (a*b + b*b)
  rw [Int.add_mul, Int.add_mul]
  -- Par commutativité de la multiplication dans ℤ, b * a = a * b
  rw [Int.mul_comm b a]
  -- Enfin on exprime 2 * (a * b) = a * b + a * b et on conclut par associativité
  have h2 : 2 * (a * b) = a * b + a * b := by omega
  rw [h2]
  omega

#print axioms carre_somme_int
