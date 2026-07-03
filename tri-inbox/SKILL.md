---
name: tri-inbox
description: Vide et trie le dossier 0 Inbox/. Lit d'abord la carte de routing du CLAUDE.md du vault, inventorie tout ce qui traîne dans l'inbox (notes .md, images, PDF, exports, dossiers, liens), lit/extrait le contenu de chaque item, puis le range AUTOMATIQUEMENT dans le bon dossier selon cette carte — sans demander. N'écrit JAMAIS dans memory.md ni dans Journal/. Skill général : il s'adapte à n'importe quel vault via son CLAUDE.md. Utiliser quand l'utilisateur dit "/tri-inbox", "tri inbox", "trie l'inbox", "traite l'inbox", "vide l'inbox", "range l'inbox", "process inbox".
---

# Tri-inbox — Vide et range le dossier `0 Inbox/` (piloté par CLAUDE.md)

Ratisse **le dossier `0 Inbox/`** (pas la conversation), lit chaque item, et le range dans le bon **dossier** — en suivant la **carte de routing du `CLAUDE.md`** de ce vault. Sort chaque original de l'inbox une fois traité. À la fin, confirme ce qui est parti où.

Ce skill est **général** : il ne connaît pas tes dossiers à l'avance. Il les découvre en lisant `CLAUDE.md` à chaque exécution. Conséquence : quand ta structure évolue, tu n'as **rien** à changer ici — tu mets juste à jour `CLAUDE.md`, et le tri suit.

C'est le **jumeau symétrique de `/save`** : même doctrine (lire CLAUDE.md, ranger sans demander, relier ce qui a de la valeur), même contraintes dures. Seule différence : la source = le dossier `0 Inbox/`, pas l'historique de conversation.

## Règle dure — tri-inbox ne touche QUE les dossiers

- JAMAIS dans `memory.md` (réservé à la Règle #1 / mécanisme de correction en temps réel, si ce vault en a un).
- JAMAIS dans `Journal/` (pas un récap de session).
- Tout va dans un dossier : terrain, ressource transverse — et l'original quitte `0 Inbox/`.

Ces trois contraintes priment sur la carte de routing : même si un CLAUDE.md disait le contraire, tri-inbox n'écrit ni dans `memory.md` ni dans `Journal/`.

## Étape 0 — Lire la carte de routing (CLAUDE.md) — OBLIGATOIRE, EN PREMIER

Avant de ranger quoi que ce soit, lis le `CLAUDE.md` à la racine du vault et repère sa section de **routing** (souvent titrée "Routing — où lire et où écrire" ou équivalent). C'est **LA source de vérité** des destinations dans CE cerveau : elle dit où va chaque type d'information ou d'asset.

- Extrais-en la liste des règles "tel type d'info/asset → tel dossier".
- Note aussi tout cas spécial déclaré là (ex : "info client → CRM externe, pas de fichier", terrains nommés, dossiers ressources spécifiques…).
- Si un dossier cible n'existe pas encore, tu le crées.

**Repli** : si `CLAUDE.md` est absent, sans section routing, ou trop maigre pour décider → utilise l'**arbre générique par défaut** de l'Étape 3. Ne bloque jamais faute de carte.

## Principe absolu

**Tu classes tout seul. Tu ne demandes JAMAIS "où je le mets ?".** Si tu hésites entre deux destinations, choisis la plus spécifique selon la carte de routing. Si vraiment rien ne matche, l'item **reste dans `0 Inbox/`** (et tu le signales dans le rapport final). À la fin tu listes tout — la personne corrige après si une destination ne lui plaît pas (ce sera une correction à répercuter dans CLAUDE.md, hors de ce skill). Git tracke tout si le vault est versionné : rien n'est jamais perdu.

## Étape 1 — Inventorier l'inbox

Liste **récursivement** tout le contenu de `0 Inbox/` :

```
ls -la "0 Inbox/" puis pour chaque sous-dossier
```

Pour chaque item, détecte son **type** — ça détermine comment tu le lis et comment tu le ranges :

| Type | Exemples | Comment le lire |
|---|---|---|
| **Note .md déjà rédigée** | `idee-produit.md` | Read direct |
| **Image** | `.png`, `.jpg`, screenshot, schéma, photo | **Read (vision)** — décris/extrais le contenu |
| **PDF** | facture, doc, guide, export | **Read (pages)** — extrais l'essentiel |
| **Lien seul** | une note qui ne contient qu'une URL | **defuddle** (skill, si disponible) ou WebFetch pour récupérer le contenu |
| **Dossier** | un sous-dossier avec plusieurs fichiers liés | Inventorie son contenu, range le dossier en bloc |
| **Autre binaire** | `.csv`, `.zip`, `.mov`... | Ne pas ouvrir ; router sur le nom + contexte |

**Tu dois lire le contenu avant de router.** Router une image ou un PDF à l'aveugle (juste sur le nom de fichier) = interdit.

## Étape 2 — Classer : note atomique VS rangement tel quel

Pour chaque item, tranche d'abord **la nature du rangement** (c'est le cœur du skill) :

