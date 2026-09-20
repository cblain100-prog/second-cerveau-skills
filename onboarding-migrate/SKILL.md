---
name: onboarding-migrate
description: Installe un second cerveau Claude Code avec la méthode des Terrains (structure figée le 2026-09-18) dans un dossier qui contient DÉJÀ du contexte (AGENTS.md, memory.md, profil.md, notes, dossiers de projets ou de clients, ancien schéma profil/memory/2 Ressources/3 Archives). Explore l'existant en silence, en déduit ce qui est déjà su, ne pose que les questions qui manquent (avec le même deep-dive métier que /onboarding), puis range chaque information au bon endroit de la structure cible (AGENTS.md unique, terrain business avec Clients/ Process/<Équipe>/ Outils/ Docs/ en sous-dossiers, terrains de vie Perso/Admin/Santé) sans rien perdre : l'ancien contexte est archivé, jamais supprimé. Utiliser quand l'utilisateur dit "/onboarding-migrate", "migre mon contexte", "j'ai déjà un AGENTS.md", "reprends mon contexte existant", "mets mon cerveau à la nouvelle structure", "range ce que j'ai déjà dans la structure", ou quand /onboarding découvre un dossier déjà rempli.
---

# Onboarding Migrate : absorber un contexte existant, puis structurer en Terrains

Ce skill fait la même installation que `/onboarding`, avec une différence : **on ne part pas d'une feuille blanche**. La personne a déjà un contexte Claude (un `AGENTS.md` maison, un `memory.md`, des notes, des dossiers de clients ou de projets, ou un cerveau à l'ancien schéma `profil.md` / `memory.md` / `2 Ressources` / `3 Archives`). Le travail consiste à **lire tout ça, en déduire ce qui est déjà su, ne demander que ce qui manque, puis ranger chaque information à sa place dans la structure cible**, sans rien perdre.

Il s'appuie sur les fichiers de référence du skill `onboarding`, installé dans le même pack :

- `../onboarding/references/interview.md` : les blocs A à K et V, les archétypes métier, le cadre universel.
- `../onboarding/references/structure.md` : l'arborescence cible, le gabarit de chaque fichier, les contrôles de fin.

S'ils sont absents (`ls .claude/skills/onboarding/references/`), arrête et dis-le : ce skill ne fonctionne pas sans eux.

Ton, règles d'interview, plomberie et conclusion : identiques à `/onboarding` (lis son `SKILL.md` une fois pour les avoir en tête). En particulier la règle **parler simple** : mots de tous les jours, un terme technique expliqué entre parenthèses la première fois, un exemple concret avant l'idée, phrases courtes, aucune commande ni chemin montré sans l'avoir expliqué. Elle vaut encore plus ici : la personne va voir ses anciens fichiers bouger, il faut lui dire ce qui se passe avec ses mots (« je range », « je déplace », « j'archive »), pas les nôtres (« je migre », « je refactore »). Ce fichier ne décrit que ce qui diffère.

---

## Phase -1 : découverte silencieuse

**Avant de dire un mot**, explore le dossier ouvert.

