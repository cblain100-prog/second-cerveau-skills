---
name: triage-mails
description: Récupère les mails des dernières 24h et les classe en important/pas important avec un rapport structuré. Utiliser quand l'utilisateur demande de trier, checker ou trier sa boîte mail.
allowed-tools: ToolSearch, mcp__claude_ai_Gmail__gmail_search_messages, mcp__claude_ai_Gmail__gmail_read_message, mcp__claude_ai_Gmail__gmail_read_thread
---

## Ta tâche

Lire les mails des dernières 24h, les classifier en IMPORTANT / PAS IMPORTANT, et produire un rapport de triage clair.

---

## Étape 1 — Charger les outils Gmail

Utilise `ToolSearch` avec la query `select:mcp__claude_ai_Gmail__gmail_search_messages` pour activer les outils Gmail déférés.

---

## Étape 2 — Récupérer les mails

`gmail_search_messages` avec la query suivante :
```
newer_than:1d in:inbox
```

Limite à 30 mails maximum. Pour chaque mail, extraire : `id`, `from`, `subject`, `date`, `snippet`.

Si aucun mail : répondre "Aucun mail reçu dans les 24 dernières heures."

---

## Étape 3 — Lire les mails ambigus

Si le snippet seul ne suffit pas à classifier (expéditeur inconnu, objet vague) :
- Utilise `gmail_read_message` avec l'`id` du mail
- Lis les 3-4 premières lignes du corps pour décider

Ne lis pas le contenu complet de tous les mails — seulement les cas douteux.

---

## Étape 4 — Classifier

**IMPORTANT** (action requise de ta part) :
- Expéditeur = personne réelle (exclure noreply@, no-reply@, notifications@, mailer@, newsletter@)
- Objet contenant : urgence, deadline, contrat, facture, relance, devis, candidature, RDV, entretien
- Contexte : clients, partenaires, admin, banque, organismes officiels (impôts, sécu, mairie...)
- Email attendant une réponse ou une action de ta part

**PAS IMPORTANT** (peut être ignoré) :
- Newsletters et abonnements
- Notifications automatiques (GitHub, Stripe, SaaS, alerts)
- Emails marketing et promotionnels
- Alertes réseaux sociaux
- Confirmations de commande/livraison sans action requise
- Emails en masse (liste de diffusion)

---

## Étape 5 — Produire le rapport

Format exact à respecter :

```
## Triage mails — [date du jour]
### 24 dernières heures · [N] mails analysés

---

### IMPORTANTS ([n])

| # | De | Objet | Action |
|---|-----|-------|--------|
| 1 | prenom@domaine.com | Objet du mail | Répondre / Traiter / Appeler |

---

### PAS IMPORTANTS ([n])

| # | De | Objet |
|---|-----|-------|
| 1 | newsletter@domaine.com | Objet du mail |

---

### Résumé
[1-2 phrases sur l'état de la boîte — ex: "3 mails demandent une action aujourd'hui, dont une relance client urgente."]
```

Règles de formatage :
- Tronquer les adresses longues : `prenom@domaine.com` pas `prenom+tag+tracking@long-domain.co.uk`
- Tronquer les objets > 60 caractères avec `...`
- L'action suggérée doit être courte et actionnable : "Répondre", "Appeler", "Payer avant le [date]", "Ignorer si non urgent"
- Si 0 important : écrire "Aucun mail important — boîte claire."
