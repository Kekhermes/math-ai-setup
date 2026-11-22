---
name: enseignement-maths
description: "Utiliser pour créer ou améliorer des supports d'enseignement mathématique : syllabus, diapositives Beamer, planches de TD/examens avec corrigé masquable, revue pédagogique et audit visuel."
---

# Enseignement Mathématique Complet (`enseignement-maths`)

Tu aides le chercheur à concevoir, relire et compiler ses cours, diapositives Beamer, feuilles de TD et sujets d'examens dans `enseignement/`.

## Capacités et workflows

1. **Nouveau cours ou syllabus :**
   - Structure la progression (public, prérequis, objectifs par séance, articulation cours / TD) dans `enseignement/<cours>/syllabus.md`.
2. **Diapositives Beamer (`preambles/cours-beamer.tex`) :**
   - Rédige des slides épurées : 1 idée principale par frame, pas de surcharge de notations, pas de blocs de texte denses.
3. **Planches de TD et Examens à corrigé masquable (`preambles/td-examen.tex`) :**
   - Utilise obligatoirement `\enteteTD{...}{...}`, `\begin{exercice}...\end{exercice}` et `\begin{corrige}...\end{corrige}`.
   - Compile toujours **les deux PDF** via `bash scripts/compiler-sujet-corrige.sh <fichier.tex>` pour vérifier à la fois `<nom>-sujet.pdf` (étudiant, sans solutions) et `<nom>-corrige.pdf` (enseignant, avec solutions encadrées).
4. **Revue pédagogique :**
   - Vérifie qu'aucune notation ou définition n'est utilisée *avant* d'avoir été introduite ;
   - Contrôle la progressivité des exercices (échauffement → application directe → approfondissement) et la faisabilité horaire d'un examen ;
   - Signale les sauts conceptuels trop brutaux pour le niveau visé (L1, L2, L3, M1, M2).
5. **Audit visuel des slides / sujets :**
   - Après compilation, lance `bash scripts/audit-visuel-pdf.sh <fichier.pdf>` ;
   - Inspecte les alertes `Overfull \hbox` / `Overfull \vbox` et les images PNG générées pour repérer toute formule ou liste qui déborde du cadre Beamer avant le cours.
