# Résultats attendus — Scénario 3

1. **Double compilation `td-01.tex` :**
   - `td-01-sujet.pdf` : affiche uniquement l'en-tête « Sujet étudiant » et les 2 énoncés d'exercices (aucun encadré de solution).
   - `td-01-corrige.pdf` : affiche « Version Enseignant (avec corrigés) » avec les 2 exercices et leurs 2 blocs « Corrigé » bleus.
2. **Revue pédagogique & audit visuel de `seance-01-slides.tex` :**
   - **Anomalie pédagogique :** la slide 3 utilise la notation $\norm{u - \ell_C}_\infty$ et évoque le critère de Cauchy *avant* même que la définition de la convergence ne soit posée à la slide 4.
   - **Anomalie visuelle :** l'équation sur la slide 3 déclenche un `Overfull \hbox` et déborde à droite sur l'image PNG générée.
