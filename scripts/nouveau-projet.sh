#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 2 ]; then
  echo "Usage : bash scripts/nouveau-projet.sh <article|subvention|cours|td> <nom-court-sans-espaces>"
  exit 1
fi

TYPE="$1"
SLUG="$2"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

case "$TYPE" in
  article)
    DIR="$REPO_ROOT/recherches/$SLUG"
    mkdir -p "$DIR/sections" "$DIR/figures"
    cat > "$DIR/main.tex" <<'EOF'
\documentclass[11pt,a4paper]{article}
\input{article-recherche}

\title{Titre provisoire}
\author{Chercheur}
\date{\today}

\begin{document}
\maketitle

\begin{abstract}
Résumé à compléter.
\end{abstract}

\section{Introduction}
% Exemple de marqueur de vigilance : \unproven{Justifier l'étape avant soumission.}

\bibliographystyle{plain}
\bibliography{references}
\end{document}
EOF
    touch "$DIR/references.bib"
    echo "% Macros spécifiques à ce projet" > "$DIR/macros.tex"
    echo "# Notes et jalons — $SLUG" > "$DIR/notes-et-jalons.md"
    echo "Projet article créé dans : $DIR"
    ;;
  subvention)
    DIR="$REPO_ROOT/recherches/$SLUG"
    mkdir -p "$DIR/sections"
    cp "$REPO_ROOT/recherches/modele-subvention-criteres.md" "$DIR/criteres-appel.md"
    cat > "$DIR/dossier.tex" <<'EOF'
\documentclass[11pt,a4paper]{article}
\input{article-recherche}

\title{Projet scientifique — Appel ANR / ERC}
\author{Porteur du projet}
\date{\today}

\begin{document}
\maketitle

\section{Objectifs et verrous scientifiques}
\section{Programme de travail et jalons}
\section{Gestion des risques et faisabilité}

\end{document}
EOF
    echo "Projet subvention créé dans : $DIR"
    ;;
  cours)
    DIR="$REPO_ROOT/enseignement/$SLUG"
    mkdir -p "$DIR/slides" "$DIR/td" "$DIR/examens"
    cat > "$DIR/syllabus.md" <<EOF
# Syllabus — $SLUG

- **Public visé :** À compléter
- **Prérequis :** À compléter
- **Objectifs d'apprentissage :** À compléter

## Plan des séances
1. Séance 1 : ...
EOF
    cat > "$DIR/slides/seance-01.tex" <<'EOF'
\documentclass[aspectratio=169]{beamer}
\input{cours-beamer}

\title{Séance 1}
\author{Enseignant}
\date{\today}

\begin{document}
\begin{frame}
  \titlepage
\end{frame}

\begin{frame}{Objectifs de la séance}
  \begin{itemize}
    \item Premier point clé
  \end{itemize}
\end{frame}
\end{document}
EOF
    echo "Projet cours créé dans : $DIR"
    ;;
  td)
    DIR="$REPO_ROOT/enseignement/$SLUG"
    mkdir -p "$DIR"
    cat > "$DIR/td-01.tex" <<'EOF'
\documentclass[11pt,a4paper]{article}
\input{td-examen}

\begin{document}
\enteteTD{Travaux Dirigés 1}{Année universitaire}

\begin{exercice}[Échauffement]
Soit $x \in \R$. Montrer que $x^2 \ge 0$.
\end{exercice}

\begin{corrige}
Un carré dans $\R$ est toujours positif ou nul.
\end{corrige}

\end{document}
EOF
    echo "Planche de TD créée dans : $DIR/td-01.tex"
    ;;
  *)
    echo "Type inconnu : $TYPE (attendu : article, subvention, cours, td)"
    exit 1
    ;;
esac
