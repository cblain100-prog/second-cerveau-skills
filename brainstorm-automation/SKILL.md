---
name: brainstorm-automation
description: Lit tout le contexte du second cerveau (CLAUDE.md, memory.md, terrains, journal, skills existants) et en déduit des idées d'automatisation qui feraient gagner du temps. Pour chaque idée, tranche la solution — soit un SKILL déclenché à la main, soit une ROUTINE planifiée (cron) — avec le temps gagné estimé, le déclencheur, et un croquis d'implémentation. Skill 100% générique : il découvre la structure du vault à chaque run, ne présuppose aucun nom de dossier. Utiliser quand l'utilisateur dit "/brainstorm-automation", "brainstorm automation", "qu'est-ce que je peux automatiser", "trouve-moi des idées d'automatisation", "où je perds du temps", "qu'est-ce qui pourrait être un skill ou une routine".
---

# Brainstorm Automation — Détecte ce qui mérite d'être automatisé

Lit le contexte complet du second cerveau, repère les **tâches répétitives ou chronophages**, et pour chacune propose **une** solution concrète : un **skill** (déclenché à la main) ou une **routine** (planifiée, cron). Le livrable est un rapport priorisé, puis une offre de **construire** les automatisations choisies.

Ce skill ne devine pas dans le vide : il s'appuie sur ce qui est **réellement écrit** dans le vault (journal, état des terrains, mémoire) pour ne proposer que des automatisations ancrées dans le vrai quotidien de la personne.

Ce skill est **général** : il ne connaît pas tes terrains à l'avance. Il les découvre en lisant `CLAUDE.md` à chaque exécution, exactement comme `/save`. Conséquence : quand ta structure évolue, tu n'as **rien** à changer ici.

## Principe absolu

**Tu proposes, tu ne construis pas tout de suite.** La sortie par défaut = un rapport d'idées priorisées. Tu ne crées un skill ou une routine que si l'utilisateur valide une idée précise. Une idée d'automatisation vague et non validée ne doit jamais devenir du code.

