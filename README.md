# Pack second cerveau : les 8 skills

Ce dossier contient les huit skills qui installent et font vivre un second cerveau avec Claude Code, selon la méthode des Terrains.

| Skill | Ce qu'il fait | Tu le lances quand |
|---|---|---|
| `onboarding` | Installe le cerveau de zéro : une interview adaptée à ton métier, puis la création de tout le dossier, puis l'explication. | Dossier vide, première fois. Tape `/onboarding`. |
| `onboarding-migrate` | Pareil, mais reprend ce que tu as déjà (notes, un ancien AGENTS.md, des dossiers de clients) sans rien perdre. | Dossier déjà rempli. Tape `/onboarding-migrate`. |
| `app` | Crée ou reprend une application : le code va dans le dossier Apps à côté du cerveau, la fiche reste dans le cerveau. | « crée-moi une app… », « bosse sur l'app… ». |
| `save` | Range ce qui mérite d'être gardé à la fin d'une session. | Avant de fermer. Tape `/save`. |
| `tri-inbox` | Vide le dossier « 0 Inbox » : chaque fichier déposé part au bon endroit. | Quand l'inbox déborde. Tape `/tri-inbox`. |
| `grill-me` | Claude te pose des questions, une par une, pour sortir ce que tu sais sur un sujet et l'écrire proprement. | « grille-moi sur … ». |
| `partager` | Donne ton dossier business à quelqu'un de ton équipe par Google Drive : vérifications, droits dans le bon ordre, message à lui envoyer, test. | « partage mon business avec … », `/partager`. |
| `nouveau-skill` | Transforme une tâche que tu fais à la main en skill : Claude t'interroge, écrit ta façon de faire, puis l'outil, et l'essaie sur un vrai cas. | « crée un skill qui … », `/nouveau-skill`. |

## Installation : une phrase à coller

1. Crée un dossier vide sur ton ordinateur, là où tu veux ton cerveau (par exemple `Documents/Mon cerveau`). Si tu as déjà un dossier avec des notes ou un ancien contexte, utilise celui-là.
2. Ouvre Claude Code dans ce dossier.
3. Colle cette phrase (Claude fait tout : il télécharge, range les skills dans un dossier `Skills/` visible, et les relie) :

> Installe les skills de https://github.com/cblain100-prog/second-cerveau-skills dans ce dossier : télécharge le dépôt, copie ses huit dossiers de skills (onboarding, onboarding-migrate, app, save, tri-inbox, grill-me, partager, nouveau-skill) dans un dossier `Skills/` ici (visible, pas caché), puis lance une fois `bash Skills/onboarding/setup/scripts/link-skills.sh` pour que Claude Code et Codex sachent où ils sont, vérifie que les huit sont bien là, et dis-moi quoi faire ensuite.

4. Claude installe, puis te dit de le relancer. Tu relances Claude Code dans le même dossier et tu tapes `/onboarding`.

Tu n'as pas à choisir entre `/onboarding` et `/onboarding-migrate` : si ton dossier contient déjà des notes ou un ancien contexte, `/onboarding` le voit et te propose de basculer sur la version qui reprend l'existant.

Si tu préfères faire à la main : télécharge `pack-second-cerveau.zip` sur la page du dépôt, décompresse, et copie les huit dossiers qui sont dans `skills/` vers un dossier `Skills/` à l'intérieur de ton dossier cerveau. Puis ouvre Claude Code dans ce dossier et dis « lance Skills/onboarding/setup/scripts/link-skills.sh ».

Pourquoi `Skills/` et pas un dossier caché : tes outils doivent être visibles dans le Finder et dans Obsidian, comme le reste de ton cerveau, et **ils t'appartiennent, pas à un outil**. Ton cerveau ne contient aucun dossier caché de skills. Chaque outil (Claude Code, Codex) lit les skills à sa propre adresse cachée dans ton dossier personnel, en dehors du cerveau : le petit script fait de cette adresse un raccourci vers ton `Skills/`, une fois pour toutes, pour les deux outils. Après ça, tu ajoutes ou supprimes un skill dans `Skills/`, et c'est tout : rien à relancer. Le jour où tu changes d'outil, tu n'emportes rien, tout est déjà au bon endroit.

## Ce que ces skills ne contiennent pas

Aucune information sur une autre personne, aucun client, aucun outil imposé. Tout ce qui est propre à toi sera écrit pendant l'onboarding, dans ton dossier. Les skills lisent ensuite ton `AGENTS.md` pour savoir où ranger chaque chose.
