---
name: discover-automations
description: Découverte des automatisations que le second cerveau peut RÉELLEMENT faire tourner, en croisant le contexte du vault (terrains, journal, process décrits, mémoire) avec les outils MCP réellement branchés à Claude (messagerie, agenda, notes/CRM, no-code, base de données, formulaires, etc. — quels qu'ils soient chez cette personne). Pensé pour être lancé juste après l'onboarding ("mon contexte est créé, qu'est-ce que mon cerveau peut faire pour moi maintenant ?"). Explore d'abord le vault et inventorie les MCP/skills/routines branchés, puis livre un rapport d'idées priorisées par temps gagné — chaque idée tranchée en SKILL (déclenché à la main) ou ROUTINE (cron), et garantie exécutable avec les outils réellement connectés. Construit une automatisation à la fois, seulement sur validation. Utiliser quand l'utilisateur dit "/discover-automations", "discover automations", "qu'est-ce que mon cerveau peut faire pour moi", "qu'est-ce que je peux automatiser", "découvre mes automatisations", "explore les automatisations possibles", "j'ai fini mon onboarding et maintenant", "montre-moi ce que mon second cerveau peut automatiser", "qu'est-ce que mes outils branchés me permettent de faire".
---

# Discover Automations — Ce que ton cerveau peut déjà faire pour toi

Ce skill répond à une question précise, idéalement posée **juste après l'onboarding** : *« Mon contexte est créé, mes outils sont branchés — concrètement, qu'est-ce que mon second cerveau peut faire tourner pour moi dès maintenant ? »*

Il ne brainstorme pas dans le vide. Il croise **deux réalités** :
1. **Ce que la personne fait vraiment** (terrains, journal, process décrits à la main, frictions notées en mémoire).
2. **Ce que la personne peut vraiment exécuter** (les serveurs MCP réellement branchés + les skills/routines déjà là).

Le livrable = un **rapport d'idées priorisées par temps gagné**, où **chaque idée est garantie réalisable** avec les outils connectés (jamais « il faudrait tel outil » si cet outil n'est pas branché). Puis, sur validation, on **construit une automatisation à la fois**.

Ce skill est délibérément différent d'un brainstorm à froid centré sur les répétitions du journal : sa colonne vertébrale, c'est « **qu'est-ce que mes outils connectés rendent possible, appliqué à mon activité réelle** ». C'est ce qui fait que les idées sont exécutables tout de suite, pas un jour peut-être.

## Principe absolu

- **Tu proposes, tu ne construis pas tout de suite.** Sortie par défaut = le rapport. On ne code un skill/une routine qu'après validation d'une idée précise.
- **Tu ne proposes que du faisable.** Chaque idée doit être exécutable de bout en bout avec un MCP/outil **réellement branché**. Une idée qui exigerait un outil non connecté ne va PAS dans la liste principale — elle va dans une section séparée « Pour aller plus loin (à brancher) ».
- **Tu pars du réel, pas du générique.** Chaque idée pointe une preuve dans le vault (un process décrit, une action qui revient dans le journal) ET un outil concret pour l'exécuter. Pas de « 10 automatisations que tout entrepreneur devrait avoir ».
- **Tu ne réinventes pas l'existant.** Une tâche déjà couverte par un skill/routine n'est pas reproposée (au mieux : « transforme ce skill manuel en routine planifiée »).

---

## Étape 0 — Explorer le vault (phase d'exploration)

Lance une exploration large du vault **en parallèle** de l'inventaire outils (Étape 1). Pour la breadth, délègue à l'agent `Explore` si disponible, sinon fais-le toi-même.

Cible de l'exploration :
1. Le `CLAUDE.md` du vault — surtout la section de **routing** ("où lire et écrire") et la liste des **terrains** : c'est ta carte du territoire.
2. Le fichier mémoire auto-chargé (souvent `memory.md`) + les `_context.md` de chaque terrain : règles, process décrits à la main, état.
3. Le `Journal/` des ~30 derniers jours (si ce dossier existe) : actions qui reviennent, recaps identiques, marqueurs de répétition (« chaque », « tous les », « encore », « relance », « recap », « à la main », « manuel », jours de semaine).
4. L'état/pipeline des terrains : tâches de suivi récurrentes (relances, mises à jour de statut, reporting).

But : finir avec une liste de **moments métier** réels où du temps se perd ou se répète. Reste générique — découvre la structure, ne présuppose aucun nom de dossier ni de terrain.

## Étape 1 — Inventorier les outils RÉELLEMENT branchés

C'est le cœur de ce skill. Trois sources, par ordre de fiabilité :

**A. Les MCP réellement callables (source de vérité).** Regarde les outils actuellement exposés dans ton propre contexte dont le nom commence par `mcp__`. Le format est `mcp__<serveur>__<outil>`. **Groupe-les par serveur** (le segment entre le 1er et le 2e `__`) → tu obtiens la liste des serveurs MCP réellement branchés ET, pour chacun, les capacités concrètes qu'il expose (ex. créer une page dans l'outil de notes/CRM connecté, envoyer un mail, lire une transcription de réunion, déclencher un workflow no-code, interroger une base de données, publier un déploiement, créer un formulaire, lire un agenda/drive, etc. — la liste réelle dépend entièrement de ce que CETTE personne a branché). Un serveur listé comme « en cours de connexion » sans outils exposés ne compte PAS encore.

**B. Les fichiers de config MCP (pour compléter les noms).** Lis quand ils existent : `~/.claude.json` (clé `mcpServers`), `./.mcp.json`, `./.claude/settings.json`. Utile pour nommer un serveur connu même si tous ses outils ne sont pas chargés.

