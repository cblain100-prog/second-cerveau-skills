# Structure générée et gabarits des fichiers

Fichier de référence des skills `onboarding` et `onboarding-migrate`, appelé en Phase 3 (génération). C'est LA source de vérité de ce que l'installateur crée chez la personne. La doctrine complète (pourquoi cette forme, ce qui a été écarté) est tenue par l'auteur du pack ; ce fichier en est la version exécutable.

Règles de génération, valables pour tous les gabarits :

- Toujours les vraies réponses de la personne. Jamais de `[Prénom]` ni de crochet vide dans un fichier final ; une info absente s'écrit « non renseigné ».
- Jamais de tiret cadratin « — » ni de demi-cadratin « – » dans ce qui est écrit : virgule, deux-points, point ou parenthèses. Le trait d'union dans les mots composés reste permis.
- Une section dont le bloc d'interview n'a pas été fait reste présente, avec une ligne : « Non renseigné au setup. À compléter, ou relancer `/onboarding` sur ce bloc. »
- Ne jamais écraser un fichier existant : compléter ou fusionner, et le dire en Phase 4.
- Un module (`Clients/`, `Equipe/`, `Skills/`, `Apps/`) n'est créé que s'il reçoit au moins un fichier réel. Exceptions assumées, créées vides pour que la personne voie où déposer : `0 Inbox/`, `2 Archives/`, `Docs/` des terrains de vie, et dans le business `Docs/charte/`, `Docs/offre/`, `Docs/templates/`.
- **Règle Apps : deux dossiers côte à côte, `Brain/` (le contexte) et `Apps/` (le code), qui se connaissent.** `~/Apps/<app>/` contient le code d'une app (Git et sauvegarde en ligne gérés par Claude, `.env` dedans). Dans le cerveau, là où la personne veut voir son app (`Apps/` du terrain, `Clients/<client>/`…), Claude écrit la fiche `<app>.md` (`code: ~/Apps/<app>/`, rôle, URL, lancement, décisions). Dans chaque app, un `AGENTS.md` de trois lignes renvoie au cerveau. Seule la fiche monte dans Drive : ni `node_modules`, ni `.env` chez l'équipe. Depuis le cerveau, « bosse sur l'app X » suffit : Claude lit la fiche et va dans le code. Un dossier de code trouvé dans le cerveau est déplacé vers `~/Apps/` et remplacé par sa fiche. Raccourci `<app>` vers le code à côté de la fiche : optionnel (Drive l'ignore), seulement si la personne veut voir le dossier dans le Finder du cerveau.
- Aucun fichier seul à la racine d'un terrain : à part `AGENTS.md` (terrain business seulement) et `_context.md`, tout vit dans un module. `Docs/` n'a que des sous-dossiers et un `_index.md`.

---

## 1. L'arborescence

```
<dossier ouvert>/                     le second cerveau, le dossier ouvert lui-même (pas de sous-dossier Brain/)
├── AGENTS.md                          SEUL fichier lu automatiquement : qui est la personne, ses règles, sa mémoire, la carte, le routing
├── 0 Inbox/                           dépôt brut, trié par /tri-inbox
├── Journal/                           une note par jour (personnel, jamais partagé)
├── Skills/                            les skills du pack (onboarding, onboarding-migrate, app, save, tri-inbox, grill-me), VISIBLES ; jamais de vrai skill dans .claude/
├── 1 Terrains/
│   ├── <Business>/                    LE terrain business, celui qui se partage le jour où il y a une équipe
│   │   ├── AGENTS.md                  mode d'emploi du terrain (racine des employés)
│   │   ├── _context.md                offre, prix, client idéal, positionnement, métier, état du moment
│   │   ├── Clients/                   une entité = un dossier, à plat (clients, prospects, partenaires, prescripteurs)
│   │   │   ├── etat-pipeline.md       état daté : hot leads, prochaines étapes
│   │   │   └── historique-clients.md  index de tous les clients depuis le début
│   │   ├── Process/                   les façons de faire, un fichier par process, un sous-dossier par équipe (même seul)
│   │   │   ├── _index.md              la table équipe → process
│   │   │   ├── Sales/  Ops/  Finance/  Support/  RH/   (seulement ceux qui reçoivent un process)
│   │   │   └── Marketing/             _context.md (stratégie contenu), ton.md (la voix), regles.md (formats) + les process contenu
│   │   ├── Equipe/                    un dossier par personne qui travaille avec la personne (créé si équipe)
│   │   ├── Outils/
│   │   │   └── outils.md              où vit quoi : CRM, banque, facturation, messagerie, Drive ; noms des variables d'env, jamais les valeurs
│   │   ├── Skills/                    skills propres au business (créé quand le premier arrive)
│   │   ├── Apps/                      une fiche par app, <app>.md (code: ~/Apps/<app>/, rôle, URL, lancement, décisions) ; le code est dans ~/Apps/
│   │   └── Docs/                      TOUJOURS le dernier dossier, que des sous-dossiers par type
│   │       ├── _index.md
│   │       ├── charte/                charte-<marque>.md, logo, photos, bannières
│   │       ├── offre/                 programmes, tarifs, argumentaire
│   │       ├── templates/             modèles de documents (facture, devis, propale, compte rendu)
│   │       └── (marche/ marketing/ legal/ finance/ temoignages/ … ouverts quand de la matière arrive)
│   ├── Perso/                         terrain de vie : _context.md (identité, valeurs, mission, proches, rythme, vision, notes privées) + Docs/
│   ├── Admin/                         terrain de vie : _context.md (légal, banque, logement, charges, assurances) + Docs/ (pièces)
│   └── Santé/                         optionnel : _context.md (sommeil, sport, dossier médical) + Docs/
├── 2 Archives/                        ce qui est mort, en bloc
├── .claude/settings.json              le SEUL fichier caché du cerveau (mémoire auto désactivée, hooks). Aucun skill, aucun lien, aucun script là-dedans :
│                                      les raccourcis vers Skills/ vont dans le dossier personnel, hors du cerveau (~/.claude/skills/ pour Claude Code,
│                                      ~/.agents/skills/ pour Codex), posés par link-skills.sh : le cerveau est portable d'un outil à l'autre
├── .env                               clés API locales, jamais partagé
└── .gitignore
```

