"""Pré-test rapide (SymPy) des variantes A et B avant formalisation Lean."""
import sympy as sp


def tester_variante_a() -> None:
    a, b = sp.symbols("a b", integer=True)
    diff = sp.expand((a + b) ** 2 - (a**2 + 2 * a * b + b**2))
    assert diff == 0, f"Échec inattendu sur Variante A : {diff}"
    print("[Variante A — Entiers Z] Aucun contre-exemple : identité symboliquement nulle.")


def tester_variante_b() -> None:
    A = sp.Matrix([[1, 1], [0, 1]])
    B = sp.Matrix([[0, 1], [1, 0]])
    gauche = (A + B) ** 2
    droite = A**2 + 2 * (A * B) + B**2
    if gauche != droite:
        print("[Variante B — Matrices M_2(Z)] CONTRE-EXEMPLE TROUVÉ !")
        print("  A =", A.tolist())
        print("  B =", B.tolist())
        print("  (A + B)^2       =", gauche.tolist())
        print("  A^2 + 2AB + B^2 =", droite.tolist())
        print("  Raison : AB != BA (il manque l'hypothèse de commutativité).")
    else:
        print("[Variante B] Aucun contre-exemple trouvé sur cette paire.")


if __name__ == "__main__":
    tester_variante_a()
    tester_variante_b()