**Tu pars du réel, pas du générique.** Interdit de balancer une liste de "10 automatisations que tout entrepreneur devrait avoir". Chaque idée doit pointer une **preuve dans le vault** (« tu fais X tous les lundis d'après ton journal », « ce process est décrit à la main dans tel terrain »).

**Tu ne réinventes pas l'existant.** Avant de proposer, inventorie les skills déjà installés. Si une tâche est déjà couverte, ne la propose pas (au mieux : suggère de la transformer de skill manuel → routine).

## Étape 0 — Charger le contexte de routing

1. Lis le `CLAUDE.md` du vault, en particulier la carte **"Routing — où lire et écrire"** et la structure des **terrains** : c'est ta carte du territoire. Elle te dit où vit l'activité de la personne.
2. Repère les **fichiers d'entrée** auto-chargés (souvent `memory.md` + un `_context.md` par terrain) : ils décrivent les règles, l'état et les process.

## Étape 1 — Lire le contexte réel (les sources de signaux)

Lis, dans cet ordre, en t'arrêtant à ce qui existe (le skill est générique, tous ces fichiers ne sont pas garantis) :

| Source | Ce que tu y cherches |
|---|---|
| **`memory.md`** + règles | Comportements répétés, corrections récurrentes, frictions notées |
| **`Journal/` (30 derniers jours)** | **La source #1.** Actions qui reviennent ("encore fait X", "comme chaque semaine", recaps identiques d'une semaine sur l'autre) |
| **`_context.md` de chaque terrain** | Process décrits à la main, étapes manuelles, "checklist" qu'on refait |
| **État / pipeline des terrains** | Tâches de suivi récurrentes (relances, mises à jour de statut, recaps) |
| **Skills déjà installés** (`.claude/skills/`) | Ce qui est **déjà** automatisé → à exclure des propositions |
| **Routines / cron déjà en place** | Ce qui tourne déjà tout seul → à exclure |

Pour le journal, grep les marqueurs de répétition : `chaque`, `tous les`, `encore`, `comme`, `relance`, `recap`, `à la main`, `manuel`, jours de semaine, et toute action qui apparaît à dates régulières.

## Étape 2 — Détecter les candidats à l'automatisation

Une tâche mérite d'être automatisée si elle coche **au moins un** critère :

- **Répétée** : revient au moins ~1×/semaine (ou à fréquence fixe).
- **Mécanique** : suit des étapes prévisibles (peu de jugement créatif unique).
- **Chronophage** : prend du temps réel cumulé (même 10 min × 5/semaine = 40 min/sem).
- **À déclencheur clair** : un événement ou une horloge la déclenche (mail reçu, appel terminé, lundi 9h, fin de mois).

Écarte : les tâches uniques, celles qui demandent un vrai jugement humain à chaque fois, et tout ce qui est déjà couvert par un skill/routine existant.

## Étape 3 — Trancher la solution : SKILL vs ROUTINE

Pour **chaque** candidat retenu, choisis **un seul** type. La règle de décision :

```
Le déclencheur est-il une HORLOGE / un calendrier (tous les jours, chaque lundi, fin de mois) ?
 ├─ OUI → ROUTINE planifiée (cron). Tourne sans que la personne y pense.
 └─ NON → le déclencheur est un MOMENT décidé par la personne
          ("après cet appel", "quand je veux", "à la demande") ?
          → SKILL déclenché à la main.

Cas mixte (process complexe lancé à la main MAIS aussi planifiable) :
 → Construire d'abord le SKILL, puis l'envelopper dans une ROUTINE qui l'appelle.
   (Une routine n'est souvent qu'un skill + un horaire.)
```

Heuristiques complémentaires :
- **Skill** : sortie qui demande relecture/validation humaine, ou input variable fourni par la personne (un lien, un nom de client, une conversation en cours).
- **Routine** : tâche de veille, d'agrégation, de rappel, de nettoyage, de reporting périodique — utile même si personne ne la regarde sur le moment.

## Étape 4 — Rédiger le rapport (livrable par défaut)

Présente les idées **priorisées par temps gagné** (impact × fréquence), les plus rentables en premier. Pour chacune, ce format compact :

```markdown
### [N]. [Nom de l'automatisation] — `SKILL` | `ROUTINE`
- **Le problème** : [tâche répétée, ancrée dans une preuve du vault — cite la source]
- **Temps gagné** : ~[X min] × [fréquence] = **[Y/semaine ou /mois]**
- **Solution** : [SKILL déclenché par "…" | ROUTINE qui tourne à …]
- **Déclencheur** : [phrase / événement, ou horaire cron]
- **Ce que ça ferait** : [3-5 étapes du flux, en une ligne chacune]
- **Briques** : [outils/MCP/skills réutilisés — ex. transcription, CRM, mail, web]
- **Effort de build** : [faible / moyen / élevé]
```

Termine par une ligne de synthèse : nombre d'idées, temps total potentiellement gagné par semaine, et **la question** : « Laquelle je te construis en premier ? »

Si tu n'as **rien** trouvé de solide (vault trop jeune, pas assez de journal), dis-le franchement et propose à la place 2-3 pistes à surveiller — sans inventer de fausses répétitions.

## Étape 5 — Construire (seulement si validé)

Quand la personne choisit une idée :

- **Si SKILL** → utilise le skill `skill-creator` s'il est disponible (sinon crée le dossier `.claude/skills/[nom]/SKILL.md` à la main, en suivant le format des skills existants du vault : frontmatter `name` + `description` riche en déclencheurs, puis le process étape par étape). Calque le ton et la structure sur les skills déjà présents.
- **Si ROUTINE** → utilise le mécanisme de planification disponible dans l'environnement (skill `scheduler` / `/schedule`, outil cron, ou le système de routine décrit dans le `CLAUDE.md` du vault). Une routine = un prompt/skill + un horaire cron + une destination de sortie (mail, Telegram, fichier, Notion…).
- Dans les deux cas : construis **une** automatisation à la fois, montre-la, fais-la valider, puis enchaîne sur la suivante si la personne veut.

## Garde-fous

- Ne propose jamais une automatisation déjà couverte par un skill/routine existant.
- N'invente pas de répétition : chaque idée s'appuie sur une trace réelle du vault.
- Ne construis rien sans validation explicite de l'idée précise.
- Reste générique : ce skill doit tourner sur le vault de n'importe qui, sans nom de dossier en dur.
