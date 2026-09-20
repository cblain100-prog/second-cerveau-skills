---
name: nouveau-skill
description: Transforme une façon de faire de la personne en skill, toujours de la même manière. Part d'une tâche qu'elle fait à la main (facturer, répondre à un lead, préparer une séance, publier un post), l'interviewe pour sortir les étapes, les règles et les pièges, écrit d'abord le process en mots (Process/<Équipe>/<verbe>.md) puis le skill qui l'exécute (Skills/<nom>/SKILL.md), au bon endroit (business → Skills du terrain, partagé avec l'équipe ; perso → Skills à la racine), le teste sur un cas réel, et vérifie qu'il répond. Utiliser quand l'utilisateur dit "/nouveau-skill", "crée un skill qui…", "fais-en un skill", "automatise ça", "j'aimerais que tu fasses ça à chaque fois pareil", "je fais toujours la même chose quand…".
---

# Nouveau skill : d'une tâche répétée à un outil

Un skill, c'est une façon de faire écrite pour que Claude la refasse pareil à chaque fois. Un bon skill vient toujours d'un process : d'abord la façon de faire en mots, lisible par un humain, puis sa version exécutable. Ce skill fait les deux dans l'ordre, et ne dit « prêt » qu'après un test sur un cas réel.

Parler simple : « on écrit comment tu fais », « je le transforme en outil », « on l'essaie ». Pas de « frontmatter », « trigger », « prompt ».

## 1. La tâche

Si la personne n'a pas nommé la tâche, une seule question : « C'est quoi la chose que tu refais le plus souvent à la main, et qui te prend du temps ? » Sinon, reformuler en une phrase et faire valider : « Donc à chaque fois qu'un nouveau client signe, tu crées son dossier, tu lui envoies le mail de bienvenue et tu bloques un créneau. C'est ça ? »

Vérifier qu'un skill ou un process n'existe pas déjà : `ls Skills/ "1 Terrains"/*/Skills/ 2>/dev/null` et `grep -rli "<mots clés>" "1 Terrains"/*/Process/`. S'il existe, on l'améliore au lieu d'en créer un second.

## 2. L'interview (une question à la fois, comme /grill-me)

Sortir ce que la personne a dans la tête. Dans cet ordre, en creusant une fois quand la réponse est en surface :

1. **Quand** ça se déclenche (un événement, un jour, une demande).
2. **Les étapes**, dans l'ordre, avec ce qui est produit à chaque étape. « Et après ? » jusqu'à la fin.
3. **Les entrées** : ce qu'il faut avoir sous la main (un nom, un fichier, un lien, une info du cerveau : où exactement ?).
4. **Les sorties** : ce qui existe à la fin (un fichier, un mail en brouillon, une ligne dans un tableau, un dossier). Et où ça se range dans le cerveau (carte de routing de `AGENTS.md`).
5. **Les règles** : ce qu'on fait toujours, ce qu'on ne fait jamais, le ton, les mentions obligatoires.
6. **Les pièges** : ce qui a déjà raté, les cas particuliers.
7. **Ce qui reste à la personne** : ce que le skill ne doit jamais faire seul (envoyer, publier, payer, supprimer). Par défaut, tout ce qui part vers l'extérieur s'arrête en brouillon.
8. **Un exemple réel** : un vrai cas récent, avec les vraies données (ou un fichier existant), pour le test de la fin.

Si la personne a déjà un modèle (un mail type, une facture, un compte rendu), le demander et s'en servir : un exemple réel vaut mille descriptions.

## 3. D'abord le process, en mots

Écrire `1 Terrains/<Business>/Process/<Équipe>/<verbe-objet>.md` (ou compléter celui qui existe). Équipe = qui portera ça le jour où il y a une équipe (Sales, Ops, Finance, Marketing, Support, RH). Gabarit :

```markdown
# <Verbe + objet>
Quand : <déclencheur>
Qui : <la personne> (solo) / <Équipe> le jour où elle existe
Étapes :
1. <…>
Outils : <outils cités, détail dans Outils/outils.md>
Pièges : <…>
Skill : Skills/<nom>
```

