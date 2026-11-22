# Annexe — Licences, Plans Académiques et Authentification

> **Objectif :** Permettre au chercheur (et à Kevin lors de la session d'installation) d'identifier les licences déjà détenues, d'activer d'éventuelles licences académiques gratuites ou à tarif réduit, puis de connecter proprement le(s) harnais dans le DevContainer.
> **Date de vérification des offres :** Novembre 2026 (les tarifs et conditions universitaires pouvant évoluer, vérifier chaque portail au moment de l'activation).

---

## 1. Tableau comparatif rapide : quelle voie selon la situation du chercheur ?

| Situation du chercheur | Ce qu'il faut activer / récupérer | Coût indicatif | Fonctionne dans `math-ai-setup` ? |
|---|---|---|---|
| **Enseignant-chercheur / Maître de conférences / Professeur / Doctorant chargé de TD** (avec email institutionnel `.edu`, `.fr` universitaire, CNRS, etc.) | **GitHub Education for Teachers** → donne **GitHub Copilot Pro gratuit** | **0 €** | **Oui (immédiat)** — couvre l'ensemble du projet via le harnais Copilot ! |
| **A déjà ChatGPT Plus, Pro ou ChatGPT Edu (université)** | Pas d'achat supplémentaire : activer l'authentification Codex CLI (`codex login --device-auth`) | Déjà payé (ou **0 €** si *ChatGPT Edu* campus) | **Oui** — couvre tout le projet via OpenAI Codex. |
| **A déjà Claude Pro, Max, Ultra ou Claude for Education (université)** | Pas d'achat supplémentaire : connexion via `claude auth login` | Déjà payé (ou **0 €** si licence labo/campus) | **Oui** — couvre tout le projet via Claude Code. |
| **Dirige une équipe / un projet de recherche académique (PI)** | **Claude Team plan for scientists** (programme Anthropic pour chercheurs/labos) | **0 $/mois** (siège Standard avec 20 $ crédits API) ou **15 $/mois** (siège Premium 5×) pendant 12 mois | **Oui** — idéal pour un labo ou chercheur universitaire. |
| **Aucun abonnement et non éligible Education** | Au choix : **Copilot Pro** (10 $/mois) OU **ChatGPT Plus** (20 $/mois) OU **Claude Pro** (20 $/mois, 17 $/mois annuel) OU clé API à l'usage | 10–20 $/mois (ou paiement au jeton via API) | **Oui** — 1 seul suffit. |

---

## 2. Comment aller chercher chaque licence (pas à pas)

### 2.1 GitHub Copilot Pro gratuit via *GitHub Education for Teachers* (FORTEMENT RECOMMANDÉ)
Même si le chercheur a déjà OpenAI ou Claude, obtenir GitHub Education prend 10 minutes et donne **GitHub Copilot Pro gratuit** + dépôts GitHub Team privés gratuits.

1. **Prérequis :** un compte GitHub personnel + une **adresse email universitaire/recherche vérifiable** + une preuve d'affiliation actuelle (carte professionnelle/enseignant, attestation employeur ou fiche annuaire datée).
   - *Astuce importante :* prendre la photo de la carte avec un téléphone (image nette) plutôt qu'avec la webcam d'ordinateur, souvent rejetée.
2. **Demande :**
   - Se connecter sur `github.com` → cliquer sur sa photo de profil → **Settings** → **Billing & plans** → **Education benefits** (ou `education.github.com`).
   - Choisir **Teacher** (inclut enseignants, chercheurs et faculté d'institutions accréditées).
   - Renseigner l'email académique, sélectionner l'établissement, téléverser la preuve d'affiliation.
3. **Délai et activation :**
   - Approbation généralement entre **24 h et 72 h** (faire la demande **une semaine avant** la session d'installation avec Kevin si possible !).
   - Une fois approuvé par email : revenir dans **Settings → Copilot settings** et cliquer sur **Get access to GitHub Copilot** (activation séparée obligatoire), puis enregistrer les préférences.
4. **Attention (réévaluation mensuelle) :** GitHub revérifie l'éligibilité périodiquement ; conserver l'email académique actif sur le compte GitHub.
5. **Note si utilisation de Codex via Copilot :** un plan Copilot Pro gratuit donne accès aux modèles inclus dans Copilot, mais sélectionner **Codex** comme moteur *via* Copilot requiert *Copilot Pro+* (39 $/mois) ; pour utiliser Codex sans Pro+, se connecter directement avec un compte ChatGPT (voir 2.3).

### 2.2 Anthropic Claude (Claude Code)
Trois voies existent selon la situation du chercheur :

- **Voie A — Vérifier si l'université a *Claude for Education* :**
  - Aller sur `claude.ai`, tenter une connexion avec l'email universitaire (SSO institutionnel). Certaines universités attribuent une licence sur demande au service informatique (DSI / *Research Computing*).
- **Voie B — Programme *Claude Team plan for scientists* (pour PI / chercheurs en université ou organisme public) :**
  - Programme dédié d'Anthropic (12 mois, 1 à 25 sièges) : **sièges Standard gratuits (0 $/mois)** incluant **20 $/mois de crédits API**, ou **sièges Premium à 15 $/mois** (5× capacité + 100 $/mois de crédits API).
  - Un chercheur principal (PI ou équivalent en mathématiques, sciences naturelles, informatique) remplit le formulaire de vérification d'affiliation sur le portail Anthropic *Claude Team for scientists* (délai de revue ~7 jours ouvrés).
- **Voie C — Abonnement individuel ou clé API :**
  - **Claude Pro** (~20 $/mois ou 17 $/mois en annuel), **Max** (100 $/mois), **Ultra** (200 $/mois) → incluent **Claude Code** dans la limite partagée du plan.
  - **Clé API (`console.anthropic.com`) :** facturation purement à l'usage (utile si l'on veut payer uniquement ce qu'on consomme ou utiliser le harnais Claude directement dans VS Code Agent Host en BYOK).

### 2.3 OpenAI (Codex)
Trois voies existent :

- **Voie A — Vérifier si l'université a *ChatGPT Edu* :**
  - Se connecter sur `chatgpt.com` avec l'email universitaire (SSO). Si l'université dispose d'un espace *ChatGPT Edu*, vérifier auprès de la DSI si l'option **Codex Local** et **Device code sign-in for CLI** sont activées (certains campus activent Codex local mais désactivent Codex Cloud).
- **Voie B — Abonnement individuel ChatGPT :**
  - **ChatGPT Plus** (20 $/mois) ou **Pro** (100 / 200 / 500 $/mois) inclut **Codex CLI et l'extension IDE** dans le quota du plan. *(Les plans Free/Go ne listent Codex que dans l'application desktop, pas pour le CLI.)*
- **Voie C — Clé API (`platform.openai.com`) :**
  - Facturation à l'usage par jeton (indépendante d'un abonnement ChatGPT).

---

## 3. Connexion technique dans le DevContainer (sans pièges)

Dans un DevContainer, le conteneur n'a pas toujours accès direct au navigateur de la machine hôte, et certaines variables d'environnement peuvent basculer la facturation à l'insu de l'utilisateur.

| Harnais | Commande / Méthode dans le conteneur | Piège à éviter absolument |
|---|---|---|
| **GitHub Copilot** | Automatique via la connexion GitHub de VS Code (ou `gh auth login` / `copilot` CLI). | Oublier de cliquer *« Get access to GitHub Copilot »* dans les paramètres GitHub après l'approbation Education. |
| **Claude Code (abonnement Pro/Max/Team/Edu)** | Lancer `claude auth login` (copier l'URL affichée, se connecter dans le navigateur du PC, coller le code) ou générer un token longue durée via `claude setup-token`. | **PIÈGE CRITIQUE :** Si une variable `ANTHROPIC_API_KEY` est définie dans l'environnement ou `.bashrc`, Claude Code **ignore l'abonnement Pro/Max** et facture sur la carte bancaire de l'API Console ! Ne définir `ANTHROPIC_API_KEY` que si l'on veut volontairement facturer à l'API (ou pour le mode BYOK de VS Code Agent Host). |
| **OpenAI Codex (abonnement Plus/Pro/Edu)** | Lancer `codex login --device-auth` → ouvrir le lien court sur le PC et saisir le code à usage unique. *(Pour ChatGPT Edu/Team, vérifier que « Device code login » est activé dans les paramètres sécurité ChatGPT.)* | Laisser la double intégration active (extension Codex + Agent Host Codex) : choisir une seule méthode dans `.vscode/settings.json`. |
| **OpenAI Codex (clé API)** | `printenv OPENAI_API_KEY \| codex login --with-api-key` | Utilise la facturation API pay-as-you-go au lieu des crédits ChatGPT Plus/Pro. |

> **Persistance :** grâce aux volumes Docker montés sur `/home/vscode/.copilot`, `/home/vscode/.claude` et `/home/vscode/.codex`, une fois connecté pendant la session avec Kevin, le chercheur reste connecté même après redémarrage du PC ou mise à jour du conteneur.

---

## 4. Checklist de la session d'installation (pour Kevin)

### Avant la visite (J-7 — envoyer ce rappel au chercheur)
- [ ] Demander au chercheur s'il a déjà un compte GitHub, OpenAI/ChatGPT et/ou Anthropic/Claude.
- [ ] Lui faire déposer sa demande **GitHub Education for Teachers** (1 semaine avant, car l'activation prend jusqu'à 72 h).
- [ ] Vérifier s'il souhaite demander **Claude Team for scientists** ou vérifier l'accès **ChatGPT Edu / Claude for Education** de son université.

### Pendant la session sur le PC du chercheur (60–90 min)
1. [ ] Vérifier Docker Desktop / Docker Engine actif + espace disque libre suffisant (**au moins 15 Go** recommandés pour l'image + TeX Live + Lean 4 + cache Mathlib).
2. [ ] Vérifier VS Code + extension *Dev Containers* (`ms-vscode-remote.remote-containers`).
3. [ ] Configurer GitHub (compte du chercheur + dépôt **privé** créé depuis `math-ai-setup`, authentification Git configurée).
4. [ ] Ouvrir le dossier dans VS Code → **Rouvrir dans le conteneur** (*Reopen in Container*). Laisser `setup.sh` installer les paquets et télécharger le cache Mathlib.
5. [ ] Connecter le(s) harnais disponibles (Copilot, et/ou Claude, et/ou Codex) et vérifier qu'aucune clé API parasite ne court-circuite un abonnement.
6. [ ] Cliquer sur la tâche VS Code **`1. Vérifier mon installation (Diagnostic)`** et vérifier que tous les voyants sont verts.
7. [ ] Ouvrir le chat VS Code avec le chercheur et taper : *« Bonjour, je débute avec cet espace, guide-moi sur le premier exemple. »* pour valider le **Skill Helper** en conditions réelles.
