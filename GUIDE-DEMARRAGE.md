# Guide de démarrage rapide (`math-ai-setup`)

Ce guide est conçu pour une utilisation quotidienne **sans aucune commande informatique à mémoriser**.

---

## 1. Ouvrir votre bureau de travail

> **Prérequis déjà en place sur votre ordinateur :** Docker Desktop doit être **lancé** (petite icône baleine visible dans la barre système Windows ou la barre de menus Mac), avec VS Code et l'extension *Dev Containers* installés.

1. Vérifiez que **Docker Desktop** est démarré (sur Windows ou Mac, ouvrez l'application Docker Desktop si la petite baleine n'apparaît pas).
2. Lancez **VS Code** et ouvrez le dossier `math-ai-setup`.
3. Si une petite fenêtre en bas à droite propose **« Rouvrir dans le conteneur »** (*Reopen in Container*), cliquez dessus (ou cliquez sur l'icône bleue `><` tout en bas à gauche → *Rouvrir dans le conteneur*).
4. Tous vos outils (LaTeX, Lean 4, Python/SymPy, assistant IA) sont déjà installés à l'intérieur. *(La toute première ouverture télécharge et prépare l'environnement : comptez plusieurs minutes ; les suivantes sont quasi instantanées.)*

---

## 2. Les 6 boutons en 1 clic (menu `Terminal > Exécuter la tâche...`)

| Bouton / Tâche | Quand l'utiliser ? |
|---|---|
| **`1. Vérifier mon installation (Diagnostic)`** | Au tout début ou si quelque chose semble bloqué. Affiche des voyants verts/rouges en français. |
| **`2. Compiler le document LaTeX actif (PDF)`** | Ouvrez un fichier `.tex` (article ou slides) puis lancez cette tâche pour produire son PDF. |
| **`3. Compiler TD/Examen : Sujet seul + Corrigé`** | Ouvrez un fichier TD/examen `.tex` puis lancez cette tâche : vous obtenez **deux PDF** (`-sujet.pdf` et `-corrige.pdf`). |
| **`4. Vérifier toutes les preuves Lean (lake build)`** | Vérifie mécaniquement toutes les preuves du dossier `preuves/`. |
| **`5. Générer le Blueprint Lean`** | Crée la carte visuelle des dépendances entre vos théorèmes LaTeX et Lean. |
| **`6. Sauvegarder mon travail sur GitHub`** | Sauvegarde proprement vos modifications en vous guidant étape par étape en français. |

---

## 3. Que taper dans le chat la première fois ?

Ouvrez le panneau de discussion IA sur le côté de VS Code, puis copiez l'une de ces 4 phrases :

1. **Pour vérifier et découvrir l'espace :**
   > `Bonjour, je débute avec cet espace. Vérifie mon installation et montre-moi par où commencer.`
2. **Pour découvrir Lean 4 depuis zéro (10 min) :**
   > `Je n'ai jamais utilisé Lean 4. Lance le mode tuteur sur exemples/00-initiation-lean/BacASableLean.lean sans me donner les réponses tout de suite.`
3. **Pour démarrer un vrai travail :**
   > `Je veux commencer un nouvel article de recherche sur [sujet] dans recherches/. Prépare le dossier.`
   > *(ou pour un cours :)* `Je veux préparer un nouveau cours et une fiche de TD avec corrigé masquable sur [sujet] dans enseignement/.`
4. **En cas de blocage ou de message d'erreur incompréhensible :**
   > `Je suis bloqué sur ce message : [coller le message]. Explique-moi simplement ce qui se passe et comment le corriger.`

---

## 4. Dépannage express

| Symptôme | Solution immédiate |
|---|---|
| « Rouvrir dans le conteneur » échoue ou Docker ne répond pas | Vérifiez que **Docker Desktop** est bien démarré sur votre PC Windows ou Mac (petite baleine dans la barre système/menu), puis réessayez. |
| L'assistant dit qu'il ne trouve pas `lean` ou `pdflatex` | Vous êtes hors du conteneur : cliquez sur `><` en bas à gauche → **Rouvrir dans le conteneur**. |
| L'assistant demande de vous connecter (Copilot / Claude / Codex) | Ouvrez [`ANNEXE-LICENCES.md`](ANNEXE-LICENCES.md) section 3, ou demandez dans le chat : *« Aide-moi à reconnecter mon compte IA »*. |
| Vous avez modifié un exemple et voulez repartir à zéro | Demandez dans le chat : *« Remets le dossier exemples à zéro »* (vos dossiers `recherches/`, `preuves/` et `enseignement/` ne seront pas touchés). |