Ajouter la ligne dans `Process/_index.md`. Une tâche perso (pas business) n'a pas de process : passer directement au skill, dans `Skills/` à la racine.

## 4. Puis le skill

Nom : un mot ou deux en kebab-case, le verbe si possible (`facturer`, `onboarder-client`, `preparer-seance`). Emplacement :

- sert au business → `1 Terrains/<Business>/Skills/<nom>/SKILL.md` (l'équipe le recevra par Drive le jour du partage) ;
- perso → `Skills/<nom>/SKILL.md`.

Contenu, dans cet ordre, court et concret (le skill est lu par Claude, pas par la personne) :

```markdown
---
name: <nom>
description: <Ce que fait le skill, en une phrase, puis les mots qui le déclenchent : « Utiliser quand l'utilisateur dit "/<nom>", "…", "…" ».>
---

# <Titre>

Process de référence : `1 Terrains/<Business>/Process/<Équipe>/<verbe-objet>.md`.

## Ce qu'il faut avant
<les entrées : où les lire dans le cerveau (chemins), ce qu'il faut demander à la personne si ça manque, une question groupée>

## Étapes
1. <étape, précise, avec le fichier lu ou écrit>
2. …

## Règles
- <toujours / jamais, ton, mentions, format>
- <ce qui s'arrête en brouillon : jamais envoyé, publié, payé, supprimé sans la personne>

## Où ça se range
<chemins exacts dans le cerveau, selon la carte de routing>

## Vérification avant de dire « fait »
<le contrôle du résultat : le fichier existe et contient X, le brouillon est visible, le chiffre est juste>

## Confirmer
`✓ <ce qui a été fait> : <chemin ou lien>` en une ligne.
```

Règles d'écriture : jamais de tiret cadratin ; les chemins sont ceux du cerveau de la personne (lus dans `AGENTS.md`), jamais inventés ; pas de clé ni de secret dans le skill (les noms de variables vivent dans `Outils/outils.md`, les valeurs dans `.env`) ; si le skill a besoin d'un script, il va dans `Skills/<nom>/scripts/`.

## 5. Le rendre disponible

- Cas simple (un seul dossier `Skills/`, raccourci de dossier entier) : le skill est vu immédiatement.
- Plusieurs dossiers `Skills/` (racine + terrain) : `CLAUDE_PROJECT_DIR="$(pwd)" bash Skills/onboarding/setup/scripts/link-skills.sh` (ou depuis le terrain s'il y est).
- Vérifier : `readlink ~/.claude/skills` ou `ls ~/.claude/skills/<nom>`. Dire à la personne de relancer Claude Code si le skill n'apparaît pas dans `/skills`.

## 6. Le test, sur le cas réel de l'étape 2.8

Lancer le skill sur le vrai cas. Regarder le résultat, pas le fait d'avoir lancé : le fichier attendu existe et son contenu est juste, le brouillon est bien un brouillon, rien n'est parti. Ce qui ne va pas se corrige dans le skill (et dans le process si c'est une étape manquante), puis on relance. Deux passes maximum ; au-delà, dire ce qui bloque.

## 7. Confirmer

```
✓ Skill /<nom> prêt (<emplacement>), testé sur <le cas réel>
  Process : <chemin>
  Il fait : <une ligne>. Il ne fait jamais : <ce qui reste à la personne>.
  Pour le lancer : « /<nom> » ou « <phrase naturelle> ».
```

Noter dans `_context.md` du terrain (§ Métier, tâches déléguées) que cette tâche est maintenant un skill.

## Garde-fous

- Pas de skill sans process pour une tâche business : le process est ce que l'équipe lira, le skill est ce que Claude exécutera.
- Un skill fait une chose. Une tâche qui en cache trois (créer le dossier, écrire le mail, planifier) reste un seul skill si c'est toujours enchaîné pareil ; sinon, trois.
- Jamais « prêt » sans test réel. Jamais d'envoi, de publication ou de paiement dans un skill créé ici : toujours un brouillon que la personne valide.
- Ne pas expliquer la mécanique (fichiers, raccourcis) sauf si la personne demande : elle retient « je te dis comment je fais, tu en fais un outil, on l'essaie ».
