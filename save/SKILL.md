---
name: save
description: Sauvegarde de fin de session. Lit d'abord la carte de routing du CLAUDE.md du vault, puis range AUTOMATIQUEMENT ce qui mérite d'être gardé (décisions, infos, idées, brouillons, ressources) dans les bons dossiers selon cette carte — sans demander. N'écrit JAMAIS dans memory.md ni dans Journal/. Skill général : il s'adapte à n'importe quel vault via son CLAUDE.md. Utiliser quand l'utilisateur dit "/save", "save", "sauvegarde", "garde ça", "note ça", "enregistre la session", ou à la fin d'une conversation riche.
---

# Save — Sauvegarde auto fin de session (pilotée par CLAUDE.md)

Passe en revue la conversation, identifie ce qui mérite d'être gardé, et range chaque élément dans le bon **dossier** — en suivant la **carte de routing du `CLAUDE.md`** de ce vault. À la fin, confirme ce qui a été écrit où.

Ce skill est **général** : il ne connaît pas tes terrains à l'avance. Il les découvre en lisant `CLAUDE.md` à chaque exécution. Conséquence : quand ta structure évolue, tu n'as **rien** à changer ici — tu mets juste à jour `CLAUDE.md`, et le save suit.

> Ce skill est l'un des deux mécanismes de mémoire du second cerveau. L'AUTRE — la capture des corrections en temps réel — alimente `memory.md` automatiquement pendant la conversation (Règle #1, voir `CLAUDE.md`). Les deux sont **séparés** : /save ne touche jamais `memory.md`.

## Règle dure — /save ne touche QUE les dossiers

- JAMAIS dans `memory.md` (réservé à la Règle #1, mécanisme distinct). /save ne l'ouvre même pas.
- JAMAIS dans `Journal/` (pas un récap de session).
- Tout va dans un dossier : terrain, ressource transverse, ou inbox.

Ces trois contraintes priment sur la carte de routing : même si un CLAUDE.md disait le contraire, /save n'écrit ni dans `memory.md` ni dans `Journal/`.

## Étape 0 — Lire la carte de routing (CLAUDE.md) — OBLIGATOIRE, EN PREMIER

Avant toute écriture, lis le `CLAUDE.md` à la racine du vault et repère sa section de **routing** (souvent titrée "Routing — où lire et où écrire" ou équivalent). C'est **LA source de vérité** des destinations dans CE cerveau : elle dit où va chaque type d'information.

- Extrais-en la liste des règles "tel type d'info → tel dossier/fichier".
- Note aussi tout cas spécial déclaré là (ex : "info client → CRM externe d'abord", "facturation → tel fichier", terrains nommés…).
- Tu t'appuieras dessus à l'Étape 2 pour dispatcher.

**Repli** : si `CLAUDE.md` est absent, sans section routing, ou trop maigre pour décider → utilise l'**arbre générique par défaut** de l'Étape 2. Ne bloque jamais faute de carte.

## Principe absolu

**Tu classes tout seul. Tu ne demandes JAMAIS "où je le mets ?".** Si la carte de routing donne plusieurs destinations possibles, choisis la **plus spécifique**. Si vraiment rien ne matche, c'est `0 Inbox/`.

À la fin, tu listes ce que tu as fait — la personne peut corriger si une destination ne lui plaît pas (ce sera une correction captée par la Règle #1, hors /save — et idéalement répercutée dans CLAUDE.md).

## Étape 1 — Identifier ce qui mérite save

Passe la conversation en revue. Repère les éléments à valeur durable :

- **Info sur un client / contact nommé** (note d'échange, décision le concernant)
- **Décision / état d'un projet** ("on part sur X", "le process Y change")
- **Résumé d'une session de travail** sur un sujet
- **Doctrine / méthode / connaissance réutilisable** (parti pris durable, recherche)
- **Idée** (contenu, produit, projet)
- **Inspiration / brouillon non triable**

**Skip** : bavardage, débats abandonnés, questions sans conclusion, et toute **correction de comportement** (déjà captée en temps réel par la Règle #1 — pas le rôle de /save).

## Étape 2 — Dispatcher selon CLAUDE.md (sinon arbre générique)

Pour chaque élément à garder : applique d'abord la **carte de routing lue à l'Étape 0**. Mappe le type de l'élément à la règle correspondante du CLAUDE.md et écris à la destination qu'elle indique (en respectant les cas spéciaux : CRM externe, fichier de facturation, terrain nommé, etc.).

**Arbre générique par défaut** (uniquement si CLAUDE.md ne tranche pas) :

```
1. Info sur un client/contact nommé ?
   → grep le nom dans 1 Terrains/ ; sinon crée
     1 Terrains/[terrain le plus probable]/[clients]/[Nom]/notes.md
   → append sous le header du jour

2. Décision / état / résumé liés à un terrain ou projet précis ?
   → identifie le terrain et le sous-dossier le plus précis
   → append dans son notes.md sous le header du jour (créer si absent),
     OU dans _context.md si ça change durablement le contexte du terrain

3. Doctrine / méthode / connaissance réutilisable transverse ?
   → 2 Ressources/[dossier pertinent]/[titre-kebab].md

4. Idée de contenu / produit / projet ?
   → dossier du terrain concerné : drafts/AAAA-MM-JJ-[titre].md ou _idees.md

5. Rien ne matche / inspiration brute ?
   → 0 Inbox/AAAA-MM-JJ-[titre-kebab].md (un fichier par item)
```

Le routing est automatique. Tu ne demandes PAS confirmation. Tu exécutes. Et tu ne touches **ni `memory.md` ni `Journal/`**.

## Étape 3 — Écriture

- **Append dans un fichier existant** : Edit en gardant le contenu existant (ne pas écraser). Lis le fichier juste avant d'éditer.
- **Créer un nouveau fichier** : Write avec un frontmatter minimal si utile (`date`, `source`).
- **Header du jour** dans un `notes.md` : section `## AAAA-MM-JJ` (la créer si absente, le plus récent en haut), puis des bullets.

## Étape 3.5 — Relier (wikilinks + MOC)

Un second cerveau vaut par ses **connexions**, pas son rangement. Après avoir écrit, relie ce qui a une **valeur connective** (note nommée, concept, méthode, idée, client). On NE relie PAS les logs/états bruts dans un `notes.md`.

Pour chaque élément à valeur connective :

1. **Grep** le vault sur ses concepts/noms clés (`grep -ri "[terme]" --include=*.md`, hors `.claude/` et `3 Archives/`).
2. **Ajoute des `[[wikilinks]]`** depuis l'élément vers les 3-5 notes les plus pertinentes. Ne lie que dans **un sens** — Obsidian crée le backlink de l'autre côté. Cible des noms de fichiers uniques (si la cible est un `notes.md`, utilise le chemin : `[[1 Terrains/.../notes|alias lisible]]`).
3. **MOC du sujet** : si un fichier `[Sujet] - MOC.md` existe → y ajouter le lien. Sinon, si le sujet a déjà ≥3 notes éparses → créer le MOC dans le bon dossier.

Si rien de pertinent à relier → ne force pas de lien.

## Étape 4 — Confirmer

Message final structuré, sans fioritures :

```
✓ Saved
- 1 Terrains/[terrain]/[chemin] : N entrées
- 2 Ressources/[titre].md : nouveau fichier → relié à [[X]], [[Y]]
- 0 Inbox/AAAA-MM-JJ-[titre].md : nouveau fichier
- MOC [sujet] : màj
```

Pas d'explication détaillée.

## Edge cases

- **Pas de CLAUDE.md / pas de section routing** : utilise l'arbre générique (Étape 2), ne bloque pas.
- **Conversation très courte** sans contenu substantiel → `"Rien à save dans cette conversation."` et stop.
- **Doublon** : si l'info existe déjà dans le dossier cible, ne pas la dupliquer → `"déjà présent, skip"`.
- **CLAUDE.md route une info vers `memory.md` ou `Journal/`** : ignore (les contraintes dures priment), range ailleurs (terrain/ressource/inbox).
- **Contact non trouvé** : crée `[Nom]/notes.md` dans le terrain le plus probable et signale-le.
- **Plusieurs terrains touchés** : OK, écrire dans chacun ; lister tous les chemins.
- **Conflit avec un append simultané** : relire le fichier juste avant l'Edit pour éviter d'écraser.

## Ce que tu ne sauves PAS

- Contenu vers `memory.md` (réservé à la Règle #1) ou `Journal/` (jamais une cible /save)
- Tool results bruts (listings, etc.)
- Corrections de comportement (déjà captées par la Règle #1 en temps réel)
- Tout ce qui n'a pas de valeur réutilisable dans une future session
