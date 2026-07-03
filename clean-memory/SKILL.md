---
name: clean-memory
description: Nettoie memory.md en archivant les leçons de plus de 30 jours non-pinnées vers l'archive du vault (par défaut 3 Archives/lessons-archive.md). Garde le contexte auto-loadé léger et propre. Skill général : il s'adapte à n'importe quel vault via son CLAUDE.md/memory.md. Utiliser quand l'utilisateur dit "/clean-memory", "clean memory", "nettoie ma mémoire", "rotation mémoire", ou quand le SessionStart détecte des leçons archivables.
---

# Clean Memory — Rotation manuelle des leçons

Déplace les leçons > 30 jours non-pinnées de `memory.md` vers le fichier d'archive du vault. Garde `memory.md` propre et le contexte auto-loadé léger.

Ce skill est **général** : il ne connaît pas la structure exacte du vault à l'avance. Il la déduit de `CLAUDE.md` / `memory.md` à chaque exécution (méthode des Terrains : `memory.md` à la racine = seul fichier auto-loadé au SessionStart, `3 Archives/` = dossier des terrains/notes archivés). Si ta structure diverge de ce standard, adapte les chemins ci-dessous — tout le reste du raisonnement reste identique.

## Quand l'utiliser

- Trigger explicite : l'utilisateur tape `/clean-memory`, "clean memory", "nettoie ma mémoire", "rotation mémoire"
- Trigger implicite : au SessionStart, si tu détectes des leçons > 30j non-pinnées dans `memory.md`, propose le clean. N'exécute QUE si l'utilisateur valide.

## Étape 0 — Localiser les fichiers cibles

Avant tout, confirme les deux chemins sur lesquels ce skill opère :

- **Fichier auto-loadé** : `memory.md` à la racine du vault (le fichier que le `CLAUDE.md` du vault désigne comme "SEUL fichier auto-loaded au SessionStart"). Repli si un autre nom est utilisé : grep `CLAUDE.md` pour la ligne qui décrit ce fichier.
- **Fichier d'archive** : par défaut `3 Archives/lessons-archive.md`. Si le `CLAUDE.md` du vault pointe vers un autre chemin pour l'archive des leçons (section Routing, entrée du type "Leçon historique / archive"), utilise celui-là à la place. S'il n'existe pas encore, tu le créeras à l'Étape 4.

Ne bloque jamais faute de CLAUDE.md détaillé : à défaut d'indication contraire, `memory.md` (racine) → `3 Archives/lessons-archive.md` est le repli standard de la méthode des Terrains.

## Étape 1 — Identifier la date cutoff

Date du jour = date fournie par le contexte système (ou `date +%Y-%m-%d`).
Cutoff = date du jour - 30 jours.

Exemple : si on est le 2026-05-13, cutoff = 2026-04-13. Toute leçon datée < 2026-04-13 est archivable.

## Étape 2 — Parser memory.md

Lire `memory.md` (racine du vault) et identifier la section `# Leçons récentes (< 30 jours)` (ou équivalent le plus proche si l'utilisateur l'a renommée — repère la section qui contient les entrées datées `## YYYY-MM-DD`).

Pour chaque sous-section `## YYYY-MM-DD` (ou `## YYYY-MM-DD — titre`) dans cette section :
- Extraire la date
- Vérifier si la sous-section contient le tag `[PINNED]` dans son titre
- Si date < cutoff ET pas `[PINNED]` → marquer comme archivable

⚠️ Ne JAMAIS toucher aux sections `# Règles permanentes`, `# Leçons [PINNED]`, `# État projet` (ou toute section équivalente hors "Leçons récentes"). Le clean ne concerne QUE la section des leçons récentes.

⚠️ Ne JAMAIS archiver une entrée `[PINNED]`, même si elle est mal rangée (dans la mauvaise section).

## Étape 3 — Demander confirmation

Si zéro leçon archivable → dire `"memory.md déjà propre, rien à archiver."` et stopper.

