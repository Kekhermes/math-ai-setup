# Guide de démarrage rapide (`math-ai-setup`)

Ce guide est conçu pour une utilisation quotidienne **sans aucune commande informatique à mémoriser**.

> **🆘 Réflexe n° 1 en cas de blocage : appelez le skill `helper-chercheur`**
> Dès qu'un message d'erreur vous semble obscur ou que vous ne savez plus quel bouton cliquer, ouvrez le **Chat VS Code** (`Ctrl+Alt+I` sur Windows / `⌃⌘I` sur Mac) et tapez :
> ```text
> /helper-chercheur Je suis bloqué : [décrivez votre problème ou collez l'erreur ici]
> ```
> *(Sans slash, ça fonctionne aussi en français naturel ; sous Codex, utilisez `$helper-chercheur`.)*
> Détails complets en **section 3** ci-dessous.

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

## 3. En cas de blocage : marche à suivre pas-à-pas avec le skill d'aide (`helper-chercheur`)

Votre espace intègre un **assistant pédagogique dédié (`helper-chercheur`)** conçu pour les mathématiciens peu familiers avec l'informatique. Il diagnostique l'installation, traduit les erreurs en français simple et vous propose au maximum 2 ou 3 actions claires sans rien casser.

### Comment l'appeler (en 3 étapes)
1. **Ouvrez le panneau Chat dans VS Code :** cliquez sur l'icône de discussion en haut de la barre VS Code (ou appuyez sur `Ctrl+Alt+I` sous Windows/Linux, `⌃⌘I` sous Mac).
2. **Appelez explicitement le skill** *(ou écrivez en français naturel)* :
   - Avec **GitHub Copilot** ou **Claude Code** : commencez votre message par **`/helper-chercheur`**.
   - Avec **OpenAI Codex** : commencez par **`$helper-chercheur`**.
   - Ou écrivez simplement : *« Aide-moi, je suis bloqué... »*.
3. **Copiez-collez l'une des demandes prêtes à l'emploi ci-dessous :**

| Votre situation | Message prêt à copier dans le Chat |
|---|---|
| **Je débute / vérifier que tout marche** | `/helper-chercheur Bonjour, je débute. Vérifie mon installation et explique-moi par où commencer.` |
| **J'ai une erreur rouge (LaTeX, Lean, Git, VS Code)** | `/helper-chercheur Je suis bloqué sur ce message : [coller l'erreur]. Explique-moi simplement quoi faire.` |
| **Je ne sais pas quel bouton ou dossier utiliser** | `/helper-chercheur Je veux [écrire un article / préparer un TD / tester une conjecture]. Guide-moi étape par étape.` |
| **Je veux apprendre Lean 4 sans qu'on fasse à ma place** | `/tuteur-lean Je n'ai jamais fait de Lean. Guide-moi sur exemples/00-initiation-lean/BacASableLean.lean sans donner la réponse.` |
| **Je veux sauvegarder sans risque de tout perdre** | `/helper-chercheur Aide-moi à sauvegarder mon travail sur GitHub en toute sécurité.` |

> **Et si même le Chat ne répond pas ?** C'est presque toujours soit Docker Desktop fermé, soit une reconnexion de compte IA nécessaire : regardez le tableau de dépannage express en **section 5** ou ouvrez [`ANNEXE-LICENCES.md`](ANNEXE-LICENCES.md).

---

## 4. Que taper dans le chat pour travailler au quotidien ?

Ouvrez le panneau de discussion IA sur le côté de VS Code, puis copiez l'une de ces phrases :

1. **Pour démarrer un vrai travail :**
   > `Je veux commencer un nouvel article de recherche sur [sujet] dans recherches/. Prépare le dossier.`
   > *(ou pour un cours :)* `Je veux préparer un nouveau cours et une fiche de TD avec corrigé masquable sur [sujet] dans enseignement/.`
2. **Pour tester une conjecture avant de la formaliser en Lean :**
   > `Teste cette conjecture avec Python/SymPy avant qu'on passe à Lean : [énoncé].`
3. **Pour découvrir pas-à-pas les exemples guidés :**
   > `Guide-moi pour démarrer l'exercice exemples/01-preuve-lean-et-sympy/.`

---

## 5. Dépannage express (si le Chat lui-même est bloqué)

| Symptôme | Solution immédiate |
|---|---|
| « Rouvrir dans le conteneur » échoue ou Docker ne répond pas | Vérifiez que **Docker Desktop** est bien démarré sur votre PC Windows ou Mac (petite baleine dans la barre système/menu), puis réessayez. |
| L'assistant dit qu'il ne trouve pas `lean` ou `pdflatex` | Vous êtes hors du conteneur : cliquez sur `><` en bas à gauche → **Rouvrir dans le conteneur**. |
| L'assistant demande de vous connecter (Copilot / Claude / Codex) | Ouvrez [`ANNEXE-LICENCES.md`](ANNEXE-LICENCES.md) section 3, ou demandez dans le chat : *« Aide-moi à reconnecter mon compte IA »*. |
| Vous avez modifié un exemple et voulez repartir à zéro | Demandez dans le chat : *« Remets le dossier exemples à zéro »* (vos dossiers `recherches/`, `preuves/` et `enseignement/` ne seront pas touchés). |