1. `pwd`, `ls -la`, puis `find . -maxdepth 3 -not -path '*/node_modules/*' -not -path '*/.git/*' -not -path '*/.claude/*' | head -200`.
2. Lis en entier tout fichier d'identité, de mémoire ou de manuel : `AGENTS.md`, `memory.md`, `MEMORY.md`, `profil.md`, `profile.md`, `about.md`, `branding.md`, `README.md` à la racine, tout `.md` à la racine dont le nom évoque l'identité ou les règles, et les `_context.md` s'il y en a.
3. Liste les dossiers de contenu (projets, notes, clients, contenus, ressources) et lis les fichiers d'index ou de contexte qu'ils contiennent. Repère `Journal/`, `0 Inbox/`, `2 Ressources/`, `3 Archives/`, `1 Terrains/` et leurs sous-dossiers.
4. Liste `Skills/` (les skills visibles, où le pack est installé) et `.claude/` (normalement `settings.json` seul ; un `.claude/skills/` ou `.claude/scripts/` là-dedans est une installation à l'ancienne, à vider au Step 0 : vrais dossiers vers `Skills/`, liens supprimés). Ne touche à aucun skill pour l'instant. Note la présence de `/save`.
5. Repère `.claude/settings.json`, `.env`, `.gitignore`, un dépôt git (`git rev-parse --git-dir`), une tâche launchd de récap : à compléter, pas à recréer.

**Reconnaissance du schéma existant** (pour choisir la table de correspondance de la Phase 3) :

| Schéma | Signature | Ce que ça change |
|---|---|---|
| Ancien schéma Terrains (v1, avant le 2026-09-18) | `profil.md` + `memory.md` + `AGENTS.md` + `1 Terrains/` + `2 Ressources/` + `3 Archives/`, `ressources/` dans les terrains, un terrain « Personal Brand » ou « Contenu » | Migration mécanique : la table § 3.1 dit où va chaque fichier ; l'interview se réduit à combler les trous |
| Contexte Claude maison | un `AGENTS.md` ou `memory.md` libre, des notes en vrac | Extraction bloc par bloc, puis interview sur ce qui manque |
| Notes sans structure | des `.md` et des dossiers, pas de fichier d'identité | Interview quasi complète, mais chaque dossier existant est un candidat terrain ou un candidat `Docs/` |

**Carte de couverture** : pour chaque bloc A à K et V, note ce que tu as pu déduire avec confiance, de quelle source (chemin), et l'état : **couvert**, **partiel**, **absent**. Cette carte ne se montre pas, elle pilote la Phase 0.5 et la Phase 1. Garde toujours les chemins sources : ils servent à citer d'où vient chaque info reprise et à savoir quoi archiver.

Si l'exploration ne trouve **presque rien** : dis-le dès le premier message (« ton dossier est quasiment vide, il n'y a pas grand-chose à migrer ; je peux faire l'installation, mais ce sera un onboarding de zéro ») et continue ici avec tous les blocs « absent », ou propose `/onboarding`.

---

## Phase 0 : dossier et accord

Même message que `/onboarding`, avec ce paragraphe à la place de « SI contenu » :

```
Je viens de lire ce que tu as déjà : [liste courte des fichiers et
dossiers avec substance, ex. « ton AGENTS.md, ton memory.md, 14 notes
dans Notes/, un dossier Clients/ avec 6 sous-dossiers »].

Je ne repars pas de zéro : je reprends tout ça, je te pose seulement
les questions qui manquent, et je range chaque chose à sa place dans
la structure. Rien n'est supprimé : tes anciens fichiers seront
archivés tels quels dans « 2 Archives/contexte-pre-migration-[date] »,
au cas où.
```

---

## Phase 0.5 : le menu, avec ce qui est déjà couvert

Même menu que `/onboarding`, mais chaque bloc porte son état :

```
A. Identité civile                [couvert d'après AGENTS.md]
F. Style de communication         [partiel : tutoiement et langue trouvés, pas le reste]
G. Tes terrains                   [à confirmer : je devine Acme Conseil, Perso, Admin]
V. Identité visuelle              [absent]
D. Ton métier en profondeur       [partiel : activité connue, pas le deep-dive]
...
```

Règle : un bloc **couvert** n'est pas reposé, seulement confirmé en une ligne au récap. Un bloc **partiel** ne reçoit que les questions manquantes. Un bloc **absent** se pose en entier, s'il est sélectionné. Si la personne répond « fondations seules », les blocs déjà couverts sont quand même repris (ils ne coûtent rien).

---

## Phase 1 : interview allégée

Comme `/onboarding` (`../onboarding/references/interview.md`), avec la règle **DÉJÀ-COUVERT** :

- Avant chaque question, vérifie la carte de couverture. Info déjà connue → ne pas demander, reformuler en une ligne pour confirmation groupée en fin de bloc : « D'après ton memory.md, tu tutoies, tu écris en français, tu détestes les emojis. Toujours vrai ? »
- Info partielle → ne demander que le manquant.
- Une contradiction entre deux sources existantes (deux fichiers qui disent des choses différentes) → demander laquelle est vraie, et noter que l'autre part à l'archive.
- Le deep-dive métier (Bloc D) reste complet si le contexte existant ne décrit pas le métier avec les dimensions attendues (acteurs, outils, chiffres, cycle, livrables, contraintes). Un `AGENTS.md` qui dit « consultant IA » ne couvre pas le bloc D.
- **Bloc G, cas particulier** : propose d'abord un brouillon de terrains déduit de l'existant (« vu tes dossiers, je devine : Acme Conseil (ton business), Perso, Admin. Ton dossier `Notes/Contenu/` va dans le marketing d'Acme, pas dans un terrain à part. C'est ça, ou tu corriges ? »). Attention aux terrains de l'ancien schéma qui n'existent plus dans la structure cible : un terrain « Personal Brand » ou « Contenu » devient `Process/Marketing/` + `Docs/marketing/` du business ; un terrain par client devient un dossier dans `Clients/` ; « Vie pro » ou « Mon business » devient le nom de la boîte.
- Asset-first s'applique aux fichiers déjà présents : un `branding.md`, un `voix.md`, un modèle de facture dans `ressources/` sont des assets, on les reprend sans redemander.

---

## Phase 2 : récap et confirmation

Comme `/onboarding`, plus deux sections :

```
Repris de ton contexte existant (source entre parenthèses) :
- Identité, valeurs, mission (profil.md)
- Règles de ton (memory.md § Règle #2)
- 6 clients (Clients/) → un dossier chacun dans 1 Terrains/[Business]/Clients/
- ...

Ce que je vais déplacer (rien n'est supprimé) :
- profil.md → réparti entre 1 Terrains/Perso/_context.md, 1 Terrains/Admin/_context.md et 1 Terrains/[Business]/_context.md ; l'original va dans 2 Archives/contexte-pre-migration-[date]/
- memory.md → règles universelles dans AGENTS.md § Mémoire ; règles de domaine dans les fichiers du terrain ; leçons datées gardées telles quelles dans AGENTS.md § Leçons récentes (celles de moins de 30 jours) ou dans 2 Archives/lessons-archive.md
- 2 Ressources/branding.md → 1 Terrains/[Business]/Docs/charte/charte-[marque].md
- 2 Ressources/[autres] → le Docs/ du terrain qui s'en sert
- 3 Archives/ → 2 Archives/
- 1 Terrains/Personal Brand/ → Process/Marketing/ (ton, règles, stratégie) + Docs/marketing/ (posts, scripts)
- Notes/ → [terrain]/Docs/[type]/ (je te montre le détail avant de bouger)
- [dossiers non classés, laissés tels quels, à ranger plus tard : liste]
```

« oui » → Phase 3.

---

## Phase 3 : génération avec migration

Suis `../onboarding/references/structure.md` pour tout ce qui est créé. Ce qui diffère : le **Step 0** ci-dessous, exécuté après la création des dossiers (§ 2 de structure.md) et avant l'écriture des fichiers (§ 3 à 6), et le principe **déplacer, jamais supprimer**.

### 3.1 Table de correspondance (ancien schéma v1 → structure cible)

| Ancien | Nouveau | Comment |
|---|---|---|
| `profil.md` § Identité, Valeurs, Mission, Image, Parcours, Semaine type, Santé, Finances, Vision, Mentors, Notes privées | `1 Terrains/Perso/_context.md` | copier section par section dans le gabarit § 5.1 |
| `profil.md` § Infos légales, banque, logement, charges | `1 Terrains/Admin/_context.md` | gabarit § 5.2 |
| `profil.md` § Métier, Marque, ICP, Offre, Process de vente, Concurrents | `1 Terrains/<Business>/_context.md` | gabarit § 4.2 |
| `profil.md` § Voix & ton, vocabulaire | `1 Terrains/<Business>/Process/Marketing/ton.md` | avec `2 Ressources/voix.md` s'il existe |
| `profil.md` § CRM | `1 Terrains/<Business>/Outils/outils.md` | une ligne par outil |
| `memory.md` § Règles permanentes (ton, interdits, confidentialité) | `AGENTS.md` § Mémoire | upsert, une règle par ligne, sans doublon avec le gabarit |
| `memory.md` § Leçons [PINNED] | `AGENTS.md` § Mémoire (bloc « [PINNED] ») | telles quelles |
| `memory.md` § Leçons récentes | moins de 30 jours → `AGENTS.md` § Leçons récentes ; plus anciennes → `2 Archives/lessons-archive.md` | dates conservées |
| `memory.md` § État projet (terrains actifs, focus, projets 6 mois, tâches à déléguer) | `1 Terrains/<Business>/_context.md` § État du moment et § Métier | ce qui est encore vrai, la personne confirme |
| `AGENTS.md` ancien (résumé, structure, routing) | remplacé par le gabarit § 3 ; toute règle maison qui n'est pas dans le gabarit → § Mémoire | l'ancien va à l'archive |
| `2 Ressources/branding.md` | `1 Terrains/<Business>/Docs/charte/charte-<marque>.md` (une par marque) | gabarit § 4.7 |
| `2 Ressources/voix.md` | `Process/Marketing/ton.md` | fusion |
| `2 Ressources/<autre>` | le `Docs/<type>/` du terrain qui s'en sert le plus | demander si ambigu |
| `1 Terrains/<Business>/ressources/` | `1 Terrains/<Business>/Docs/<type>/` | par type : modèles → `templates/`, charte → `charte/`, offre → `offre/` |
| `1 Terrains/<Business>/<sous-dossier métier seedé v1>` (`produits/`, `clients-accompagnements/`, `prod-sops/`…) | `Clients/` si ce sont des entités ; `Process/<Équipe>/` si ce sont des façons de faire ; `Docs/<type>/` si c'est de la matière | fichier par fichier, la personne voit la liste |
| `1 Terrains/Personal Brand/` ou `1 Terrains/Contenu/` | `_context.md`, `ton.md`, `regles.md` → `Process/Marketing/` ; process (publier…) → `Process/Marketing/` ; posts, scripts, vidéos, photos → `Docs/marketing/` | le terrain disparaît |
| `1 Terrains/<Client X>/` (un terrain par client) | `1 Terrains/<Business>/Clients/<client-x>/` | le `_context.md` devient `brief.md` |
| `1 Terrains/Perso/`, `Admin/`, `Santé/` v1 | même nom, `ressources/` → `Docs/` | `_context.md` complété |
| `3 Archives/` | `2 Archives/` | déplacement en bloc |
| `Journal/`, `0 Inbox/` | inchangés | |
| `.claude/skills/<skill réel>` | `Skills/<skill>` (perso) ou `1 Terrains/<Business>/Skills/<skill>` (business) puis `link-skills.sh` | jamais supprimé, déplacé puis lié |

### 3.2 Step 0 : migration non destructive

1. Crée `2 Archives/contexte-pre-migration-<date>/`.
2. **Fichiers d'identité, mémoire, manuel** (`AGENTS.md`, `memory.md`, `profil.md`, `branding.md`, `about.md`…) : leur contenu est repris aux Steps 3 à 5 de structure.md selon la table ; une fois les nouveaux fichiers écrits, **déplace** chaque ancien vers l'archive en gardant son nom. Ce que tu n'as pas repris (détail mineur, ambigu, hors sujet) : liste-le en Phase 4, « détails non repris, encore dans l'archive ».
3. **Dossiers de contenu** : applique la table. Un dossier qui correspond clairement à une destination → déplacé (`git mv` si dépôt git, sinon `mv`), en gardant les noms de fichiers. Un dossier ambigu → demander : « ton dossier `X`, je le range où : dans `Clients/`, dans `Process/`, dans `Docs/<type>/`, ou je le laisse tel quel ? ». « laisse tel quel » → ne rien toucher, noter en Phase 4 sous « dossiers non classés ».
4. **Références** : après les déplacements, `grep -rn "<ancien chemin>"` sur tous les `.md`, `.json`, `.sh` du dossier (hors `.git`, `node_modules`, archive) et réécris chaque référence vers le nouveau chemin. Les wikilinks `[[nom]]` continuent de résoudre par nom de fichier, les chemins en dur non.
5. **Ne déplace jamais** `.git`, `.claude`, `node_modules`, `.env` du cerveau lui-même. Un dossier de code (un dossier avec `package.json`, `requirements.txt`…) trouvé n'importe où dans le cerveau reçoit la règle Apps (c'est le § 4 du skill `/app`, à suivre tel quel) : le dossier est **déplacé vers `Apps/<app>/` à côté du cerveau** (même dossier parent ; `mkdir -p` puis `mv`, hors du cerveau) et remplacé à sa place par la fiche `<app>.md` (`code: ~/Apps/<app>/`, rôle, URL de déploiement si trouvée, lancement, décisions) écrite d'après ce que le dossier contient (README, package.json). Un `AGENTS.md` de trois lignes est posé dans le code s'il n'en a pas. Si le code n'a pas de `.git`, `git init` dedans et le dire : la sauvegarde en ligne se met en place avec la plomberie. Dire à la personne, une fois : « ton code vit maintenant dans le dossier Apps, juste à côté de ton cerveau ; pour y travailler, dis-moi “bosse sur l'app X” ».
6. **Skills** : les skills vivent dans `Skills/` (racine) ou `1 Terrains/<Business>/Skills/` (propres au business : facturation, propositions…). Rien dans le `.claude/` du cerveau à part `settings.json` : déplace les vrais dossiers de `.claude/skills/` vers le bon `Skills/`, supprime `.claude/skills/` et `.claude/scripts/`, puis `CLAUDE_PROJECT_DIR="$(pwd)" bash Skills/onboarding/setup/scripts/link-skills.sh` (un raccourci `~/.claude/skills → Skills/`, hors du cerveau, posé une fois).

