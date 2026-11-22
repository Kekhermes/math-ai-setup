/-
  Module de bienvenue Lean 4 — math-ai-setup
  Permet de vérifier que `lake build` fonctionne immédiatement.
-/

/-- Exemple minimal : l'addition sur ℕ est commutative à gauche pour 0. -/
theorem zero_add_exemple (n : Nat) : 0 + n = n := by
  omega

#print axioms zero_add_exemple
