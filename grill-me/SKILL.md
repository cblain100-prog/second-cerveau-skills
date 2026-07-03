---
name: grill-me
description: Interview impitoyable pour extraire la connaissance de la tête de l'utilisateur sur un sujet, puis l'écrire en note structurée, rangée et reliée — en suivant la carte de routing du CLAUDE.md du vault. Pose question sur question (une à la fois) jusqu'à avoir tout sorti — contexte client, parcours, méthode, idée de contenu, doctrine, décision. Utiliser quand l'utilisateur dit "grill me", "grille-moi", "interroge-moi sur X", "fais-moi sortir tout ce que je sais sur X", "prépare le dossier de X en m'interviewant", ou avant un appel/contenu où il faut faire remonter la nuance.
---

# Grill Me — Interview d'extraction de connaissance

Le vrai goulot d'un second cerveau n'est pas la recherche, c'est **sortir la nuance de la tête de l'utilisateur**. Ce skill résout ça : tu l'interviewes sans pitié sur un sujet jusqu'à tout savoir, puis tu écris une note propre, rangée et reliée.

Ce skill est **général** : il ne connaît pas les terrains du vault à l'avance. Il découvre où ranger la note en lisant le `CLAUDE.md` du vault à chaque exécution — exactement comme `/save`. Quand la structure du vault évolue, tu n'as rien à changer ici.

## Invocation

L'utilisateur te donne un sujet : un client/prospect, sa méthode, son parcours, une idée de contenu, une doctrine, une décision à creuser. Si le sujet est vague, demande-lui de le préciser en 1 phrase avant de commencer.

## Principes de l'interview

- **Une seule question à la fois.** Jamais une liste. Tu attends sa réponse avant la suivante.
- **Creuse, ne survole pas.** Chaque réponse appelle un "pourquoi", un "concrètement ça donne quoi", un "donne-moi un exemple", un "et le cas où ça marche pas ?".
- **Relance sur le flou.** Si une réponse est générique ("ça dépend", "en gros"), force le concret.
- **Accepte les fichiers.** L'utilisateur peut coller un transcript, un contrat, un brief, un screenshot — intègre-les comme matière et pose des questions dessus.
- **Adopte son registre.** Reste dans la langue et le ton de l'utilisateur. Questions courtes et nettes.
- **Tu ne t'arrêtes que quand tu sais vraiment.** Cible : pouvoir réexpliquer le sujet à sa place. Vise au moins 8-15 questions selon la richesse. Quand tu sens que tu tournes en rond ou que tout est couvert, annonce que tu as assez et que tu rédiges.
- **Check de fin** : avant de rédiger, liste en 1 ligne les angles que tu n'as PAS creusés et demande s'il en manque un important.

## Angles à couvrir (adapte selon le sujet)

- **Le quoi** : définition nette, périmètre, ce que c'est / ce que c'est pas.
- **Le pourquoi** : la raison d'être, la valeur, l'enjeu.
- **Le concret** : exemples réels, chiffres, anecdotes, cas vécus.
- **Les nuances** : exceptions, cas limites, ce qui foire, les pièges.
- **Les relations** : à quoi/qui ça se relie (autres notes, projets, décisions passées).
- **Le futur** : comment l'utilisateur veut réutiliser cette info plus tard (ça détermine comment la ranger).

## Workflow

### Step 1 — Cadrer

- Reformule le sujet en 1 phrase et confirme.
- Charge le contexte existant si pertinent : recherche dans le vault les notes déjà liées au sujet pour ne pas répéter ce qui est déjà documenté, et pour préparer les liens.

### Step 2 — Griller

- Mène l'interview selon les principes ci-dessus. Une question à la fois.
- Garde mentalement la trace de ce qui est couvert / pas couvert.

### Step 3 — Lire la carte de routing (CLAUDE.md) — OBLIGATOIRE avant de ranger

Avant d'écrire la note, lis le `CLAUDE.md` à la racine du vault et repère sa section de **routing** (souvent titrée "Routing — où lire et où écrire" ou équivalent). C'est **LA source de vérité** des destinations dans ce cerveau : elle dit où va chaque type d'information.

- Identifie le type du sujet grillé (info client, méthode/doctrine, idée de contenu, décision, parcours...) et la règle correspondante dans la carte.
- Note aussi tout cas spécial déclaré là (ex : "info client → CRM externe d'abord", terrain nommé, dossier ressources transverses...).

**Repli** : si `CLAUDE.md` est absent, sans section routing, ou trop maigre pour décider → utilise l'**arbre générique par défaut** ci-dessous. Ne bloque jamais faute de carte.

```
1. Info sur un client/contact nommé ?
   → grep le nom dans le dossier des terrains ; sinon crée
     [terrain le plus probable]/[clients]/[Nom]/notes.md (ou la source de vérité
     dédiée si le CLAUDE.md en désigne une, ex. un CRM externe)

2. Méthode / doctrine / parcours / connaissance réutilisable liée à un terrain précis ?
   → identifie le terrain et le sous-dossier le plus précis, dépose-y la note

3. Doctrine / méthode / connaissance réutilisable transverse (utile à plusieurs terrains) ?
   → dossier des ressources transverses du vault, sous un titre kebab-case

4. Idée (contenu, produit, projet) ?
   → dossier du terrain concerné, en zone "idées"/"drafts"

5. Rien ne matche / sujet pas encore rattachable à un terrain existant ?
   → dossier de capture/inbox du vault, et signale-le à l'utilisateur
```

**Ne décide jamais seul d'écrire dans un fichier de mémoire auto-chargé (le noyau lu à chaque démarrage de session) ou dans un journal quotidien**, même si le sujet semble universel — propose-le plutôt à l'utilisateur, ce sont des espaces réservés à d'autres mécanismes.

### Step 4 — Rédiger la note

- Rédige avec **tes mots**, structuré, jamais un copier-coller des réponses brutes. Garde uniquement la valeur réutilisable.
- Frontmatter minimal : `date`, `source: grill-me`, `sujet`.
- **Ranger** : place la note à la destination identifiée à l'Step 3.
- **Relier** : recherche les concepts/entités clés dans le vault (grep sur les termes forts, hors dossiers d'archives) et ajoute 3-5 liens (`[[wikilinks]]` ou liens relatifs selon le format du vault) vers les notes voisines. Ne lie que dans un sens — Obsidian (ou l'outil équivalent) crée le backlink de l'autre côté.

### Step 5 — Confirmer

- Confirme où la note est partie et à quoi elle est reliée (ex : `✓ capturé dans [chemin] — relié à [[X]], [[Y]]`).
- Liste en 2-3 bullets ce qui mériterait une 2ᵉ session de grill plus tard si des angles restent ouverts.

## Garde-fous

- Ne décide pas seul d'écrire dans un fichier de mémoire auto-chargé ou un journal quotidien si le vault en réserve l'usage — propose plutôt.
- Si l'utilisateur dit "stop" en cours d'interview, rédige avec ce que tu as déjà.
- Si `CLAUDE.md` est absent ou sans carte de routing, ne bloque pas : utilise l'arbre générique de l'Step 3 et signale-le dans la confirmation finale.
