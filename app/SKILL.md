---
name: app
description: Crée ou reprend une application en appliquant la règle Apps du second cerveau, toujours de la même façon. Deux dossiers côte à côte, Brain (le contexte, dans Drive) et Apps (le code, jamais dans Drive). Le code va dans Apps/<app>/ à côté du cerveau, avec son AGENTS.md, son Git et sa sauvegarde en ligne privée ; la fiche <app>.md est écrite dans le cerveau, à l'endroit où la personne veut voir son app (Apps/ du terrain, dossier client). La personne n'a rien à relier. Utiliser quand l'utilisateur dit "/app", "crée-moi une app", "nouvelle app", "bosse sur l'app X", "reprends l'app X", "où est le code de X", ou décrit un outil, un site, un script ou un dashboard à construire.
---

# App : créer ou reprendre une application (règle Apps)

Ce skill existe pour que le lien entre le cerveau et le code soit fait **à chaque fois, de la même manière, par Claude**, sans que la personne apprenne quoi que ce soit. La règle qu'il applique :

- **Le cerveau** (le dossier où ce skill tourne, quel que soit son nom) : le contexte. Texte. Dans Drive. Le terrain business se partage à l'équipe.
- **`Apps/`, à côté du cerveau (même dossier parent)** : le code, une app par sous-dossier. Jamais dans Drive, jamais partagé. Git et sauvegarde en ligne gérés ici.
- **Le lien, en texte, dans les deux sens** : une fiche `<app>.md` dans le cerveau (`code:` + rôle, URL, lancement, décisions) ; un `AGENTS.md` dans l'app qui renvoie au cerveau.

Ce que la personne retient : « Brain c'est ce que je sais, Apps c'est ce que je construis, je parle toujours depuis Brain. »

## 0. Repères

- `BRAIN` = la racine du cerveau (`$CLAUDE_PROJECT_DIR`, ou le `pwd` si on est dedans). Lire `AGENTS.md` si ce n'est pas déjà fait : la carte dit où sont les terrains et les clients.
- `APPS` = le dossier `Apps` **à côté du cerveau**, dans le même dossier parent : `APPS="$(dirname "$BRAIN")/Apps"` (pour un cerveau dans `~/Brain`, c'est `~/Apps` ; pour un cerveau dans `~/Documents/Mon cerveau`, c'est `~/Documents/Apps`). S'il n'existe pas : `mkdir -p "$APPS"`, et le dire en une ligne (« j'ai créé le dossier Apps à côté de ton cerveau, c'est là que vivra ton code »). Si la personne a déjà un dossier de code ailleurs (`~/Code`, `~/Projets`…) et le dit, l'utiliser à la place et noter le chemin dans `Outils/outils.md` du terrain business (« Apps : ~/Code »). Dans tout ce qui est écrit (fiches, AGENTS.md d'app), le chemin réel, jamais `~/Brain/` ni `~/Apps/` en dur.
- Nom d'app : kebab-case, court, sans accent ni espace (`app-devis`, `site-vitrine`, `bot-rdv`). Proposer le nom, la personne valide ou corrige.

## 1. Décider : créer ou reprendre

- « crée », « nouvelle », un outil décrit qui n'existe pas → **créer** (§ 2).
- « bosse sur », « reprends », « modifie », « où est » + un nom → **reprendre** (§ 3) : chercher la fiche `grep -rl "^code:" "$BRAIN/1 Terrains" | xargs grep -l "<nom>"` ; si aucune fiche mais un dossier `$APPS/<nom>/` existe, écrire la fiche manquante (§ 2.4) puis reprendre.
- Un dossier de code trouvé **dans le cerveau** (dossier avec `package.json`, `requirements.txt`, `.git`, `node_modules`) → **sortir** (§ 4).

## 2. Créer une app

### 2.1 Où la personne veut la voir

Une question, une seule, si ce n'est pas évident : « Cette app, elle sert à ton business en général ou à un client précis ? » Business → la fiche ira dans `1 Terrains/<Business>/Apps/<app>.md`. Client → `1 Terrains/<Business>/Clients/<client>/<app>.md`. Un autre terrain (perso, SaaS) → `1 Terrains/<terrain>/Apps/<app>.md`. Créer le dossier `Apps/` du terrain s'il n'existe pas.

### 2.2 Le code

```bash
mkdir -p "$APPS/<app>" && cd "$APPS/<app>"
```

Construire l'app avec la stack demandée (ou la plus simple qui fait le travail). Puis, toujours :

- `$APPS/<app>/AGENTS.md`, trois lignes, avec le chemin réel du cerveau :

```markdown
# <app>
<Ce que fait l'app, pour qui, en une phrase.>
Contexte business : lis `<BRAIN>/AGENTS.md` puis `<BRAIN>/1 Terrains/<Business>/_context.md` avant de coder ; la fiche de cette app est `<BRAIN>/<chemin de la fiche>`.
Règles : Git et sauvegarde en ligne gérés ici ; les clés vivent dans `.env` de ce dossier, jamais dans le cerveau ; à chaque changement notable, mettre à jour la fiche dans le cerveau (URL, décisions, état).
```