**C. Skills & routines déjà en place (à exclure des propositions).**
- Skills installés → `~/.claude/skills/` et `./.claude/skills/` (chaque dossier = un skill ; lis le `description` du frontmatter pour savoir ce qu'il couvre déjà).
- Routines/cron déjà planifiées → mécanisme de l'environnement (skill `scheduler` / `/schedule`, cron, ou système de routine décrit dans le `CLAUDE.md`).

Produis mentalement une **palette d'outils** : pour chaque serveur branché, 1 ligne « ce que ça permet de faire ». C'est cette palette qui contraint et inspire les idées.

## Étape 2 — Croiser activité × outils

Pose la matrice : pour chaque **moment métier** repéré (Étape 0), demande-toi *« quel outil branché (Étape 1) pourrait l'exécuter, en tout ou partie ? »*.

Une idée est **retenue** si elle coche :
- **Ancrée** : pointe une preuve réelle dans le vault (process décrit, répétition dans le journal).
- **Exécutable** : réalisable de bout en bout avec un/des MCP **réellement branché(s)** (nomme-le).
- **Rentable** : gain de temps réel cumulé (même 10 min × 5/sem = ~40 min/sem), ou suppression d'une charge mentale/oubli.
- **Non déjà couverte** par un skill/routine existant.

Écarte : tâches uniques, tâches qui exigent un vrai jugement humain à chaque fois, et tout ce qui est déjà automatisé. Une idée séduisante mais qui exige un outil non branché → section « Pour aller plus loin » (ne pas la mélanger aux faisables).

## Étape 3 — Trancher : SKILL vs ROUTINE

Pour chaque idée retenue, choisis **un seul** type :

```
Le déclencheur est-il une HORLOGE / un calendrier (chaque jour, chaque lundi, fin de mois) ?
 ├─ OUI → ROUTINE planifiée (cron). Tourne sans que la personne y pense.
 └─ NON → déclencheur = un MOMENT décidé par la personne ("après cet appel", "quand je veux")
          → SKILL déclenché à la main.

Cas mixte (process lancé à la main MAIS aussi planifiable) :
 → construire d'abord le SKILL, puis l'envelopper dans une ROUTINE qui l'appelle.
```

Heuristiques :
- **Skill** : sortie qui demande relecture/validation humaine, ou input variable fourni par la personne (un lien, un nom de client, une conversation en cours).
- **Routine** : veille, agrégation, rappel, nettoyage, reporting périodique — utile même si personne ne regarde sur le moment.

## Étape 4 — Le rapport (livrable par défaut)

Ouvre par une phrase de cadrage post-onboarding, courte : *« Ton cerveau te connaît maintenant, et voici N outils branchés. Voilà ce qu'il peut déjà faire tourner pour toi, du plus rentable au moins rentable. »*

Puis les idées **priorisées par temps gagné** (impact × fréquence), format compact :

```markdown
### [N]. [Nom de l'automatisation] — `SKILL` | `ROUTINE`
- **Le problème** : [tâche réelle, ancrée — cite la preuve dans le vault]
- **Temps gagné** : ~[X min] × [fréquence] = **[Y/semaine ou /mois]**
- **Outils branchés utilisés** : [serveurs MCP concrets de CETTE personne]
- **Déclencheur** : [phrase déclencheuse, ou horaire cron]
- **Ce que ça ferait** : [3-5 étapes du flux, une ligne chacune]
- **Effort de build** : [faible / moyen / élevé]
```

Termine par :
1. **Une ligne de synthèse** : nombre d'idées faisables, temps total potentiellement gagné/semaine.
2. **Une section « Pour aller plus loin (à brancher) »** : 1-3 idées fortes bloquées par un outil non connecté, avec « branche [X] et ça devient possible ». Honnête, pas de remplissage.
3. **La question** : « Laquelle je te construis en premier ? »

Si tu ne trouves **rien** de solide (vault trop jeune, peu de journal, peu de MCP), dis-le franchement : liste la palette d'outils branchés et propose 2-3 pistes à surveiller — sans inventer de fausses répétitions.

## Étape 5 — Construire (seulement si validé)

Quand la personne choisit une idée :

- **Si SKILL** → utilise le skill `skill-creator` s'il est disponible ; sinon crée `./.claude/skills/[nom]/SKILL.md` à la main, en calquant le format des skills existants du vault (frontmatter `name` + `description` riche en déclencheurs, puis process étape par étape). Réutilise explicitement les MCP identifiés à l'Étape 1.
- **Si ROUTINE** → utilise le mécanisme de planification dispo (skill `scheduler` / `/schedule`, cron, ou le système de routine décrit dans le `CLAUDE.md`). Une routine = un prompt/skill + un horaire cron + une destination de sortie (mail, message, note, fichier…).
- Dans les deux cas : construis **une** automatisation à la fois, montre-la, fais-la valider, enchaîne sur la suivante si la personne veut.

## Garde-fous

- Ne propose **jamais** une idée qui exige un outil non branché dans la liste principale (→ section « à brancher »).
- N'invente pas de répétition : chaque idée s'appuie sur une trace réelle du vault.
- Ne reproduis pas une automatisation déjà couverte par un skill/routine existant.
- Ne construis rien sans validation explicite de l'idée précise.
- Reste 100% générique : ce skill doit tourner sur le vault de n'importe qui, sans nom de dossier ni nom de MCP en dur — tu découvres les terrains ET les outils à chaque run.
</content>