Ce qui n'existe plus par rapport à l'ancien schéma (2026-09-18) : `profil.md` et `memory.md` (fusionnés dans `AGENTS.md` et dans les `_context.md` de Perso et Admin), `2 Ressources/` (une ressource vit dans le terrain qui s'en sert), `3 Archives/` (devient `2 Archives/`), `branding.md` (devient `Docs/charte/charte-<marque>.md`), `Contenu/` et `Personal Brand` (c'est `Process/Marketing/` + `Docs/marketing/`), `ressources/` dans chaque terrain (c'est `Docs/`).

---

## 2. Commandes de création

```bash
mkdir -p "0 Inbox" Journal Skills "2 Archives" .claude
mkdir -p "$(dirname "$(pwd)")/Apps"     # le dossier jumeau du cerveau, À CÔTÉ de lui (même dossier parent) : le code, jamais dans Drive (règle Apps, skill /app)
B="1 Terrains/<Business>"
mkdir -p "$B/Clients" "$B/Process/Marketing" "$B/Outils" "$B/Docs/charte" "$B/Docs/offre" "$B/Docs/templates"
# une équipe par process seedé : Sales, Ops, Finance, Support, RH, seulement celles qui reçoivent un fichier
mkdir -p "1 Terrains/Perso/Docs" "1 Terrains/Admin/Docs"
# Santé seulement si demandé au Bloc G ; Equipe/ seulement si quelqu'un travaille déjà avec la personne
```

Nom du terrain business : l'orthographe donnée par la personne (accents, casse). Caractères interdits `/ \ : * ?` : demander une variante. Plus de 40 caractères : proposer un raccourci.

Fichiers techniques (ne jamais écraser, compléter) :

- `.claude/settings.json` : `{"autoMemoryEnabled": false}` (la mémoire du cerveau est dans `AGENTS.md`, on évite les doublons). Les hooks sont posés par `setup/install.sh` et appellent les scripts là où ils sont, dans `Skills/onboarding/setup/scripts/`. C'est le seul contenu de `.claude/` : jamais de `.claude/skills/` ni de `.claude/scripts/` dans le cerveau.
- `.env` : en-tête commenté seulement, aucune vraie clé.
- `.gitignore` :

```
.env
.env.*
!.env.example
.DS_Store
node_modules/
__pycache__/
*.log
.claude/settings.local.json
.obsidian/workspace*.json
```

`.env` : exactement ces trois lignes de commentaire, rien d'autre :

```
# Tes clés d'accès aux outils (les « mots de passe » qui permettent à Claude d'utiliser un service).
# Une par ligne, sous la forme NOM=valeur. Exemple : OPENAI_API_KEY=sk-...
# Ce fichier reste sur ton ordinateur : il n'est jamais partagé ni sauvegardé en ligne.
```

---

## 3. `AGENTS.md` racine (le seul fichier auto-chargé)

Moins de 200 lignes. Il contient tout ce qui doit être vrai dans toute conversation ; le détail vit dans les terrains.

```markdown
# <Prénom> : second cerveau

Tu l'ouvres en lançant `claude` depuis ce dossier. Ce fichier est le seul lu automatiquement : il dit qui est <Prénom>, ses règles, sa mémoire, et où vit chaque chose. Tout le reste se lit à la demande.

## Qui est <Prénom> (résumé)

- <Âge>, <Ville>, valeur non-négociable : <valeur racine>.
- <Activité principale en une phrase>. Métier : <archétype ou sur-mesure>, parle sa langue (vocabulaire dans `1 Terrains/<Business>/Process/Marketing/ton.md`).
- [SI entrepreneur] Marque : <Marque>. Offre principale : <offre + prix>. Client idéal : <une ligne>.
- [SI entrepreneur] Émetteur des factures : <nom légal>, <qualité>, SIRET <n°>, <mention TVA>, <email>. Détail → `1 Terrains/Admin/_context.md`.
- Semaine type : <une ligne>. Créneaux protégés : <liste courte>.
- <Langue> / <tutoiement ou vouvoiement> / <direct ou bienveillant> / <bullets ou paragraphes> / emoji <on ou off>.

## SessionStart

Ce fichier suffit pour démarrer. Selon la tâche, lire ensuite : `1 Terrains/<Business>/_context.md` (le business), `1 Terrains/<Business>/Clients/etat-pipeline.md` (où on en est), `1 Terrains/Perso/_context.md` (la personne en détail), `1 Terrains/Admin/_context.md` (légal, banque).

## Règle #1 : une correction modifie la source, ne s'empile pas

Toute correction de <Prénom> (négation, « en fait », « plutôt », « je préfère », reproche, préférence) est bloquante : la traiter avant de continuer.
1. L'appliquer dans la réponse en cours.
2. La router vers sa source de vérité : universelle (vaut partout) → ce fichier, section Mémoire ; propre à un domaine → le fichier du terrain (ton → `Process/Marketing/ton.md`, facturation → `Process/Finance/facturer.md`, info client → `Clients/<slug>/`, outil → `Outils/outils.md`).
3. Upsert : info nouvelle → ajouter ; info qui contredit l'existant → modifier la ligne, jamais deux versions côte à côte.
4. Confirmer : `✓ noté dans AGENTS.md` ou `✓ <fichier> mis à jour`.

## Règle #2 : tout asset entrant devient une note reliée

Quand <Prénom> donne un fichier, un lien ou lâche une idée réutilisable : extraire l'essentiel avec tes mots, une note = une idée, titre descriptif, frontmatter `date` et `source`, rangée via la carte de routing, reliée par 3 à 5 `[[wikilinks]]` aux notes voisines (grep le vault). Si ça venait de `0 Inbox/`, sortir l'original. Confirmer : `✓ capturé dans <chemin>, relié à [[X]], [[Y]]`. Ce qui n'a pas de valeur réutilisable (filler, code) ne devient pas une note.

## Règle #3 : fix de bon sens automatique

Problème évident et bas risque croisé en route (typo, chemin cassé, incohérence) : corriger sans demander, le dire dans le récap. La question reste pour les vraies décisions et les actions irréversibles ou tournées vers l'extérieur.

## Mémoire

Règles universelles, vraies dans toute conversation. Reçoit les corrections de la Règle #1 (upsert, jamais empiler).

### Règles de travail
- Jamais de tiret cadratin « — » ni de demi-cadratin « – », ni de tiret en incise « mot - mot » : virgule, deux-points, point ou parenthèses.
- Exécuter d'abord : jamais de confirmation avant une action demandée. Confirmation uniquement pour l'irréversible non demandé.
- Vérifier avant de dire « fait » : un résultat contrôlé, pas une commande exécutée.
- Bugs : cause racine, pas de rustine.
- Apps : deux dossiers côte à côte, ce cerveau (<chemin réel du cerveau, écrit à la génération>) et `<chemin réel du parent>/Apps/` (le code). Quand je crée ou reprends une app, le code va dans `Apps/<app>/` (Git et sauvegarde en ligne gérés par moi) et j'écris sa fiche `<app>.md` dans le cerveau, à l'endroit demandé (`code:`, rôle, URL, lancement, décisions). « Bosse sur l'app X » : je lis la fiche et je vais dans le code. Jamais de `node_modules` ni de `.env` dans le cerveau. Je n'en parle pas, je le fais.

### Communication
- Parler simple, toujours : des mots de tous les jours, un exemple concret avant l'idée, des phrases courtes. Un mot technique se dit une fois avec sa traduction entre parenthèses, puis on garde la traduction. Jamais de commande ni de chemin technique sans dire d'abord à quoi ça sert. Avant d'envoyer, relire : si un ami non technicien ne comprend pas la phrase, la réécrire.
- <Ce que les autres assistants font qui l'énerve (F6), formulé en règle>.
- <Ce qu'il adore (F7), formulé en règle>.
- Expliquer tout acronyme à la première mention.
- Fin de tâche avec un livrable qui a une URL : redonner le lien.

### Garde-fous (ne jamais faire sans <Prénom>)
- <K2, une ligne par garde-fou, y compris ceux déduits de la déontologie du métier>

### Leçons récentes (< 30 jours, fenêtre glissante)
(vide au setup ; quand une leçon a plus de 30 jours, Claude la déplace lui-même vers `2 Archives/lessons-archive.md`)

## Structure : la méthode des Terrains

Un seul concept : un terrain, c'est un domaine où <Prénom> opère. Chaque terrain a un `_context.md` (ce qui y est vrai, l'état du moment) et un `Docs/` (la matière). Le terrain business ajoute `Clients/`, `Process/` (un sous-dossier par équipe), `Equipe/`, `Outils/`, `Skills/`, `Apps/` et son propre `AGENTS.md` : c'est lui qui se partage via Google Drive le jour où quelqu'un rejoint l'équipe. Aucun fichier seul à la racine d'un terrain ; `Docs/` n'a que des sous-dossiers par type.

```
<dossier>/
├── AGENTS.md               ce fichier
├── 0 Inbox/                dépôt brut, trié par /tri-inbox
├── Journal/                une note par jour
├── Skills/                 skills perso et génériques (save, tri-inbox, grill-me, onboarding…)
├── 1 Terrains/
│   ├── <Business>/         AGENTS.md, _context.md, Clients/, Process/<Équipe>/, [Equipe/], Outils/, [Skills/], [Apps/], Docs/
│   ├── Perso/              _context.md + Docs/
│   ├── Admin/              _context.md + Docs/
│   [└── Santé/             _context.md + Docs/]
└── 2 Archives/             ce qui est mort
```

## Routing : où lire et écrire

- « Qu'est-ce que je dois faire aujourd'hui ? » → `1 Terrains/<Business>/Clients/etat-pipeline.md` + `Journal/` (dernière date)
- Info sur un client, prospect, partenaire → `1 Terrains/<Business>/Clients/<slug>/` (brief.md + notes datées). Lire avant de répondre, écrire sur toute info nouvelle. [SI CRM] Les chiffres et l'état commercial fin restent dans <CRM> ; le dossier garde le résumé et les décisions.
- Comment on fait X → `1 Terrains/<Business>/Process/<Équipe>/<verbe>.md` ; index dans `Process/_index.md`
- Ton, voix, règles de contenu → `1 Terrains/<Business>/Process/Marketing/ton.md` et `regles.md` ; stratégie → `Process/Marketing/_context.md`
- Posts, scripts, vidéos, photos → `1 Terrains/<Business>/Docs/marketing/`
- Charte graphique → `1 Terrains/<Business>/Docs/charte/`
- Offre, prix, programmes → `1 Terrains/<Business>/_context.md` (décisions) et `Docs/offre/` (matière)
- Facturation, légal, RIB → `1 Terrains/Admin/_context.md` ; le process → `Process/Finance/facturer.md` ; modèles → `Docs/templates/`
- Où vit un outil, un identifiant, une variable → `1 Terrains/<Business>/Outils/outils.md`
- Coder, modifier ou lancer une app → lire sa fiche `<app>.md` (dans le terrain ou le dossier client) et aller dans `~/Apps/<app>/` ; ce qu'elle fait et où elle tourne → la fiche
- Identité, proches, agenda, vision, notes privées → `1 Terrains/Perso/_context.md`
- Correction universelle → ce fichier, § Mémoire ; correction de domaine → le fichier du terrain
- Capture brute → `0 Inbox/` ; résumé de session → `Journal/YYYY-MM-DD.md`
- Terrain ou client terminé → `2 Archives/`

Le skill `/save` lit cette carte avant de ranger. Quand la structure évolue, mettre la carte à jour.

## Skills mémoire

- `/app` : crée ou reprend une app selon la règle Apps (code dans `Apps/<app>/` à côté du cerveau, fiche dans le cerveau). « Crée-moi une app… » ou « bosse sur l'app… » suffisent.
- `/save` : fin de session, range ce qui mérite d'être gardé selon la carte de routing.
- `/tri-inbox` : vide `0 Inbox/` vers les terrains.
- `/grill-me` : Claude interroge la personne pour sortir ce qu'elle sait sur un sujet et l'écrire en note rangée.
```

---

## 4. Terrain business

### 4.1 `1 Terrains/<Business>/AGENTS.md` (le mode d'emploi du terrain)

Sert le jour où quelqu'un ouvre ce dossier comme racine (partage Drive). Il doit se suffire à lui-même : les règles de ton y sont répétées, pas pointées vers la racine.

```markdown
# <Business> : mode d'emploi du terrain

Terrain business de <Prénom Nom> (<marque>). C'est le dossier qui se partage : quand quelqu'un rejoint l'équipe, il reçoit ce dossier via Google Drive et l'ouvre comme racine de Claude Code. Ce fichier est alors son point d'entrée.

## Lire en premier
1. `_context.md` : ce qui est vrai de la boîte (offre, prix, client idéal, positionnement, métier, état du moment).
2. `Clients/etat-pipeline.md` : où on en est (clients actifs, leads chauds, prochaines étapes).
3. `Outils/outils.md` : où vit quoi dans les outils. Jamais de valeur de clé dedans.
4. `Process/_index.md` : la table des façons de faire.

## Carte du terrain
<arbre du terrain tel que généré, avec une ligne de description par dossier>

## Règles du terrain
- Aucun fichier seul à la racine : à part `AGENTS.md` et `_context.md`, tout vit dans un module. `Docs/` n'a que des sous-dossiers par type, carte dans `Docs/_index.md`.
- Info client : `Clients/<slug>/` est la source de vérité. Une entité = un dossier, à plat (clients, prospects, partenaires). `brief.md` (qui, contrat, interlocuteurs, décisions, où on en est) + notes datées `YYYY-MM-DD-<equipe>-sujet.md`. Jamais les mails bruts. Client terminé → `2 Archives/clients/` à la racine du cerveau.
- Un process = une suite d'étapes qu'on refait, nommé par le verbe (`facturer.md`), gabarit : quand, qui, étapes, outils, pièges, skill associé. Une décision va dans `_context.md`, un modèle dans `Docs/templates/`, le mode d'emploi d'un outil dans `Outils/outils.md`.
- Process ≠ skill : le process est la façon de faire en mots ; le skill (`Skills/<nom>/SKILL.md`) est sa version exécutable. Tout skill pointe vers un process.
- Le contenu (posts, vidéos, newsletter) n'est pas un module : ses process et sa voix sont dans `Process/Marketing/`, sa matière dans `Docs/marketing/`.
- Pas de `Journal/` ni d'inbox dans ce terrain : un membre d'équipe écrit directement dans `Clients/<slug>/` ou dans son `Process/<Équipe>/`.
- [SI entrepreneur] Facturation : émetteur <nom légal>, jamais le nom de la marque seule. Règles → `Process/Finance/facturer.md`.
- Secrets : jamais de valeur de clé dans ce dossier. `.env` local à la racine du cerveau, `Outils/outils.md` documente seulement les noms.
- Code : jamais ici. Le code d'une app vit dans `~/Apps/<app>/`, le dossier jumeau du cerveau ; ici on trouve sa fiche `<app>.md` (`code:`, rôle, URL, lancement, décisions). Claude fait ça tout seul à chaque app créée ou reprise.
- Ton et forme, valables pour tout ce qui sort de ce dossier : <tutoiement ou vouvoiement>, <langue>, <direct ou bienveillant>, <bullets ou paragraphes>, emoji <on ou off>. Jamais de tiret cadratin « — » ni demi-cadratin « – » ni de tiret en incise : virgule, deux-points, point ou parenthèses. Dans un message client (mail, WhatsApp) : jamais de tirets pour lister ; à la place une flèche `→` ou un retour à la ligne.
- Garde-fous : <les garde-fous K2 qui concernent le business : jamais envoyer à un client sans relecture, jamais publier sans validation, etc.>

## Le jour où il y a une équipe
Partager ce dossier via Google Drive, rien d'autre. Permissions dans l'ordre : le terrain en Lecteur pour tous ; `Clients/` et `Docs/` en Éditeur pour tous ; `Process/<Équipe>/` en Éditeur pour l'équipe ; `Process/Finance/` et `Docs/finance/` héritage coupé. Chaque membre ajoute un raccourci vers ce dossier dans son Mon Drive, le met en miroir, et l'ouvre comme racine de Claude Code. Détail → `Process/RH/integrer-un-collaborateur.md` (écrit le jour où quelqu'un arrive, avec le skill /grill-me si besoin).
```

### 4.2 `1 Terrains/<Business>/_context.md`

```markdown
# <Business> : contexte

Ce qui est vrai de la boîte aujourd'hui. Mis à jour à chaque décision (Règle #1), jamais empilé. L'état opérationnel daté est dans `Clients/etat-pipeline.md`.

## En une phrase
<Ce que fait la boîte, pour qui, comment elle gagne de l'argent.>

## Offre
- <Offre principale> : <prix>, <durée>, <ce qui est livré>
- <Autres offres avec prix, ou « offre unique »>

## Client idéal
<E2 ou D : qui, taille, secteur, problème principal.>

## Positionnement et angle
<D5 : ce que la personne fait différemment, ses convictions, ce sur quoi elle ne transige pas.>

## Process de vente
<E5 en 3 à 5 étapes : d'où vient le lead, comment il devient client.>

## Métier (<archétype ou sur-mesure>)
- Acteurs récurrents : <fournisseurs, prescripteurs, plateformes, partenaires>
- Outils / stack : <liste> (détail et identifiants → `Outils/outils.md`)
- Chiffres qui comptent : <KPIs>
- Cycle et saisonnalité : <pics, creux, échéances>
- Livrables récurrents : <liste>
- Contraintes et déontologie : <réglementation, ce qu'on ne peut pas promettre>
- Tâches répétitives à déléguer en priorité : <les 3 de D8>

## Équipe
<« <Prénom> seul » ou une ligne par personne : prénom, rôle, depuis quand ; dossier dans `Equipe/<prenom>/`>

## Concurrents observés
<J5 ou « non renseigné »>

## Objectifs 3 mois
<K1>

## État du moment (<date du setup>)
<Deux ou trois lignes : ce qui occupe la boîte cette semaine, le terrain principal du moment si plusieurs.>
```

### 4.3 `Clients/etat-pipeline.md` et `Clients/historique-clients.md`

```markdown
# État du pipeline

Fichier daté, réécrit à chaque changement (pas un journal). Lu en premier pour « qu'est-ce que je dois faire aujourd'hui ? ».

## <date du setup>

### Clients actifs
<liste ou « aucun pour l'instant » ; si un CRM existe : « la liste vit dans <CRM>, ici seulement ceux qui demandent une action cette semaine »>

### Leads chauds
<liste : nom, d'où il vient, prochaine étape, date>

### Prochaines étapes
- <action, échéance>
```

```markdown
# Historique des clients

Index de toutes les entités accompagnées depuis le début. Une ligne par client : nom, période, offre, résultat, dossier.

| Client | Période | Offre | Résultat | Dossier |
|---|---|---|---|---|
| <ceux que la personne a cités, sinon vide> | | | | `Clients/<slug>/` |
```

Si la personne a cité des clients actifs au setup : créer `Clients/<slug>/brief.md` pour chacun avec ce qui a été dit (qui, contrat, où on en est), sans inventer. Si un CRM existe, `brief.md` pointe dessus pour les chiffres.

### 4.4 `Process/_index.md` et les process seedés

```markdown
# Process : index

Un fichier = une façon de faire, nommé par le verbe. Gabarit : quand, qui, étapes, outils, pièges, skill associé. <Prénom> est seul, mais chaque process est rangé dans l'équipe qui le portera le jour où elle existe.

| Équipe | Process |
|---|---|
| Sales | <liste des fichiers> |
| Ops | <liste> |
| Finance | <liste> |
| Marketing | <liste> ; doctrine → `Marketing/_context.md`, `ton.md`, `regles.md` |
| Support | <liste ou ligne absente> |
| RH | <liste ou ligne absente> |

Ce qui n'est pas un process : une décision (`_context.md`), une info client (`Clients/<slug>/`), un modèle (`Docs/templates/`), le mode d'emploi d'un outil (`Outils/outils.md`).
```

Gabarit d'un process seedé (rempli avec ce que la personne a dit ; les étapes qu'elle n'a pas décrites s'écrivent « à préciser », jamais inventées) :

