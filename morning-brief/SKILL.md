---
name: morning-brief
description: Briefing matinal automatique. Agrège mails importants, rendez-vous du jour, tâches en cours, et notifications clés. Lit d'abord la carte de routing du CLAUDE.md du vault pour savoir où vivent les tâches/rappels, avec des replis génériques sinon. Utiliser quand l'utilisateur dit "morning-brief", "brief du matin", "quoi de prévu aujourd'hui", "c'est quoi le programme", ou au lancement de la première session du jour.
---

# Morning Brief — Briefing Matinal (piloté par CLAUDE.md)

Tu prépares le brief du matin. Objectif : en 2 minutes de lecture, l'utilisateur sait exactement ce qui l'attend aujourd'hui.

Ce skill est **général** : il ne connaît pas la structure du vault à l'avance. Il découvre où vivent les tâches, le calendrier et les rappels en lisant le `CLAUDE.md` du vault à chaque exécution (comme `/save`). Conséquence : quand la structure évolue, tu n'as **rien** à changer ici.

## Étape 0 — Lire la carte de routing (CLAUDE.md) — OBLIGATOIRE, EN PREMIER

Avant de lancer la collecte, lis le `CLAUDE.md` à la racine du vault et repère sa section de **routing** (souvent titrée "Routing — où lire et où écrire" ou équivalent). Elle t'indique notamment :

- où vivent les **tâches / to-do** en cours (fichier ou dossier),
- où vivent les **dossiers clients/projets** (pour lier un rendez-vous à son dossier),
- où vivre des **rappels personnels** (anniversaires, échéances récurrentes) si un tel fichier existe,
- toute autre source pertinente pour un brief du jour (leçons récentes, logs d'automatisation, etc.).

**Repli** : si `CLAUDE.md` est absent, sans section routing, ou trop maigre pour décider → utilise les **replis génériques** de chaque agent ci-dessous. Ne bloque jamais faute de carte.

## Collecte de données (en parallèle via subagents)

Lance en parallèle les agents pertinents (adapte selon les MCP réellement connectés — ne lance pas un agent pour un outil absent) :

### Agent 1 : Mails
- Utilise le MCP Gmail (ou équivalent connecté) pour récupérer les mails des dernières 12h
- Classe en : urgent (réponse nécessaire) / informatif (à lire) / ignorable
- Ne liste que les urgents et informatifs

### Agent 2 : Calendrier
- Utilise le MCP Google Calendar (ou équivalent connecté) pour récupérer les événements du jour
- Pour chaque événement : heure, titre, participants
- Si l'événement ressemble à un rendez-vous client/prospect (nom d'une personne ou d'une entreprise en participant) : cherche si un dossier correspondant existe dans le vault (grep du nom via la carte de routing "clients/projets") et ajoute le lien s'il existe

### Agent 3 : Tâches en cours
- Lis le fichier de tâches/to-do que la carte de routing désigne (ex. une entrée du type "tâches actives → tel fichier")
- **Repli générique** si rien n'est désigné : cherche un fichier nommé `todo.md`, `tasks.md` ou une section "tâches" dans le journal du jour/de la veille
- Si la carte de routing mentionne un fichier de leçons/erreurs récentes, lis les 3 dernières entrées
- Si la carte de routing mentionne des logs d'automatisations (scripts, cron, intégrations), vérifie s'il y a des échecs récents à signaler

### Agent 4 : Notifications business
- Si des MCP/outils de notifications sont connectés (réseaux sociaux, plateforme de communauté, CRM, outil de sondage...), vérifie les événements marquants récents (nouveaux commentaires importants, nouvelles inscriptions, nouveaux leads, etc.)
- Skip cet agent proprement si aucun outil de ce type n'est connecté — ne pas halluciner de données

### Agent 5 : Rappels personnels (optionnel)
- Uniquement si la carte de routing désigne un fichier de rappels personnels (ex. anniversaires, échéances récurrentes)
- **Repli générique** : cherche un fichier au nom explicite (`Anniversaires.md`, `rappels.md`...) dans le dossier personnel du vault s'il existe ; sinon **saute cet agent silencieusement**, ne pas le mentionner dans le brief
- Si un format `JJ/MM — Nom — relation — note` (ou équivalent) est détecté, compare avec la date du jour :
  - **Aujourd'hui** : flag rouge, suggérer une action
  - **Demain** : flag orange, rappel pour préparer
  - **Cette semaine** (7 prochains jours) : flag info

## Format de sortie

```
# Brief du {date} — {jour de la semaine}

## Agenda du jour
- 09:00 — {titre du rendez-vous} → [dossier lié](chemin) (si trouvé)
- 14:00 — {autre événement}

## Rappels personnels
- AUJOURD'HUI : {nom} ({relation}) — action suggérée
- DEMAIN : {nom} ({relation})
- CETTE SEMAINE : {nom} (dans X jours)

(Section entièrement omise si aucun fichier de rappels trouvé ou rien dans les 7 prochains jours)

## Mails urgents ({nombre})
- {Expéditeur} — {Sujet} — {1 ligne résumé}

## Tâches actives
- [ ] {Tâche 1}
- [ ] {Tâche 2}

## Alertes
- {Automation échouée / notification business importante} (section omise si rien)

## Focus du jour
{1 phrase : ce qui devrait être la priorité #1 aujourd'hui basé sur le contexte collecté}
```

## Règles

- Maximum 30 lignes de sortie — c'est un brief, pas un roman
- Si rien d'urgent : le dire clairement, ex. "RAS, journée clean"
- N'invente jamais une source de données absente (pas de MCP connecté, pas de fichier trouvé) : omets la section plutôt que de la remplir de suppositions
- Si un rendez-vous client/prospect est prévu et qu'un dossier correspondant existe, suggérer de le consulter avant l'appel

## Edge cases

- **Pas de CLAUDE.md / pas de section routing** : utilise les replis génériques de chaque agent, ne bloque pas
- **Aucun MCP connecté du tout** (ni mail ni calendrier) : le signaler clairement ("aucune source de données connectée pour le brief automatique") plutôt que d'inventer un contenu
- **Fichier de tâches introuvable** : le dire dans la section Tâches actives ("aucun fichier de tâches détecté") plutôt que de laisser la section vide sans explication