### 3.3 Le reste

Steps 3 à 9 de `/onboarding` (structure.md § 3 à § 7), en écrivant les nouveaux fichiers **à partir de l'existant plus l'interview**, sans placeholder. Les contrôles de fin (§ 7) sont obligatoires, plus un septième :

```bash
# 7. plus aucune trace de l'ancien schéma hors archive
ls profil.md memory.md branding.md "2 Ressources" "3 Archives" 2>/dev/null
find "1 Terrains" -maxdepth 2 -name "ressources" -type d
grep -rln "profil.md\|memory.md\|2 Ressources\|3 Archives" --include=*.md . | grep -v "2 Archives" | grep -v "Skills/" | grep -v ".claude/"
```

Tout doit être vide.

---

## Phase 4 : conclusion

Même explication que `/onboarding`, avec en plus :

```
CE QUI VIENT DE TON ANCIEN CONTEXTE
- Repris et rangé : [liste courte, avec la destination]
- Archivé tel quel dans 2 Archives/contexte-pre-migration-[date]/ :
  [liste des fichiers]
- Détails non repris (encore dans l'archive) : [liste ou « aucun »]
- Dossiers non classés, à ranger toi-même : [liste ou « aucun »]
- Code sorti du cerveau vers Apps/ (à côté), fiche laissée à sa place : [liste ou « aucun »]
```