- **Valeur connective** (asset réutilisable, concept, méthode, insight, leçon, idée de contenu, ressource) → **note atomique** : tu extrais l'essentiel avec tes mots dans un `.md` au **titre unique et descriptif** (jamais `notes.md`), frontmatter minimal (`date`, `source` = chemin d'origine ou URL), puis tu **relies** si ce vault pratique les wikilinks (étape 4).
- **Asset brut à archiver** (facture, pièce admin, photo, screenshot témoignage, charte, modèle) → **rangement tel quel** : tu déplaces le fichier dans le bon dossier, **sans** créer de note atomique (l'asset se suffit). Tu peux renommer proprement si le nom est cryptique.
- **Note .md déjà bien rédigée** → tu la **déplaces** vers le bon dossier (et tu la relies si valeur connective). Pas besoin de la réécrire.
- **Aucune valeur réutilisable** (filler, doublon déjà capturé, brouillon obsolète) → **supprimer** de l'inbox, et le signaler dans le rapport (`supprimé : [nom] (sans valeur)`).

## Étape 3 — Dispatcher selon CLAUDE.md (sinon arbre générique)

Pour chaque item : applique d'abord la **carte de routing lue à l'Étape 0**. Mappe le type de l'item à la règle correspondante du CLAUDE.md et range à la destination qu'elle indique (en respectant les cas spéciaux : CRM externe, dossier client, terrain nommé, etc.).

**Arbre générique par défaut** (uniquement si CLAUDE.md ne tranche pas) :

```
1. Info / asset sur un client ou contact nommé ?
   → si ce vault a un CRM externe déclaré dans CLAUDE.md, ne crée pas de fichier
     de suivi : signale l'item pour report dans le CRM, laisse-le dans l'inbox.
   → sinon, ou si c'est un asset durable (témoignage, doc stratégique) →
     grep le nom dans 1 Terrains/ ; range dans le dossier client/contact
     le plus probable (ou crée-le).

2. Asset / note lié à un terrain ou projet précis ?
   → 1 Terrains/[terrain le plus probable]/[sous-dossier le plus précis].
     Note atomique → fichier nommé ; asset brut → range tel quel.

3. Doctrine / méthode / connaissance réutilisable transverse (sert plusieurs terrains) ?
   → 2 Ressources/[dossier pertinent]/[titre-kebab].md

4. Idée de contenu / produit / projet ?
   → dossier du terrain concerné : drafts/AAAA-MM-JJ-[titre-kebab].md ou _idees.md

5. Rien ne matche clairement ?
   → l'item RESTE dans 0 Inbox/. Signale-le dans le rapport (ne force pas un mauvais rangement).
```

Routing automatique, zéro confirmation. Tu exécutes. Tu ne touches **ni `memory.md` ni `Journal/`**.

## Étape 4 — Écrire / déplacer / relier

Dans cet ordre, par item :

1. **Note atomique** : `Write` le `.md` nommé dans le dossier cible (frontmatter `date` + `source`).
   **Rangement tel quel** : déplace l'original vers le dossier cible (créer le dossier si absent).
   **Note .md existante** : déplace vers le dossier cible.
2. **Relier (wikilinks)** — uniquement pour la valeur connective (note atomique, concept, asset, idée de contenu, méthode), et seulement si ce vault pratique les wikilinks Obsidian :
   - `grep -ri "[terme clé]" --include=*.md` le vault (hors `.claude/` et le dossier d'archives) sur les concepts/entités/noms.
   - Ajoute 3-5 `[[wikilinks]]` depuis l'item vers les notes voisines. Un seul sens (Obsidian fait le backlink). Cible des **noms de fichiers uniques** ; si la cible est ambiguë (`notes.md`), utilise le chemin `[[1 Terrains/.../notes|alias]]`.
   - Rien de pertinent → pas de lien forcé.
3. **Sortir de l'inbox** : si tu as créé une note atomique à partir d'un asset brut, **déplace l'asset brut** vers le dossier cible (à côté de sa note, ou dans le dossier d'assets adéquat) OU supprime-le s'il n'a plus de valeur une fois extrait (un screenshot d'idée → l'idée est dans la note, l'image peut partir ; un témoignage client → on garde l'image). En cas de doute : **garde l'original** rangé, ne supprime pas.

## Étape 5 — Confirmer

Rapport final structuré, sans fioritures :

```
✓ Inbox triée — N items traités, M restants

Rangés :
- [item] → 1 Terrains/.../[fichier] (note atomique, relié à [[X]], [[Y]])
- [item] → 1 Terrains/.../[dossier]/ (rangé tel quel)
- [item.md] → 2 Ressources/.../ (déplacé)

Supprimés :
- [item] (sans valeur / doublon)

Restés dans l'inbox (à trancher) :
- [item] — raison (ambigu / donnée client → à reporter dans le CRM)
```

Pas d'explication détaillée.

## Edge cases

- **Pas de CLAUDE.md / pas de section routing** : utilise l'arbre générique (Étape 3), ne bloque pas.
- **Inbox vide** → `"Inbox déjà vide, rien à trier."` et stop.
- **Doublon** : l'info/asset existe déjà dans le dossier cible → ne pas dupliquer, supprimer l'original de l'inbox, mentionner `"déjà présent, supprimé de l'inbox"`.
- **Donnée client dynamique** (statut, deal, activité) et CLAUDE.md déclare un CRM externe comme source de vérité : ne crée pas de `.md`. Laisse dans l'inbox et signale `"→ à reporter dans le CRM"`.
- **Asset volumineux / binaire illisible** : route sur le nom + contexte, range tel quel, ne tente pas de l'ouvrir.
- **Dossier dans l'inbox** : route le dossier entier en bloc vers le terrain adéquat, ne l'éclate pas item par item sauf si son contenu va dans des terrains différents.
- **Conflit de nom** à destination : ne pas écraser ; renommer avec un suffixe daté.
- **Vraiment indécidable** : laisser dans `0 Inbox/`. C'est OK. Mieux vaut un item en attente qu'un mauvais rangement.

## Ce que tu ne fais PAS

- Écrire dans `memory.md` ou `Journal/`.
- Créer des `.md` de suivi client si CLAUDE.md déclare un CRM externe comme source de vérité.
- Router à l'aveugle sans avoir lu le contenu de l'item.
- Supprimer un original dont la valeur n'a pas été pleinement extraite — en cas de doute, ranger plutôt que supprimer.
