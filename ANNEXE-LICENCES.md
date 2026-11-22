# Annexe — Licences académiques et connexion de votre assistant IA

Votre espace fonctionne **avec un seul abonnement au choix** parmi **GitHub Copilot**, **Claude Code (Anthropic)** ou **OpenAI Codex** (et permet aussi d'en combiner plusieurs si vous en avez).

---

## 1. Obtenir ou vérifier vos licences (pistes gratuites / universitaires en priorité)

### A. GitHub Copilot Pro **gratuit** (via *GitHub Education for Teachers*)
Si vous êtes enseignant-chercheur, maître de conférences, professeur ou doctorant chargé d'enseignement avec une adresse email universitaire/organisme :
1. Connectez-vous sur `github.com` avec votre compte personnel (ajoutez votre email institutionnel dans les réglages).
2. Allez dans **Profile → Settings → Billing & plans → Education benefits** (ou `education.github.com`) et choisissez **Teacher**.
3. Téléversez une photo nette (prise au téléphone) de votre carte professionnelle ou attestation employeur.
4. Délai habituel : **24 h à 72 h**.
5. **Étape indispensable après validation :** revenez dans **Settings → Copilot settings** et cliquez sur **Get access to GitHub Copilot** puis enregistrez.

### B. Anthropic Claude / Claude Code
- **Vérifier l'université (*Claude for Education*) :** essayez de vous connecter sur `claude.ai` avec votre adresse email universitaire (SSO). Demandez à votre DSI si votre établissement attribue des licences.
- **Programme laboratoire (*Claude Team plan for scientists*) :** destiné aux chercheurs principaux (PI) en université/recherche publique : sièges Standard gratuits (0 $/mois avec 20 $/mois de crédits API) ou Premium à 15 $/mois (5× capacité), pendant 12 mois.
- **Abonnement individuel :** Claude Pro (~20 $/mois, 17 $/mois annuel) ou Max (100 $/mois) inclut **Claude Code**.

### C. OpenAI Codex
- **Vérifier l'université (*ChatGPT Edu*) :** connectez-vous sur `chatgpt.com` avec votre adresse email universitaire (SSO). Vérifiez auprès de la DSI que l'accès local Codex et le *Device code login* sont activés.
- **Abonnement individuel :** ChatGPT Plus (20 $/mois) ou Pro inclut **Codex CLI** et l'extension IDE.

---

## 2. Se connecter dans le conteneur VS Code

> Vos connexions sont enregistrées dans des volumes Docker persistants : une fois connecté, vous n'aurez pas à recommencer à chaque redémarrage.

| Assistant | Comment vous connecter | Piège à éviter |
|---|---|---|
| **GitHub Copilot** | Cliquez sur l'icône de compte en bas à gauche de VS Code → **Se connecter avec GitHub**. | Avoir oublié d'activer Copilot dans les réglages GitHub après l'approbation *Education*. |
| **Claude Code** | Ouvrez un terminal dans VS Code (`Terminal > Nouveau terminal`) et tapez : `claude auth login` → ouvrez l'URL affichée dans votre navigateur et collez le code. | **Ne définissez pas** `ANTHROPIC_API_KEY` si vous utilisez un abonnement Claude Pro/Max/Team : sinon Claude Code facturerait à l'usage sur clé API au lieu d'utiliser votre abonnement ! |
| **OpenAI Codex** | Ouvrez un terminal dans VS Code et tapez : `codex login --device-auth` → ouvrez le lien indiqué et entrez le code affiché. | Sur ChatGPT Edu, vérifiez dans *Paramètres → Sécurité* que la connexion par code d'appareil (*Device code login*) est activée. |

Pour vérifier à tout moment ce qui est prêt : menu **Terminal → Exécuter la tâche... → `1. Vérifier mon installation (Diagnostic)`**.