```markdown
# <Verbe + objet, ex. Facturer un client>

Quand : <déclencheur>
Qui : <Prénom> (solo) / <Équipe> le jour où elle existe
Étapes :
1. <…>
2. <…>
Outils : <ceux cités, détail dans `Outils/outils.md`>
Pièges : <ce que la personne a signalé, contraintes du métier>
Skill : <aucun pour l'instant, ou `Skills/<nom>` si le pack en fournit un>
```

Les process à seeder par archétype sont listés dans `interview.md` (bibliothèque d'archétypes). Hors bibliothèque : 5 à 8 process déduits des livrables récurrents.

### 4.5 `Process/Marketing/`

- `_context.md` : stratégie contenu (canaux, promesse centrale, rythme, ce qui ramène des clients), d'après D et E. Si la personne ne fait pas de contenu : trois lignes qui le disent, et les canaux d'acquisition réels.
- `ton.md` : la voix, extraite des écrits réels (F8) quand il y en a. Sections : sources analysées, vocabulaire et expressions récurrentes, rythme et structure, tics et signatures, registre, à éviter, vocabulaire métier (D6). Si aucun écrit fourni : ce qui a été dit en F, plus la mention « à affiner avec 2 ou 3 écrits réels ».
- `regles.md` : les règles de forme des livrables (posts, emails, documents) : longueur, structure, interdits (tirets, emoji selon F5), signature, CTA.

### 4.6 `Outils/outils.md`

```markdown
# Outils : où vit quoi

Un outil = une ligne : à quoi il sert, où on le trouve, comment il est organisé dedans. Les clés d'API vivent dans `.env` à la racine du cerveau ; ici on ne note que le NOM de la variable.

| Outil | Rôle | Accès | Organisation / notes |
|---|---|---|---|
| <CRM> | clients, deals | <URL ou chemin> | <ce qu'on y trouve, comment c'est rangé> |
| <facturation> | factures, devis | <URL> | numérotation <AAAA-MM-NNN>, modèle dans `Docs/templates/` |
| <banque> | RIB, encaissements | RIB → <là où la personne a dit qu'il est rangé (E7)> | |
| <messagerie> | mails | | |
| <Drive / stockage> | fichiers lourds (vidéos, exports) | <chemin> | ce qui ne va pas dans le cerveau |
| <outils métier> | | | |

## Variables d'environnement (noms seulement)
- <NOM_VARIABLE> : <à quoi ça sert>
```

### 4.7 `Docs/_index.md` et sous-dossiers

```markdown
# Docs : la carte

La matière du terrain, la référence qu'on va chercher quand on en a besoin. Jamais de fichier seul à la racine de `Docs/` : que des sous-dossiers par type. Un document qui ne rentre nulle part crée son sous-dossier et sa ligne ici.

| Sous-dossier | Ce qu'on y trouve |
|---|---|
| `charte/` | identité visuelle : `charte-<marque>.md` par marque, logos, photos, bannières |
| `offre/` | programmes, tarifs, argumentaires, pages de vente |
| `templates/` | modèles de documents : facture, devis, proposition, compte rendu |
| <autres ouverts au setup : `marketing/` (posts, scripts), `legal/`, `temoignages/`, `fournisseurs/`…> | |
```

`Docs/charte/charte-<marque>.md` (une par marque, d'après le Bloc V) :

```markdown
---
date: <date>
source: <chemin ou lien du document de charte fourni, ou « interview »>
---
# Charte : <Marque> (ou « Personnel, <Prénom Nom> »)

## Logo
<chemin de chaque version : fond clair, fond foncé, monochrome, icône ; ou « à créer »>
## Couleurs
- Principale : <#hex ou nom>
- Secondaire : <…>
- Accent : <…>
## Typographie
- Titres : <police>
- Texte : <police>
## Photos et bannières
<chemins ou liens ; ou « à créer »>
## Style
<V7 en 1 ou 2 mots, et ce que ça interdit>
## Chantiers
<ce qui est « à créer »>
```

Les fichiers de charte fournis (logo, photos) se copient dans `Docs/charte/` avec un nom explicite ; un document de charte volumineux (PDF, brand book) reste où il est et la note pointe dessus.

`Docs/templates/` : chaque modèle fourni (E8) y est copié ; sa nomenclature et ses mentions sont reprises dans `Process/Finance/facturer.md` et dans `1 Terrains/Admin/_context.md`.

### 4.8 `Equipe/<prenom>/` (si G4 a donné quelqu'un)

`Equipe/<prenom>/fiche.md` : rôle, depuis quand, périmètre, outils auxquels la personne a accès, ce qu'elle porte dans `Process/`. Et `Process/RH/integrer-un-collaborateur.md` seedé avec les étapes du partage Drive.

### 4.9 `Apps/<app>.md` dans le terrain (la fiche d'une app)

Une par app, là où la personne veut voir son app (`Apps/` du terrain, `Clients/<client>/`…). Le code, lui, est dans `Apps/<app>/` à côté du cerveau.

```markdown
---
date: <date>
code: <chemin réel>/Apps/<app>/        (le dossier jumeau du cerveau, à côté de lui ; jamais dans Drive)
url: <où l'app tourne : Vercel, VPS, localhost:port ; ou « pas encore déployée »>
---
# <Nom de l'app>

## À quoi elle sert
<une à trois lignes, pour qui, quel problème>

## Comment on la lance
<« dis à Claude : bosse sur <app> » ; ou la commande si la personne est à l'aise>

## Décisions produit
- <date> : <décision>

## État
<en construction / en prod / en pause>, prochaine étape : <…>
```

Le `AGENTS.md` du dossier de code (`Apps/<app>/AGENTS.md`, écrit par Claude quand il crée l'app) tient en trois lignes : ce que fait l'app, « le contexte business est dans `<chemin réel du cerveau>/1 Terrains/<Business>/` », et « Git et sauvegarde en ligne gérés ici, jamais de clé dans le cerveau ». Toujours le chemin réel, jamais `~/Brain/` : le dossier de la personne ne s'appelle pas forcément Brain.

### 4.10 Gabarits complémentaires (tous avec frontmatter `date`, `source: onboarding`)

**Un process de plus pour chaque livrable ou tâche cités hors liste.** La liste de l'archétype est un plancher : si la personne cite un livrable récurrent ou une tâche à déléguer qui n'y est pas (une newsletter, des relances d'impayés), c'est un process de plus, dans l'équipe qui le porte, au gabarit § 4.4.

`Docs/offre/<offre-en-kebab>.md` (une par offre citée en E3) :

```markdown
# <Nom de l'offre>
Prix : <…>. Durée / format : <…>. Ce qui est livré : <…>.
Pour qui : <client idéal, une ligne>. Ce que ça remplace ou évite : <…>.
Comment on la vend : <E5 en une ligne>. Page ou document de vente : <lien, ou « à créer »>.
```

`Process/Ops/methode/_context.md` (archétype coach, agence, consultant : la doctrine de l'accompagnement ou de la prestation, ce qui ne change pas d'un client à l'autre) :

```markdown
# Méthode <Nom>
## Le principe
<l'angle unique D5, en trois lignes>
## Les étapes, du premier contact au bilan
1. <…> (durée, ce qui est produit)
## Ce qu'on ne fait jamais
<contraintes, déontologie, ce qu'on ne promet pas>
```

`Process/Marketing/_context.md` :

```markdown
# Marketing : ce qui est vrai
Canaux : <liste, celui qui ramène des clients en premier>. Rythme : <…>. Promesse centrale du contenu : <…>.
Ce que le contenu doit provoquer : <prise de contact, inscription, appel…>. Où vit la matière : `Docs/marketing/`.
```

`Process/Marketing/ton.md` :

```markdown
# La voix de <Prénom>
Sources : <écrits fournis en F8, ou « aucun écrit fourni, à affiner avec 2 ou 3 posts réels »>
Registre : <tutoiement ou vouvoiement, direct ou chaleureux, langue>. Phrases : <courtes / longues>, <une idée par ligne…>.
Vocabulaire et expressions : <D6, les mots du métier et les siens>. À éviter : <emoji, jargon, tirets, formules creuses…>.
Signature ou tic reconnaissable : <…, ou « aucun »>.
```

`Process/Marketing/regles.md` :

```markdown
# Règles de forme
Post : <longueur, structure, accroche, appel à l'action, interdits>.
Mail et message : <texte continu, pas de tirets pour lister, flèche ou retour à la ligne>.
Document (proposition, compte rendu) : <titres, longueur, ce qu'on met toujours à la fin>.
Toujours : jamais de tiret cadratin ; <emoji on/off selon F5> ; relecture avant envoi.
```

`Clients/<slug>/brief.md` (un par client cité au setup, sans inventer) :

```markdown
# <Nom>
Qui : <personne, société, rôle>. Depuis : <date>. Offre : <laquelle, prix>. Interlocuteurs : <…>.
Où on en est : <une ligne>. Prochaine étape : <…>.
Décisions : - <date> : <…>
Chiffres et suivi fin : <CRM, ou « ici »>.
```

**Modèle décrit sans fichier** (E8 : la personne explique sa facture sans la donner) : écrire `Docs/templates/modele-<type>.md` avec ce qui a été dit (numérotation, mentions, ordre des blocs) et la ligne « modèle réel à déposer dans 0 Inbox pour remplacer cette description ».

---

## 5. Terrains de vie

### 5.1 `1 Terrains/Perso/_context.md`

```markdown
# Perso : contexte

Qui est <Prénom> en détail. Lu à la demande (planning, proches, décisions de vie, ton personnel). Jamais partagé.

## Identité
<A : prénom, nom, âge, ville, situation>
## Proches
<A5 : une ligne par personne>
## Valeurs et mission
<B : valeur racine, autres valeurs par ordre, mission, image de soi>
## Parcours
<C : études, premiers jobs, timeline pro>
## Semaine type et créneaux protégés
<H : lever, coucher, routine, créneaux non négociables, sport, alimentation, pratique mentale>
## Vision et mentors
<J : projets 6 mois, vision 3 à 5 ans, carences, mentors>
## Finances (<mois année>)
<I : revenu, cibles, patrimoine en ordre de grandeur, dettes ; ou « non renseigné »>
## Notes privées (à ne jamais publier ni mentionner, sauf demande explicite)
<K3 ou « rien »>
```

### 5.2 `1 Terrains/Admin/_context.md`

```markdown
# Admin : contexte

Le légal et l'administratif. Lu à la demande (facture, document officiel, contrat).

## Identité légale
- Nom légal sur les factures : <E6>
- Statut : <EI, SASU…>
- SIRET : <…>
- TVA : <assujetti / franchise, mention exacte>
- Qualité : <…>
- Email et adresse professionnels : <…>
## Banque
- RIB : <où il est rangé, jamais les numéros ici>
## Logement, mobilité, charges
<I6, I7, I8 ou « non renseigné »>
## Pièces
`Docs/` : contrats, attestations, justificatifs (déposer ici, une ligne par pièce ajoutée).
```

### 5.3 `1 Terrains/Santé/_context.md` (optionnel)

Sommeil, sport (quoi, fréquence, coach), alimentation, suivi médical si donné ; `Docs/` pour les ordonnances et comptes rendus.

---

## 6. Première note du journal

`Journal/<YYYY-MM-DD>.md` :

```markdown
# Journal : <date>

## Installation du second cerveau
- Installé dans `<pwd>` via `/onboarding` [ou `/onboarding-migrate`].
- Terrain business : <Business> (<archétype>), process seedés : <liste>.
- Terrains de vie : Perso, Admin[, Santé].
- Charte : `1 Terrains/<Business>/Docs/charte/charte-<marque>.md` (<complète / à créer>).
- Assets intégrés : <voix, charte, modèles ; ou « aucun »>.
- [SI migrate] Contexte précédent archivé dans `2 Archives/contexte-pre-migration-<date>/` ; détails non repris : <liste ou « aucun »>.

## Prochaines étapes
- Ouvrir le dossier dans Obsidian (Fichier → Ouvrir un dossier).
- Première vraie discussion : `cd <pwd>` puis `claude`, et demander « qu'est-ce que je dois faire aujourd'hui ? ».
- Compléter les process marqués « à préciser ».
- Déposer dans `0 Inbox/` tout ce qui traîne (docs, exports, notes) puis taper `/tri-inbox`.
- En fin de session : `/save`.
```

---

## 7. Contrôles avant la Phase 4 (obligatoires)

Ne pas annoncer « installé » sans ces contrôles, chacun exécuté et lu :

Ces commandes tournent dans zsh comme dans bash (motifs quotés, `/usr/bin/grep` natif : le `grep` du PATH peut être un autre outil). `B` est le nom exact du terrain business.

```bash
B="1 Terrains/<nom du terrain business>"
G=/usr/bin/grep
EXCL='^(\./)?(Skills|\.claude)/'
# 1. aucun placeholder oublié : dans un fichier généré, aucun <Mot> commençant par une majuscule ni aucun [Prénom]
$G -rnE '<[A-ZÂÉÈÊ][^>]*>|\[(Prénom|Nom|Marque|Ville|Âge|date)\]' --include='*.md' . | $G -vE "$EXCL" | head
# 2. aucun cadratin dans un fichier généré
$G -rn $'\u2014\|\u2013' --include='*.md' . | $G -vE "$EXCL" | $G -v cadratin | head
# 3. chaque terrain a son _context.md, le business a son AGENTS.md et son _index de process
for t in "1 Terrains"/*/; do [ -f "$t/_context.md" ] || echo "MANQUE _context.md : $t"; done
[ -f "$B/AGENTS.md" ] || echo "MANQUE $B/AGENTS.md"; [ -f "$B/Process/_index.md" ] || echo "MANQUE $B/Process/_index.md"
# 4. aucun fichier seul à la racine de Docs/ du terrain business (les terrains de vie ont des pièces à plat, c'est prévu)
find "$B/Docs" -maxdepth 1 -type f ! -name _index.md | head
# 5. AGENTS.md racine sous 200 lignes
wc -l AGENTS.md
# 6. les skills du pack sont visibles, reliés hors du cerveau, et .claude/ ne contient que settings.json
ls Skills/ ; ls -la ~/.claude/skills/ | $G "$(pwd)" ; ls -A .claude/
```

Attendu : 1, 2 et 4 vides ; 3 sans « MANQUE » ; 5 sous 200 ; 6 : chaque skill de `Skills/` a son raccourci dans `~/.claude/skills/` (et dans `~/.agents/skills/` pour Codex), et `ls -A .claude/` ne montre que `settings.json`. Un contrôle qui échoue se corrige avant de passer à la Phase 4. Le résultat est dit à la personne en une ligne (« 6 vérifications passées »).