Sinon, présenter à l'utilisateur la liste des dates et titres des leçons à archiver, format :
```
Leçons archivables (< [date cutoff], non-pinnées) :
- YYYY-MM-DD : titre de la leçon
- YYYY-MM-DD : titre de la leçon
- ...

J'archive ces N entrées dans [fichier d'archive] ? (oui / non / garde X)
```

Attendre la réponse :
- `"oui"` / `"go"` / `"vas-y"` → exécuter étape 4
- `"non"` → annuler, ne rien faire
- `"garde X"` ou `"sauf X"` → exclure X de la liste, re-confirmer

## Étape 4 — Archiver

Pour chaque leçon validée :
1. Append le bloc complet (titre + corps) dans le fichier d'archive identifié à l'Étape 0, sous une nouvelle section `## Archivé le YYYY-MM-DD (rotation auto)` (créer la section si elle n'existe pas déjà pour la date du jour ; créer le fichier lui-même s'il n'existe pas encore, avec un titre `# Archive des leçons` en en-tête)
2. Supprimer le bloc de `memory.md`

⚠️ Attention à la suppression : utiliser Edit avec `old_string` qui inclut le titre de la sous-section ET tout le corps jusqu'à la prochaine sous-section `##`. Vérifier qu'on ne casse pas la structure du fichier.

## Étape 5 — Update timestamp

Dans `memory.md`, mettre à jour la ligne `> Dernier clean : YYYY-MM-DD` si elle existe (généralement en tête de fichier) avec la date du jour. Si cette ligne n'existe pas, ne rien inventer — passe simplement à l'étape suivante.

## Étape 6 — Logger dans le journal (si le vault en a un)

Si le vault a un dossier de journal quotidien (`Journal/` à la racine, ou équivalent référencé dans le `CLAUDE.md`), append dans `Journal/YYYY-MM-DD.md` (créer si absent), sous une section `## Clean memory (HH:MM)` :

```markdown
## Clean memory (HH:MM)

Rotation auto exécutée. N leçons archivées vers [fichier d'archive] :
- YYYY-MM-DD : titre de la leçon
- YYYY-MM-DD : titre de la leçon
- ...

memory.md : X lignes (avant clean : Y lignes)
```

Ce log permet à l'utilisateur de revert si une leçon a été archivée à tort (il peut grep dans le fichier d'archive et la remettre dans `memory.md` manuellement).

Si le vault n'a pas de journal quotidien, saute cette étape sans bloquer.

## Étape 7 — Confirmer

Message final à l'utilisateur, sans fioritures :
```
✓ N leçons archivées dans [fichier d'archive]
✓ memory.md : X lignes (avant : Y lignes)
✓ Log dans Journal/YYYY-MM-DD.md (si applicable)
```

## Edge cases

- **Aucune leçon archivable** : dire "memory.md déjà propre" et stopper. Update quand même le timestamp "Dernier clean" s'il existe.
- **Section "Leçons récentes" vide ou absente** : créer la section avec un commentaire `(Aucune leçon récente)`. Pas d'archivage.
- **Section "Leçons [PINNED]" déborde** : ne jamais archiver les PINNED. Si l'utilisateur veut un de-pin, c'est manuel (il doit dire explicitement "unpin la leçon X").
- **Conflit avec un append en cours** : si l'utilisateur est en train de taper et qu'on ajoute une leçon récente pendant le clean, refaire le parse à la fin pour ne pas perdre l'ajout.
- **Vault sans fichier d'archive existant** : le créer à l'Étape 4 (repli `3 Archives/lessons-archive.md`), pas besoin de demander où — c'est l'emplacement standard de la méthode des Terrains.
- **`memory.md` introuvable à la racine** : vérifie s'il porte un autre nom dans ce vault (grep `CLAUDE.md` pour "SEUL fichier auto-load*"). Si vraiment aucun fichier mémoire n'existe, ce skill ne s'applique pas — le signaler et stopper plutôt que d'inventer un fichier.
