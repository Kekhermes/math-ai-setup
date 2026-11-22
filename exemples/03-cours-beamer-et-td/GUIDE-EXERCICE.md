# Scénario 3 — Cours Beamer + TD à corrigé masquable (`03-cours-beamer-et-td/`)

**Objectif (10 minutes) :** générer d'un seul clic un sujet étudiant et sa version corrigée, puis faire auditer une mini-présentation Beamer.

---

## Étape 1 — Double compilation Sujet + Corrigé (sans chat !)
1. Ouvrez `exemples/03-cours-beamer-et-td/td-01.tex`.
2. Dans le menu VS Code : **Terminal → Exécuter la tâche... → `3. Compiler TD/Examen : Sujet seul + Corrigé`**.
3. Ouvrez les deux PDF générés à côté du fichier :
   - `td-01-sujet.pdf` (les blocs `\begin{corrige}` sont masqués)
   - `td-01-corrige.pdf` (les corrigés apparaissent dans des encadrés bleus).

---

## Étape 2 — Revue pédagogique et audit visuel de slides Beamer
Copiez ce prompt dans le chat :
> `Fais une revue pédagogique et un audit visuel (avec conversion PNG) de exemples/03-cours-beamer-et-td/seance-01-slides.tex, puis explique les deux anomalies détectées.`

*(Anomalies volontaires présentes : une notation utilisée avant sa définition sur la slide 3, et une équation trop longue qui déborde.)*

---

## Étape 3 — Enrichir le TD
Copiez ce prompt dans le chat :
> `Ajoute un troisième exercice progressif (avec son corrigé masquable) sur les suites convergentes dans exemples/03-cours-beamer-et-td/td-01.tex et vérifie la double compilation.`