---

## Edge cases propres à la migration

- **L'ancien `memory.md` contient des règles qui contredisent le gabarit** (ex. « utilise des emojis ») : la personne gagne. Sa règle va dans `AGENTS.md` § Mémoire, le gabarit s'adapte.
- **Deux fichiers d'identité qui se contredisent** : demander lequel fait foi, archiver l'autre, ne jamais garder les deux versions côte à côte.
- **Un terrain v1 par client, dix clients** : dix dossiers dans `Clients/`, chacun avec `brief.md` = l'ancien `_context.md`. Pas de question par client, la liste est montrée en Phase 2.
- **Un dossier `Contenu/` ou `Personal Brand/` très gros** (vidéos, images) : la matière lourde reste où elle est ou part dans un stockage (Drive), une ligne dans `Outils/outils.md` dit où ; seuls les textes vont dans `Docs/marketing/`.
- **Un `.claude/skills/save` maison différent de celui du pack** : garder celui de la personne, ne pas écraser, le signaler.
- **Un dépôt git existant avec des commits** : `git mv` pour préserver l'historique ; commit de migration en fin de Phase 3 (« migration structure Terrains v2 <date> ») si la personne a un hook de push, sinon lui dire de committer.
- **Des chemins en dur dans des scripts ou des routines cloud** que tu ne peux pas voir : après la migration, dis-le explicitement (« si tu as des routines ou des scripts qui écrivent dans `2 Ressources/` ou `Personal Brand/`, ils sont à mettre à jour ; dis-moi lesquels »).
