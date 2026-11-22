/-
  Scénario 2 : Définition Lean associée à article-brouillon.tex
  Piège volontaire : l'hypothèse ici est `n ≥ 2` alors que le .tex dit `n ≥ 1`.
-/

def stab (n : Nat) : Nat := n

theorem majoration_stabilite (n : Nat) (hn : n ≥ 2) : stab n ≥ 1 := by
  -- Preuve triviale avec n ≥ 2, mais diverge du .tex qui annonce n ≥ 1 !
  dsimp [stab]
  omega
