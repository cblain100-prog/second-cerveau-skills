---
name: onboarding
description: Installe un second cerveau Claude Code de zéro avec la méthode des Terrains (structure figée le 2026-09-18). Interview adaptée au métier (identité, activité, deep-dive métier par archétype, business, charte, terrains, rythme, garde-fous), récupère les assets existants (écrits, charte, modèles de factures) pour en extraire le ton et les règles, puis génère DIRECTEMENT dans le dossier ouvert un AGENTS.md unique (seul fichier auto-chargé), un terrain business complet (AGENTS.md, _context.md, Clients/, Process/<Équipe>/ avec les process du métier, Outils/, Docs/ en sous-dossiers) et les terrains de vie (Perso, Admin, Santé), explique le système à la fin, propose la sauvegarde en ligne et le récap du soir. Pas de sous-dossier Brain/, pas de profil.md ni memory.md. Pour un dossier qui contient déjà un contexte Claude (AGENTS.md, memory.md, notes), utiliser /onboarding-migrate. Utiliser quand l'utilisateur dit "/onboarding", "onboarding", "crée mon contexte", "setup mon brain", "installer mon second cerveau", "créer mon second cerveau", ou ouvre Claude Code pour la première fois dans un dossier vide.
---

# Onboarding : installer un second cerveau de zéro (méthode des Terrains)

Ce skill installe la fondation d'un second cerveau Claude Code dans un dossier vide ou presque. Il interviewe en profondeur, **en s'adaptant au métier de la personne**, récupère ce qu'elle a déjà produit, génère la structure, puis explique comment tout fonctionne. En dernier lieu il propose la plomberie qui fait vivre le cerveau tout seul (sauvegarde en ligne, relevé du soir). Proposé, jamais imposé.

Deux fichiers de référence, dans `references/`, sont la source de vérité de ce skill :

- `references/interview.md` : les blocs de questions A à K et V, la bibliothèque d'archétypes métier (avec les process à seeder), le cadre universel pour tout métier hors bibliothèque.
- `references/structure.md` : l'arborescence exacte à générer et le gabarit de chaque fichier, plus les contrôles de fin.

Le skill jumeau `/onboarding-migrate` sert quand le dossier contient déjà un contexte (AGENTS.md, memory.md, notes, dossiers de projets) : il absorbe l'existant avant d'interviewer. Si en Phase 0 tu découvres un vrai contexte existant, propose de basculer dessus.

## Ce que le skill installe (à savoir avant de commencer)