- `.gitignore` avec au minimum `.env`, `.env.*`, `node_modules/`, `.DS_Store`, plus ce que la stack impose.
- `git init -b main && git add -A && git commit -m "init <app>"`.
- Sauvegarde en ligne, privée, si `gh auth status` passe : `gh repo create <app> --private --source=. --remote=origin --push`. Sinon : le dire une fois (« ton code est sauvegardé sur ton ordinateur ; pour la copie en ligne il faut connecter GitHub, on le fera avec la plomberie ») et noter « remote : à créer » dans la fiche. Jamais de dépôt public.

### 2.3 Lancer et vérifier

Lancer l'app (dev server, script, build). Ne pas dire « ça marche » sans l'avoir vu : une page qui répond (`curl` ou navigateur), un script qui produit sa sortie sur un cas réel.

### 2.4 La fiche dans le cerveau

`<BRAIN>/<chemin choisi en 2.1>/<app>.md` :

```markdown
---
date: <date>
code: <chemin réel de $APPS>/<app>/
url: <où l'app tourne : Vercel, VPS, localhost:port ; ou « pas encore déployée »>
remote: <dépôt GitHub privé, ou « à créer »>
---
# <Nom lisible de l'app>

## À quoi elle sert
<une à trois lignes : pour qui, quel problème, ce qu'elle remplace>

## Comment on la lance
Dis-moi « bosse sur l'app <app> ». (Pour les curieux : `cd <chemin réel>/Apps/<app> && <commande>`.)

## Décisions
- <date> : <stack choisie, pourquoi>
- <date> : <décision produit>

## État
<en construction / en prod / en pause>. Prochaine étape : <…>
```

Si la fiche est dans un dossier client, ajouter une ligne dans son `brief.md` : « App <app> : voir `<app>.md` ». Si le terrain a un `Outils/outils.md`, y ajouter la ligne de l'app (rôle, URL, dépôt).

### 2.5 Confirmer, en une ligne

`✓ <app> créée dans Apps/<app> à côté de ton cerveau (le code) ; fiche dans <chemin de la fiche> ; <URL ou « pas encore déployée »>`. Pas de tutoriel Git, pas de vocabulaire technique en plus.

## 3. Reprendre une app

1. Lire la fiche (`code:`, décisions, état) puis `cd` dans le code et lire son `AGENTS.md`.
2. Faire le travail demandé dans `$APPS/<app>/`. Vérifier sur un cas réel.
3. `git add -A && git commit -m "<ce qui a changé>"` ; `git push` si un remote existe.
4. Mettre la fiche à jour : `url` si elle a changé, une ligne dans « Décisions » si une décision a été prise, « État » et « Prochaine étape ». C'est ce que l'équipe voit ; une fiche qui ment est pire qu'une fiche absente.
5. Confirmer en une ligne, avec l'URL si l'app en a une.

## 4. Sortir un dossier de code trouvé dans le cerveau

Un dossier de code dans le cerveau finit dans Drive avec ses `node_modules` et son `.env`. Le sortir, sans rien perdre :

1. Dire ce qu'on va faire, en une phrase (« ton app X est dans ton cerveau, je la déplace dans Apps à côté et je laisse sa fiche à sa place ; pour toi rien ne change »).
2. `mkdir -p "$APPS" && mv "<chemin dans le cerveau>" "$APPS/<app>"` (jamais `cp` : pas deux copies).
3. Écrire la fiche à l'ancien emplacement (§ 2.4) d'après ce que le dossier contient (README, `package.json`, `.vercel/project.json`, `git remote -v`). Poser le `AGENTS.md` de l'app s'il n'existe pas. `git init` si le dossier n'a pas de `.git`.
4. Chercher les références à l'ancien chemin dans le cerveau (`grep -rn "<ancien chemin>" "$BRAIN" --include='*.md' --include='*.json' --include='*.sh' --include='*.plist' -l`, plus `~/Library/LaunchAgents/*.plist` sur Mac) et les corriger. Un service qui tournait depuis l'ancien chemin est relancé et vérifié (une requête qui répond).
5. Si le dossier était suivi par le Git du cerveau : `git rm -r --cached` de l'ancien chemin, et vérifier que `git ls-files | grep -i "\.env"` ne renvoie rien.

## Garde-fous

- Jamais de clé, de `.env` ni de `node_modules` dans le cerveau. Si on en trouve, c'est le § 4.
- Jamais de dépôt public.
- Jamais deux copies du même code (une dans Apps, une dans le cerveau) : on déplace, on ne duplique pas.
- La fiche est courte et vraie. Le détail technique vit dans le README de l'app, pas dans la fiche.
- Ne pas expliquer Git, GitHub ou les liens à la personne sauf si elle demande. Elle retient « Brain et Apps ».
