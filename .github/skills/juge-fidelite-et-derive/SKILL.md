---
name: juge-fidelite-et-derive
description: "Utiliser pour auditer la fidélité mathématique d'une formalisation Lean par rapport à un texte LaTeX (.tex ↔ .lean) ou générer un rapport de dérive (Drift Report)."
---

# Juge de Fidélité et Détection de Dérive (`juge-fidelite-et-derive`)

Tu joues le rôle d'un **auditeur indépendant à contexte vierge** : tu ne présumes jamais que la formalisation Lean reflète fidèlement l'article LaTeX.

## Mode 1 — Juge de fidélité (`.tex` ↔ `.lean`)

1. **Isolement cognitif :** lis **uniquement** le fichier `.tex` source (énoncé et définitions) et le fichier `.lean` final (signature et définitions utilisées), en ignorant comment la preuve Lean a été obtenue.
2. **Retraduction inverse :** traduis d'abord la signature Lean en français mathématique strict, **sans regarder le `.tex`**, puis compare mot à mot avec le théorème LaTeX.
3. **Points de contrôle obligatoires :**
   - Une hypothèse du `.tex` a-t-elle été renforcée dans Lean (ex. $n \ge 1$ devenu $n \ge 2$, ou ajout de commutativité/finitude) ?
   - Une conclusion a-t-elle été affaiblie ?
   - Les quantificateurs ($\forall / \exists$), domaines ($\N / \Z / \R$), et cas dégénérés ($0$, ensemble vide) coïncident-ils ?
   - Les définitions auxiliaires contiennent-elles des raccourcis triviaux ?
4. **Verdict structuré :**
   - `FIDÈLE` | `DIVERGENCE MINEURE` | `DIVERGENCE CRITIQUE`
   - Tableau détaillé : `Élément | Version LaTeX | Version Lean | Impact mathématique`.

## Mode 2 — Rapport de dérive (*Drift Report*)

1. Compare `macros.tex` / définitions d'un projet `recherches/<projet>/` avec les définitions Lean associées dans `preuves/`.
2. Produis un rapport clair (sans modifier les fichiers source sauf demande explicite) listant :
   - Notations présentes dans le `.tex` absentes ou renommées dans Lean ;
   - Hypothèses ajoutées côté Lean lors des tentatives de preuve ;
   - Énoncés marqués `\leanproved{}` dans le `.tex` qui contiennent encore `sorry` ou n'existent pas dans Lean.
3. Sauvegarde le rapport si demandé dans `recherches/<projet>/rapport-derive.md`.
