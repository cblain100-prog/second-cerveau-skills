# Pack contexte : les 8 skills

Ce dossier contient les huit skills qui installent et font vivre ton contexte avec Claude Code, selon la méthode des Terrains ([[doctrine-structure-vault-pilote-agent]]). Testé grandeur nature dans [[test-onboarding-client-fictif-2026-09-19]].

| Skill | Ce qu'il fait | Tu le lances quand |
|---|---|---|
| `create-context` | Installe ton contexte de zéro : il récupère d'abord ce que ChatGPT ou Claude savent déjà de toi (mémoire, projets), puis une interview adaptée à ton métier qui ne te repose pas ces questions, la création de tout le dossier, et l'explication. | Dossier vide, première fois. Tape `/create-context`. |
| `context-migrate` | Pareil, mais reprend ce que tu as déjà (notes, un ancien AGENTS.md, des dossiers de clients) sans rien perdre. | Dossier déjà rempli. Tape `/context-migrate`. |
| `create-app` | Cadre ton projet (qui l'utilise, quelles données), pose la bonne stack Supabase/Vercel/sécurité, crée ou reprend une application : le code va dans le dossier Apps à côté de ton dossier de contexte, la fiche reste dans le contexte. | « crée-moi une app… », « bosse sur l'app… ». |
| `save` | Range ce qui mérite d'être gardé à la fin d'une session. | Avant de fermer. Tape `/save`. |
| `tri-inbox` | Vide le dossier « 0 Inbox » : chaque fichier déposé part au bon endroit. | Quand l'inbox déborde. Tape `/tri-inbox`. |
| `grill-me` | Claude te pose des questions, une par une, pour sortir ce que tu sais sur un sujet et l'écrire proprement. | « grille-moi sur … ». |
| `partager` | Donne ton dossier business à quelqu'un de ton équipe par Google Drive : vérifications, droits dans le bon ordre, message à lui envoyer, test. | « partage mon business avec … », `/partager`. |
| `nouveau-skill` | Transforme une tâche que tu fais à la main en skill : Claude t'interroge, écrit ta façon de faire, puis l'outil, et l'essaie sur un vrai cas. | « crée un skill qui … », `/nouveau-skill`. |

## Installation : une phrase à coller

1. Crée un dossier vide sur ton ordinateur, là où tu veux ton contexte (par exemple `Documents/Mon contexte`). Si tu as déjà un dossier avec des notes ou un ancien contexte, utilise celui-là.
2. Ouvre Claude Code dans ce dossier.
3. Colle cette phrase (Claude fait tout : il télécharge, range les skills dans un dossier `Skills/` visible, et les relie) :

> Installe les skills de https://github.com/cblain100-prog/second-cerveau-skills dans ce dossier : télécharge le dépôt, copie ses huit dossiers de skills (create-context, context-migrate, create-app, save, tri-inbox, grill-me, partager, nouveau-skill) dans un dossier `Skills/` ici (visible, pas caché), puis lance une fois `bash Skills/create-context/setup/scripts/link-skills.sh` pour que Claude Code et Codex sachent où ils sont, vérifie que les huit sont bien là, et dis-moi quoi faire ensuite.

4. Claude installe, puis te dit de le relancer. Tu relances Claude Code dans le même dossier et tu tapes `/create-context`.

Tu n'as pas à choisir entre `/create-context` et `/context-migrate` : si ton dossier contient déjà des notes ou un ancien contexte, `/create-context` le voit et te propose de basculer sur la version qui reprend l'existant.

Si tu préfères faire à la main : télécharge `pack-contexte.zip` sur la page du dépôt, décompresse, et copie les huit dossiers qui sont dans `skills/` vers un dossier `Skills/` à l'intérieur de ton dossier de contexte. Puis ouvre Claude Code dans ce dossier et dis « lance Skills/create-context/setup/scripts/link-skills.sh ».

Pourquoi `Skills/` et pas un dossier caché : tes outils doivent être visibles dans le Finder et dans Obsidian, comme le reste de ton contexte, et **ils t'appartiennent, pas à un outil**. Ton dossier de contexte ne contient aucun dossier caché de skills. Chaque outil (Claude Code, Codex) lit les skills à sa propre adresse cachée dans ton dossier personnel, en dehors du dossier de contexte : le petit script fait de cette adresse un raccourci vers ton `Skills/`, une fois pour toutes, pour les deux outils. Après ça, tu ajoutes ou supprimes un skill dans `Skills/`, et c'est tout : rien à relancer. Le jour où tu changes d'outil, tu n'emportes rien, tout est déjà au bon endroit.

## Ce que ces skills ne contiennent pas

Aucune information sur une autre personne, aucun client, aucun outil imposé. Tout ce qui est propre à toi sera écrit pendant `/create-context`, dans ton dossier. Les skills lisent ensuite ton `AGENTS.md` pour savoir où ranger chaque chose.