- **Un seul fichier lu automatiquement** : `AGENTS.md` à la racine (format neutre, lu par Claude Code depuis la 2.1.277 et par Codex ; jamais de `CLAUDE.md` à côté, sinon Claude Code ignore `AGENTS.md`). Il contient qui est la personne, ses règles, sa mémoire (les corrections qu'elle fait en cours de route), la carte du dossier et le routing. Pas de `profil.md`, pas de `memory.md` : deux fichiers de plus à expliquer, pour rien.
- **Des terrains.** Un terrain, c'est un domaine où la personne opère. Le terrain **business** (nom de la boîte ou de la marque) contient `Clients/`, `Process/` découpé par équipe, `Outils/`, `Docs/` en sous-dossiers, et son propre `AGENTS.md` : c'est le dossier qui se partage le jour où quelqu'un rejoint l'équipe. Les terrains de **vie** (Perso, Admin, Santé) n'ont qu'un `_context.md` et un `Docs/`.
- **Le contenu n'est pas un terrain** : publier est un process du marketing. La voix et les règles vivent dans `Process/Marketing/`, la matière dans `Docs/marketing/`.
- **Le code n'est pas dans le cerveau** : deux dossiers côte à côte, le cerveau (le contexte) et `Apps/` dans le même dossier parent (le code). Le lien est fait par Claude via le skill `/app` (fiche dans le cerveau, `AGENTS.md` dans l'app). La personne retient « Brain c'est ce que je sais, Apps c'est ce que je construis, je parle toujours depuis Brain ».
- **Deux réflexes de mémoire** : les corrections en direct vont dans la source de vérité du sujet (Règle #1, dans `AGENTS.md`) ; `/save` en fin de session range le reste. `/save` est livré avec le pack de skills, l'onboarding ne l'installe pas, il l'explique.
- **Le dossier ouvert (`pwd`) devient le cerveau.** Jamais de sous-dossier `Brain/`.

**Quand expliquer** : un cadrage léger au début (Phase 0), l'explication complète à la fin (Phase 4), une fois les fichiers sous les yeux.

## Ton pendant le setup

- Français par défaut (bascule selon le Bloc F), tutoiement, direct et bienveillant, bullets, zéro emoji, zéro fluff.
- **Parler simple, c'est une règle, pas un style.** La personne n'est pas technique. Concrètement :
  - des mots de tous les jours : « ton dossier », « ton cerveau », « un fichier texte », « sauvegardé en ligne ». Jamais « vault », « repo », « commit », « push », « hook », « symlink », « markdown », « prompt », « workspace », « auto-loaded », « CLI », « terminal » sans l'expliquer ;
  - un mot technique inévitable se dit une fois, avec sa traduction entre parenthèses, puis on garde la traduction : « GitHub (l'endroit où ton code est sauvegardé en ligne) » ;
  - un exemple concret avant toute idée abstraite : « quand tu me dis “crée-moi une app de devis”… » avant « le code vit à côté du cerveau » ;
  - des phrases courtes, une idée par phrase, jamais trois termes nouveaux dans la même phrase ;
  - ne jamais montrer une commande ou un chemin technique à la personne sauf si elle le demande ; si on en montre un, dire d'abord à quoi il sert ;
  - se relire avant d'envoyer : si un ami non technicien ne comprendrait pas la phrase, la réécrire.
  Cette règle est aussi écrite dans le `AGENTS.md` généré (§ Communication), pour que Claude continue à parler comme ça après l'installation.
- **Un bloc à la fois.** Attends les réponses avant le suivant.
- Sur le métier : un confrère curieux, pas un formulaire. Rebondis, emploie son vocabulaire.
- Jamais de tiret cadratin « — » ni de demi-cadratin « – » dans ce que tu écris (messages et fichiers) : virgule, deux-points, point, parenthèses.

À la fin du setup, le ton de l'agent sera celui choisi par la personne (Bloc F). Pendant le setup, c'est celui-ci.

---

## Phase 0 : dossier et accord

Avant toute question, en parallèle : `pwd`, `ls -la`, test d'écriture (`touch .test-write && rm .test-write`).

Si le dossier contient déjà un `AGENTS.md`, un `memory.md`, un `profil.md`, ou des dossiers de notes et de projets avec de la substance : **ce n'est pas un onboarding de zéro**. Dis-le : « Ton dossier contient déjà du contexte (liste). Le bon outil c'est `/onboarding-migrate`, qui reprend ce qui existe au lieu de te faire tout redire. Je bascule dessus ? » Si oui, arrête ici et lance-le. Si la personne insiste pour repartir de zéro, continue, sans jamais écraser un fichier existant.

Puis affiche ce message (adapte les chemins) :

```
Salut. Je suis là pour installer ton second cerveau.

Le dossier de travail : tu m'as ouvert dans [pwd].
Ce dossier va devenir ton second cerveau. C'est lui qui contiendra tout
ton contexte (qui tu es, ton métier, tes clients, tes façons de faire,
tes règles, ton journal) et qui te suivra dans toutes nos discussions.

[SI contenu : « Il y a déjà des fichiers dedans : [liste]. Je n'écrase
rien. On continue ici, ou tu préfères un dossier vide ? »]
[SI vide : « Le dossier est vide, parfait. »]

Une chose à comprendre dès maintenant : ce cerveau n'est pas figé après
l'installation. Chaque fois que tu me corriges, que tu me donnes une info
sur toi ou ton activité, je l'écris dans tes fichiers. Plus on parle,
plus il te ressemble. Aujourd'hui on pose la fondation.

En deux mots, comment ça marche (je te réexplique tout à la fin, avec
les fichiers sous les yeux) :
- ton cerveau = des fichiers texte, rangés par « terrains » (ton
  business d'un côté, ta vie de l'autre) ;
- quand tu me corriges, je le note tout seul, au bon endroit ;
- en fin de session, tu tapes « /save » et je range ce qu'on s'est dit.

Durée : fondations seules, 30 minutes ; installation complète, 1 heure.
Tu peux sauter une question si tu n'as pas la réponse.

Tu es prêt ? (oui / change de dossier / pas maintenant)
```

- « oui » → Phase 0.5.
- « change de dossier » → demande le chemin absolu, refais Phase 0 dessus (propose `mkdir -p` s'il n'existe pas).
- « pas maintenant » → « OK, relance /onboarding quand tu es dispo. »

---

## Phase 0.5 : le menu

La personne choisit ce qu'elle veut transmettre. Le minimum, c'est les fondations.

```
Voilà ce qu'un second cerveau peut contenir. Plus tu remplis, plus ton
IA te ressemble. Tu choisis.

FONDATIONS (obligatoires)

A. Identité civile : prénom, nom, âge, ville, situation, proches,
   et ta valeur non négociable (une seule).
F. Style de communication : tutoiement, langue, format, ton, emoji.
G. Tes terrains : ton business (un par boîte ou marque) et ta vie
   (Perso, Admin, Santé si tu veux).
V. Identité visuelle : logo, couleurs, police, photos, bannières.
   Sans ça, ton IA invente des couleurs à chaque visuel.

FORTEMENT RECOMMANDÉ

D. Ton métier en profondeur + ce que tu veux déléguer : tes casquettes,
   ce qui rapporte, ce qui prend du temps, puis un vrai deep-dive sur
   TON métier (acteurs, outils, chiffres, cycle, façon de faire), et
   les tâches répétitives qui te bouffent du temps.
   C'est le bloc qui rend ton IA utile : c'est ton métier qui remplit
   80 % du cerveau. Si tu n'ajoutes qu'un bloc, c'est celui-là.

EXTENSIONS (à la carte)

B. Valeurs, mission, image de soi.
C. Parcours : études, premiers jobs, timeline pro.
E. Business et légal (si entrepreneur) : marque, client idéal, offre,
   outil clients, process de vente, SIRET, TVA, RIB (où il est rangé).
H. Rythme : semaine type, créneaux protégés, sport, sommeil.
I. Finances : revenu, cibles, patrimoine, dettes. Sensible, tu peux sauter.
J. Vision, mentors, carences, concurrents.
K. Objectifs 3 mois, garde-fous (ce que je ne dois jamais faire sans
   toi), notes privées (à savoir, jamais à citer).

Tu veux faire quoi :
- « tout » (1 heure, recommandé)
- les lettres en plus des fondations (ex : « + D E K », « tout sauf I »)
- « fondations seules » (A F G V, 30 minutes)
```

- A, F, G, V toujours dedans, et la question B1 (valeur racine) est posée avec le bloc A même si B n'est pas choisi : la première ligne du AGENTS.md en a besoin. « tout » → A à K + V. Liste → fondations + lettres, dédupliquées.
- Fondations seules mais activité pro évidente : proposer UNE fois d'ajouter D (« 15 minutes de plus, c'est ce qui rend ton cerveau utile »).
- E sélectionné sans activité à son compte : confirmer, retirer E si besoin, garder D.
- Confirmer : « OK, on fait : [blocs]. C'est parti. »

---

## Phase 1 : interview

Ouvre `references/interview.md` et pose les blocs sélectionnés, dans l'ordre A, F, B, C, D, E, G, V, H, I, J, K (F tout de suite après A : la langue et le tutoiement se décident avant le deep-dive métier), en sautant ceux non choisis (sans les mentionner).

Règles :
- **Un bloc à la fois.** Réponse floue : reformuler une fois, puis continuer. « saute » → « non renseigné ».
- **Creuser une fois** sur une réponse en surface. **Davantage sur le métier** (Bloc D), c'est le cœur de la valeur.
- **Asset-first** : dès que la personne a déjà produit quelque chose (posts, charte, modèle de facture, livrable type), demander le fichier ou le lien, aller le lire (WebFetch, Read) et en extraire la matière. Un asset réel vaut mille questions. Noter la source. Rien de fourni → « à créer », sans insister.
- **Ne jamais inventer une donnée métier.** Marge, ROAS, prix inconnus → « non renseigné ».
- **Ne jamais demander la liste des clients** : demander où elle vit (CRM, fichier), et seulement ceux qui demandent une action cette semaine.
- Garder en tête, pendant tout le Bloc D, la liste des **process à seeder** de l'archétype (ou 5 à 8 process déduits, hors bibliothèque) : chaque livrable récurrent cité est une occasion de demander « et tu fais ça comment, étape par étape ? ». C'est ça qui remplit `Process/` avec du vrai plutôt que des gabarits vides.

---

## Phase 2 : récap et confirmation

Avant de toucher au disque, présente le récap. Seulement les sections des blocs faits ; les autres en pied, « laissées vides, à compléter plus tard ».

```
Voilà ce que je vais créer chez toi, dans [pwd] :

Toi
- [Prénom Nom], [âge], [ville], valeur racine : [valeur]
- Activité : [une phrase]. Métier : [archétype ou sur-mesure], angle : [D5 en une ligne]
- Ton : [tu/vous], [direct/bienveillant], [bullets/paragraphes], [langue], emoji [on/off]

Ton business : [Nom]
- Offre : [offre + prix]. Client idéal : [une ligne]. Vente : [E5 en une ligne]
- Outils : [CRM, facturation, banque, messagerie…]
- Process que je vais écrire, avec ce que tu m'as dit :
  Sales : [liste]  /  Ops : [liste]  /  Finance : [liste]  /  Marketing : [liste]  /  [Support, RH]
- Équipe : [seul / personnes]
- Charte : [marque(s)] : logo [ok/à créer], couleurs [codes/à créer], police [nom/à créer]

Ta vie
- Perso : identité, proches, [valeurs, parcours, rythme, vision, notes privées selon blocs]
- Admin : [légal, RIB (emplacement), logement, charges]
- [Santé si demandé]

Assets récupérés : [écrits → ton.md ; charte → Docs/charte ; modèle de facture → Docs/templates ; ou « aucun »]

Garde-fous (ce que je ne ferai jamais sans toi) : [K2 + ceux du métier]

Structure
- AGENTS.md                     le seul fichier lu automatiquement : toi, tes règles, ta mémoire, la carte
- 0 Inbox/                      tu déposes en vrac, je range
- Journal/                      une note par jour
- Skills/                       tes outils (save, tri-inbox…)
- 1 Terrains/[Business]/        clients, process par équipe, outils, docs : le dossier qui se partage un jour
- 1 Terrains/Perso/  Admin/  [Santé/]
- 2 Archives/
- et, À CÔTÉ de ce dossier, un dossier Apps/ (vide) : c'est là que vivra le code
  de tes futurs outils, jamais dans le cerveau

Je lance ? (oui / modifie X)
```

« modifie X » → corrige et re-confirme. « oui » → Phase 3.

---

## Phase 3 : génération

Suis `references/structure.md` dans cet ordre. Toujours les vraies réponses, jamais de placeholder, jamais d'écrasement d'un fichier existant.

1. **Arborescence** (§ 2) : dossiers de la racine, terrain business, terrains de vie, et `Apps/` dans le dossier parent du cerveau (à côté de lui, vide : c'est là que le skill `/app` mettra le code). Un module n'est créé que s'il reçoit un fichier.
2. **Fichiers techniques** (§ 2) : `.claude/settings.json` (`autoMemoryEnabled: false`, fusionner si existant), `.env` (en-tête seul), `.gitignore`.
3. **`AGENTS.md` racine** (§ 3) : moins de 200 lignes, le résumé de la personne, les 3 règles, la Mémoire (règles de travail, communication d'après F6 et F7, garde-fous K2), la structure avec les vrais noms de terrains, le routing.
4. **Terrain business** (§ 4) : `AGENTS.md` du terrain, `_context.md`, `Clients/etat-pipeline.md` et `historique-clients.md` (+ un `Clients/<slug>/brief.md` par client cité), `Process/_index.md` et les process seedés de l'archétype remplis avec ce que la personne a décrit (« à préciser » pour les étapes non décrites), `Process/Marketing/_context.md`, `ton.md`, `regles.md`, `Outils/outils.md`, `Docs/_index.md`, `Docs/charte/charte-<marque>.md` (une par marque), `Docs/offre/`, `Docs/templates/` (modèles fournis). `Equipe/<prenom>/fiche.md` et `Process/RH/integrer-un-collaborateur.md` si quelqu'un travaille déjà avec la personne.
5. **Terrains de vie** (§ 5) : `Perso/_context.md` (identité, proches, valeurs, parcours, rythme, vision, finances, notes privées), `Admin/_context.md` (légal, RIB, logement, charges), `Santé/_context.md` si demandé. Chacun avec son `Docs/`.
6. **Assets** : chaque fichier fourni est copié au bon endroit (charte → `Docs/charte/`, modèles → `Docs/templates/`, photos → `Docs/charte/`) ; un lien ou un document lourd reste où il est et la note pointe dessus. Jamais un copier-coller brut : l'essentiel, plus le pointeur.
7. **Première note du journal** (§ 6).
8. **Skills du pack.** Le pack livré à la personne, c'est exactement : `onboarding`, `onboarding-migrate`, `app`, `save`, `tri-inbox`, `grill-me`. Ils vivent dans `Skills/` à la racine du cerveau (dossier visible, comme le reste). **Rien dans le `.claude/` du cerveau** : ni skill, ni lien, ni script, seulement `settings.json`. Chaque outil lit les skills à une adresse fixe du dossier personnel de l'utilisateur, hors du cerveau (Claude Code : `~/.claude/skills/` ; Codex : `~/.agents/skills/`) et suit les raccourcis : `link-skills.sh` pose les raccourcis aux deux adresses et les régénère à chaque session. Le cerveau est donc le même quel que soit l'outil. La phrase d'installation du pack a déjà fait ça. Ici tu vérifies : `ls Skills/` montre les six, `ls -la ~/.claude/skills/` montre six liens vers ce cerveau, `ls -A .claude/` ne montre que `settings.json`. Si un dossier réel ou des liens traînent dans `.claude/skills/` du cerveau (installation à l'ancienne) : déplacer les vrais dossiers vers `Skills/`, supprimer `.claude/skills/`, relancer `CLAUDE_PROJECT_DIR="$(pwd)" bash Skills/onboarding/setup/scripts/link-skills.sh`. Un skill du pack absent : ne pas le recréer, le dire en Phase 4. Aucun autre skill n'est promis à la personne. Les skills propres au business que la personne créera plus tard iront dans `1 Terrains/<Business>/Skills/` (partagés avec l'équipe par Drive) ; le même script les relie.
9. **Contrôles** (§ 7) : les six, exécutés tels qu'écrits (avec `/usr/bin/grep` et les motifs quotés) et lus. Un échec se corrige avant de continuer.

### Plomberie : sauvegarde en ligne et relevé du soir (proposés, jamais imposés)

```
Deux derniers réglages, tu me dis oui ou non :

1. La sauvegarde en ligne. Ton cerveau est un dossier sur ton ordinateur.
   Si l'ordinateur meurt, il meurt avec. Je peux le sauvegarder
   automatiquement dans un espace privé en ligne (GitHub) : à chaque
   fin de session ça part tout seul, à chaque ouverture ça revient.
   Privé, personne d'autre n'y a accès. Ça permet aussi de retrouver
   ton cerveau depuis un deuxième ordinateur.

2. Le relevé du soir. Tous les soirs à 23h, si ton ordinateur est
   allumé, je relis les mails et messages reçus dans la journée (ceux
   que tu m'as connectés), j'en fais un résumé dans ton journal, et je
   range chaque info utile dans le bon dossier (une info sur un client
   va dans le dossier de ce client). Je ne réponds à personne, je lis
   et je range.

On installe ? (les deux / juste la sauvegarde / juste le relevé / rien)
```

Puis : `bash Skills/onboarding/setup/install.sh "$(pwd)" 23`. Idempotent. Il fait : dépôt git local + `.gitignore`, hooks SessionStart (récupérer + relier les skills) et SessionEnd (sauvegarder) dans `.claude/settings.json` qui appellent les scripts restés dans `Skills/onboarding/setup/scripts/`, tâche du soir (launchd), dépôt **privé** GitHub si `gh` est connecté. Il ne copie rien dans `.claude/`.

Règles : non à la sauvegarde → lancer quand même (git local et hooks protègent des bêtises), aucun dépôt distant. Non au relevé → retirer la tâche (`launchctl unload ~/Library/LaunchAgents/com.claude.schedule.daily-recap-<slug>.plist` puis supprimer le fichier). `gh` non connecté → l'installateur affiche les commandes, ne pas les taper à sa place (compte et navigateur de la personne). Dépôt toujours privé, sans exception. Relevé sans messagerie connectée → installé, mais dire qu'il ne servira qu'une fois un compte branché. Hors Mac → pas de tâche planifiée, le reste marche.

---

## Phase 4 : conclusion pédagogique

La personne vient de voir des fichiers apparaître. Explique tout, simplement, en français, sans jargon. Adapte les valeurs.

```
TON SECOND CERVEAU EST PRÊT

Je t'explique ce que j'ai installé et comment on travaille ensemble.
Tu n'as rien à retenir par cœur : tout est écrit dans le dossier.

C'EST QUOI, CONCRÈTEMENT
Un dossier sur ton ordinateur, « <nom du dossier> », avec dedans des
fichiers texte. Tu peux les ouvrir et les modifier comme n'importe quel
document. Si tu veux les lire confortablement, l'application Obsidian
(gratuite, obsidian.md) affiche ce dossier comme un carnet. Ce n'est
pas obligatoire : moi, je lis tout directement.

LE FICHIER QUE JE LIS EN PREMIER
Il s'appelle AGENTS.md, tout en haut du dossier. C'est ton mode d'emploi
pour moi : qui tu es en résumé, comment tu veux que je te parle, ce que
je ne dois jamais faire sans toi, et où est rangée chaque chose.
Quand tu me corriges (« non, plutôt comme ça »), j'écris la correction
au bon endroit et je te dis où. La fois d'après, je m'en souviens.

TES TERRAINS
Un terrain, c'est un domaine de ta vie. J'en ai créé [N] :

[Ta boîte] : ton business, le dossier le plus important. Dedans :
   ce qui est vrai de ta boîte (ton offre, tes prix, ton client idéal) ;
   un dossier par client, avec ce qu'on sait de lui et où on en est ;
   tes façons de faire, écrites noir sur blanc, une par fichier,
     rangées par métier (vente, livraison, argent, communication…)
     même si tu es seul aujourd'hui. J'en ai écrit [N] avec ce que tu
     m'as dit : [liste en mots simples]. Celles marquées « à préciser »
     attendent tes étapes ;
   la liste de tes outils et où chaque chose se trouve ;
   ta matière : ta charte (couleurs, police, logo), ton offre, tes
     modèles de documents.
   Le jour où quelqu'un travaille avec toi, c'est CE dossier que tu
   partages (par Google Drive), rien d'autre. Il l'ouvre et il a tout.
Perso : toi en détail (tes proches, tes valeurs, ta semaine, ta vision,
   tes notes privées). Jamais partagé.
Admin : le côté administratif (ton statut, ton numéro d'entreprise, la
   banque, le logement, les papiers).
[Santé : sommeil, sport, suivi médical.]

LES AUTRES DOSSIERS
Inbox : tu y déposes en vrac ce que tu ne sais pas où ranger (un
   document, une capture, une note). Tu me dis « trie l'inbox », je range.
Journal : une note par jour, ce qu'on a fait ensemble.
Archives : ce qui est terminé. Un client qui a fini son programme va là.
Skills : mes outils à moi. Tu n'y touches pas, mais tu peux les appeler
   en tapant leur nom précédé d'une barre oblique, dans notre
   conversation : /save, /tri-inbox, /app, /grill-me (je détaille en bas).

ET LE DOSSIER « APPS », À CÔTÉ
Juste à côté de ton cerveau, j'ai créé un dossier « Apps », vide pour
l'instant. Ton cerveau, c'est ce que tu sais. Apps, c'est ce que tu
construis : quand on fera un outil ensemble (un site, une application,
une automatisation), son code ira là. Dans ton cerveau, je garderai une
fiche qui dit à quoi il sert et où il tourne.
Tu me parles toujours depuis ton cerveau : « crée-moi une application
de devis », je la construis dans Apps ; « bosse sur l'application de
devis », je la retrouve tout seul. Tu n'ouvres jamais Apps toi-même.
Pourquoi séparer : ton cerveau part dans Google Drive et son business
se partage ; le code est lourd et contient des accès privés, il n'a
rien à faire là.

COMMENT ON TRAVAILLE À PARTIR DE MAINTENANT
1. Tu ouvres Claude Code dans ce dossier, comme aujourd'hui.
2. Tu me parles normalement. Je connais ton métier, ta façon d'écrire,
   tes règles.
3. Tu me corriges quand je me trompe : je note.
4. Tu me donnes un fichier, un lien, une idée : j'en fais une note
   rangée au bon endroit, reliée à ce qui existe déjà.
5. Avant de fermer, tu tapes /save : je range ce qu'on s'est dit.

Les quatre mots à connaître :
   /save : à la fin, je range.
   /tri-inbox : je vide le dossier Inbox.
   /app : je crée ou je reprends une application.
   /grill-me : je te pose des questions pour sortir ce que tu sais sur
   un sujet et l'écrire proprement.

[SI plomberie installée :]
Ta sauvegarde en ligne est active : à chaque fin de session, ton cerveau
est copié dans un espace privé sur internet, visible par toi seul. [Le
relevé du soir tourne à 23h : je relis tes mails et messages de la
journée et je range ce qui est utile / Le relevé du soir démarrera
quand une messagerie sera connectée.]

[SI quelque chose manque ou a été gardé intact :]
À savoir : [liste, en mots simples]

Première chose à faire : demande-moi « qu'est-ce que je dois faire
aujourd'hui ? ». Je lis ta liste de clients et de prospects et ton
journal, et je te réponds.
```

Termine sur une question ouverte : « Tu veux qu'on teste tout de suite sur un vrai cas ? »

Avant d'envoyer ce message, le relire avec le filtre de la section Ton : aucun mot de la liste interdite (terminal, commande, dépôt, repo, pipeline, markdown, symlink…) sans sa traduction, aucun chemin de fichier brut sauf le nom du dossier et AGENTS.md, les équipes en mots français (vente, livraison, argent, communication, support, personnel) avec le nom du dossier entre parenthèses la première fois seulement si on le montre.

---

## Edge cases

- **Contenu existant substantiel** → basculer sur `/onboarding-migrate` (Phase 0). Si refus, ne jamais écraser, lister les fichiers gardés intacts en Phase 4.
- **Un seul terrain business, ou plusieurs** : les deux valides. Plusieurs boîtes → un terrain chacune, le principal reçoit le deep-dive complet.
- **Pas entrepreneur** : sauter E ; garder D (un salarié a un métier). Le terrain business s'appelle du nom du projet ou du poste (« Side Projet X », « Poste chez Acme ») et garde la même forme, avec moins de process.
- **Pas de contenu du tout** : `Process/Marketing/` contient quand même `_context.md` (canaux d'acquisition réels), `ton.md` (la voix pour les mails et documents) et `regles.md`.
- **Interruption** : sauvegarder les réponses dans `~/.claude/onboarding-draft.json` ; « relance /onboarding, je reprends où on s'est arrêtés ».
- **Asset illisible** : « fourni mais non lu : [source] », continuer.
- **CRM « pas encore »** : « à mettre en place » dans `Outils/outils.md`, pas de pointeur fictif.
- **Vouvoiement / anglais** : tous les fichiers générés suivent le choix.
- **Métier hors bibliothèque** : cadre universel, 5 à 8 process déduits, nommés avec les mots du métier.
- **Deux métiers distincts** : deep-dive complet sur le principal, 2 ou 3 questions sur le second.
- **« Pourquoi tu me demandes ça ? »** : « plus je connais ton métier, plus je t'aide concrètement dessus au lieu de te sortir des généralités ». Puis continuer ou sauter.
- **Nom de terrain interdit ou trop long** : demander une variante.

## Notes pour l'agent

- Travailler dans le `pwd`, jamais dans un sous-dossier. Non négociable.
- La date vient du contexte système.
- Le deep-dive métier est le différenciateur : ne pas le bâcler. Les process seedés sont remplis avec ce qui a été dit, pas avec un gabarit vide ni une invention.
- Ne jamais utiliser les terrains ou les clients d'une personne réelle comme exemple. Exemples génériques mais précis (« Acme Conseil », « Maison Léa »).
- Hors périmètre (« comment je branche Notion ? ») : « ce skill pose la fondation ; on branche les outils dans une prochaine session, une fois que tu auras utilisé ton cerveau quelques jours ».
- Si `references/interview.md` ou `references/structure.md` manque, arrêter et le dire : ces fichiers font partie du skill, sans eux la génération dérive.
