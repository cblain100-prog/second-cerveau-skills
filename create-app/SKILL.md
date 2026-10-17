---
name: create-app
description: "Crée une application en appliquant la règle Apps du second cerveau ET en posant une architecture technique saine dès le départ. Deux dossiers côte à côte, Brain (le contexte, dans Drive) et Apps (le code, jamais dans Drive). Avant de coder, cadre le projet avec la personne (qui l'utilise, partage de données, sensibilité, exposition publique) et en déduit le bon niveau de sécurité Supabase/Vercel. Le code va dans Apps/<app>/ avec son AGENTS.md, son Git et sa sauvegarde en ligne privée ; la fiche <app>.md est écrite dans le cerveau. Aussi : reprendre une app existante, ou sortir un code trouvé dans le cerveau. Utiliser quand l'utilisateur dit \"/create-app\", \"crée-moi une app\", \"nouvelle app\", \"je veux créer un outil/un SaaS\", \"bosse sur l'app X\", \"reprends l'app X\", \"où est le code de X\", ou décrit un outil, un site, un script ou un dashboard à construire."
---

# Create App : créer une application, du cadrage à la stack technique

Ce skill existe pour que le lien entre le cerveau et le code soit fait **à chaque fois, de la même manière, par Claude**, sans que la personne apprenne quoi que ce soit, et pour qu'une app démarre avec une architecture saine plutôt qu'une table Supabase ouverte à tout le monde parce qu'on est allé vite. La règle qu'il applique :

- **Le cerveau** (le dossier où ce skill tourne, quel que soit son nom) : le contexte. Texte. Dans Drive. Le terrain business se partage à l'équipe.
- **`Apps/`, à côté du cerveau (même dossier parent)** : le code, une app par sous-dossier. Jamais dans Drive, jamais partagé. Git et sauvegarde en ligne gérés ici.
- **Le lien, en texte, dans les deux sens** : une fiche `<app>.md` dans le cerveau (`code:` + rôle, URL, lancement, décisions dont l'architecture retenue) ; un `AGENTS.md` dans l'app qui renvoie au cerveau et cadre la stack.
- **Avant le code, le cadrage** : qui utilisera l'app et avec quelles données détermine le niveau de sécurité (Supabase RLS, secrets Vercel), pas l'inverse.
- **Le cas par défaut** : une app pour soi ou son équipe, parfois ouverte ensuite à quelques utilisateurs, presque jamais vendue. Tout le skill reste simple pour ce cas ; ce qui ne sert qu'à une app commercialisée ne sort que si la personne le dit (§ 2.5).

Ce que la personne retient : « Brain c'est ce que je sais, Apps c'est ce que je construis, je parle toujours depuis Brain. »

## 0. Repères

- `BRAIN` = la racine du cerveau (`$CLAUDE_PROJECT_DIR`, ou le `pwd` si on est dedans). Lire `AGENTS.md` (ou `CLAUDE.md` dans un cerveau plus ancien) si ce n'est pas déjà fait : la carte dit où sont les terrains et les clients.
- `TERRAINS` = le dossier des terrains : `$BRAIN/1 Terrains` s'il existe, sinon `$BRAIN/Terrains` (structure plus ancienne), sinon la racine du cerveau elle-même. Le terrain business est celui que la carte désigne comme l'activité de la personne.
- `APPS` = le dossier `Apps` **à côté du cerveau**, dans le même dossier parent : `APPS="$(dirname "$BRAIN")/Apps"` (pour un cerveau dans `~/Brain`, c'est `~/Apps` ; pour un cerveau dans `~/Documents/Mon cerveau`, c'est `~/Documents/Apps`). S'il n'existe pas : `mkdir -p "$APPS"`, et le dire en une ligne (« j'ai créé le dossier Apps à côté de ton cerveau, c'est là que vivra ton code »). Si la personne a déjà un dossier de code ailleurs (`~/Code`, `~/Projets`…) et le dit, l'utiliser à la place et noter le chemin dans `Outils/outils.md` du terrain business (« Apps : ~/Code »). Dans tout ce qui est écrit (fiches, AGENTS.md d'app), le chemin réel, jamais `~/Brain/` ni `~/Apps/` en dur.
- Nom d'app : kebab-case, court, sans accent ni espace (`app-devis`, `site-vitrine`, `bot-rdv`). Proposer le nom, la personne valide ou corrige.
- Les comptes Supabase, Vercel et GitHub utilisés sont **toujours ceux de la personne** (le client, ou toi pour tes propres apps), jamais ceux d'un tiers. Si elle n'a pas encore ces comptes, les lui faire créer avant de continuer (gratuits, deux minutes) : c'est ce qui garantit que le jour où la collaboration s'arrête, elle garde tout.

## 1. Décider : créer, reprendre, ou sortir

- « crée », « nouvelle », un outil décrit qui n'existe pas → **créer** (§ 2).
- « bosse sur », « reprends », « modifie », « où est » + un nom → **reprendre** (§ 3) : chercher la fiche `grep -rl "^code:" "$BRAIN" --include="*.md" | xargs grep -l "<nom>"` ; si aucune fiche mais un dossier `$APPS/<nom>/` existe, écrire la fiche manquante (§ 2.6) puis reprendre.
- Un dossier de code trouvé **dans le cerveau** (dossier avec `package.json`, `requirements.txt`, `.git`, `node_modules`) → **sortir** (§ 4).

## 2. Créer une app

### 2.1 Où la personne veut la voir

Une question, une seule, si ce n'est pas évident : « Cette app, elle sert à ton business en général ou à un client précis ? » Business → la fiche ira dans `$TERRAINS/<Business>/Apps/<app>.md`. Client → le dossier de ce client dans le terrain business (`Clients/<client>/<app>.md`, ou là où la carte range les clients). Un autre terrain (perso, SaaS) → `$TERRAINS/<terrain>/Apps/<app>.md`. Créer le dossier `Apps/` du terrain s'il n'existe pas.

### 2.2 Cadrer le projet, avant tout le reste

Poser ces questions à la personne, en une seule fois, en français simple (jamais de jargon type RLS/tenant/backend) :

1. **Qui va utiliser cette app** : toi seul, ton équipe, ou tes propres clients (chacun avec son compte) ?
2. **Partage** : chaque utilisateur doit voir seulement ses propres infos, ou il y a des choses communes à tout le monde ?
3. **Données sensibles** : paiement, infos perso, documents confidentiels dedans, ou rien de critique ?
4. **Exposition** : cette app doit être accessible à n'importe qui avec le lien, ou réservée à toi/ton équipe ?
5. **Volume attendu** : juste toi, une poignée de personnes, ou potentiellement beaucoup d'utilisateurs ?

En déduire le niveau d'architecture, sans le nommer techniquement à la personne :

| Réponses | Niveau retenu | Ce que ça change côté Supabase/Vercel |
|---|---|---|
| Toi seul / ton équipe, pas de cloisonnement demandé | **Simple** | Une politique d'accès : authentifié = accès à tout. Pas de séparation par utilisateur. |
| Chacun de tes clients a son compte, ne voit que ses données | **Multi-tenant** | Une politique de sécurité par table qui n'autorise que les lignes de l'utilisateur connecté (`user_id` = celui qui interroge). Testée avant tout déploiement (§ 2.4). |
| Paiement, données perso, documents confidentiels | **Renforcé** (s'ajoute au niveau ci-dessus) | + clé secrète (service role, clé API tierce) jamais exposée côté navigateur ; webhooks vérifiés par signature ; pas de log qui affiche des données sensibles en clair. |

Puis, sans poser de question en plus : d'après ce que la personne a décrit, **proposer deux ou trois situations concrètes qui diront que l'app fait bien son travail**, en une phrase chacune (« tu ajoutes un devis, il apparaît dans la liste avec le bon total » ; « tu cliques sur Envoyer, le client reçoit le mail en moins d'une minute »). Elle valide ou corrige. Ce sont ces situations, et pas seulement « la page s'ouvre », qu'on vérifie en § 2.4.

### 2.3 Poser la stack technique

```bash
mkdir -p "$APPS/<app>" && cd "$APPS/<app>"
```

- `$APPS/<app>/AGENTS.md`, le fichier qui cadre Claude Code dès la première ligne :

```markdown
# <app>
<Ce que fait l'app, pour qui, en une phrase.>
Contexte business : lis `<BRAIN>/AGENTS.md` (ou `CLAUDE.md`) puis le `_context.md` du terrain business (`<chemin réel>`) avant de coder ; la fiche de cette app est `<BRAIN>/<chemin de la fiche>`.
Stack : <framework JS retenu>, Supabase (backend/base de données), Vercel (hébergement, variables d'environnement).
Architecture : niveau <Simple / Multi-tenant / Renforcé> (voir fiche <app>.md pour le détail du cadrage).
Règles : Git et sauvegarde en ligne gérés ici ; les clés vivent dans `.env` de ce dossier, jamais dans le cerveau ; RLS (sécurité au niveau des lignes) activé dès la première table Supabase, jamais de table ouverte par défaut ; la clé service role Supabase et toute clé secrète restent côté serveur, jamais dans le code front ; un essai que la personne abandonne (« laisse tomber », « je n'aime pas ») est retiré du code tout de suite, jamais laissé en place « pour plus tard » ; à chaque changement notable, mettre à jour la fiche dans le cerveau.
Ça marche quand : <les deux ou trois situations validées au cadrage>. Les revérifier après chaque modification.
```

- Créer le projet Supabase : les tables nécessaires, **RLS activé dès la création de la première table** (jamais « on sécurisera après »), politiques posées selon le niveau retenu en § 2.2, clé publique (anon) seule côté client, clé service role seulement dans les fonctions serveur.
- Créer le projet Vercel : variables d'environnement posées dans les réglages Vercel (jamais committées), lié au repo GitHub.
- Construire l'app avec la stack demandée (ou la plus simple qui fait le travail).
- `$APPS/<app>/.gitignore` avec au minimum `.env`, `.env.*`, `node_modules/`, `.DS_Store`, plus ce que la stack impose.
- `git init -b main && git add -A && git commit -m "init <app>"`.
- Sauvegarde en ligne, privée, si `gh auth status` passe : `gh repo create <app> --private --source=. --remote=origin --push`. Sinon : le dire une fois (« ton code est sauvegardé sur ton ordinateur ; pour la copie en ligne il faut connecter GitHub, on le fera avec la plomberie ») et noter « remote : à créer » dans la fiche. Jamais de dépôt public.

### 2.4 Lancer et vérifier

Lancer l'app (dev server, script, build). Ne pas dire « ça marche » sans l'avoir vu : une page qui répond (`curl` ou navigateur), un script qui produit sa sortie sur un cas réel. Puis jouer une par une les situations validées au cadrage (§ 2.2) : chacune donne le résultat attendu, sinon on corrige avant de rendre la main.

Si le niveau retenu en § 2.2 est **Multi-tenant** ou **Renforcé** : créer deux comptes de test et vérifier concrètement qu'un compte ne voit jamais les données de l'autre. C'est le seul contrôle qui prouve que la sécurité posée dans les réglages Supabase fonctionne réellement ; une politique déclarée mais non testée ne compte pas comme faite.

### 2.5 Rendre l'app publique, seulement si demandé

Tant que la personne n'a pas dit explicitement qu'elle veut que d'autres y accèdent, l'app reste en aperçu (URL de prévisualisation Vercel ou localhost) : pas de mise en production. Si elle veut une URL publique (à elle, ou à donner à ses propres clients), la guider vers le déploiement en production sur Vercel à ce moment-là, jamais avant, jamais de façon automatique.

Seulement si la personne dit qu'elle veut **faire payer l'app ou la proposer à d'autres entreprises** (pas pour une app ouverte à son équipe ou à ses propres clients) : lui dire en une phrase qu'avant d'ouvrir il faudra des conditions d'utilisation, une page sur les données personnelles (RGPD, le règlement européen) et un contrat si une entreprise en dépend, que ce n'est pas du code et que Claude peut l'aider à les rédiger. Le noter dans la fiche (« Décisions »). Ne bloque pas la construction ; ne jamais aborder le sujet sinon.

### 2.6 La fiche dans le cerveau

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

## Architecture
Niveau retenu : <Simple / Multi-tenant / Renforcé>, d'après le cadrage du <date> (<qui utilise, quelles données>).

## Ça marche quand
- <situation 1 validée au cadrage>
- <situation 2>

## Décisions
- <date> : <stack choisie, pourquoi>
- <date> : <décision produit>

## État
<en construction / en prod / en pause>. Prochaine étape : <…>
```

Si la fiche est dans un dossier client, ajouter une ligne dans son `brief.md` : « App <app> : voir `<app>.md` ». Si le terrain a un `Outils/outils.md`, y ajouter la ligne de l'app (rôle, URL, dépôt).

### 2.7 Confirmer, en une ligne

`✓ <app> créée dans Apps/<app> à côté de ton cerveau (le code), niveau <Simple/Multi-tenant/Renforcé> ; fiche dans <chemin de la fiche> ; <URL ou « pas encore déployée »>`. Pas de tutoriel Git, pas de vocabulaire technique en plus.

## 3. Reprendre une app

1. Lire la fiche (`code:`, décisions, architecture, état) puis `cd` dans le code et lire son `AGENTS.md`.
2. Faire le travail demandé dans `$APPS/<app>/`. Si le changement touche à qui a accès à quelles données, revérifier que le niveau d'architecture noté dans la fiche est toujours le bon (sinon, retour § 2.2). Le cas le plus courant : une app faite pour soi qu'on ouvre à son équipe ou à ses clients, chacun avec son compte. Elle passe alors en Multi-tenant, avec le test des deux comptes (§ 2.4) avant que quiconque d'autre s'y connecte.
3. Si la personne abandonne un essai en cours de route, le retirer du code tout de suite (fichiers, tables, routes créés pour lui), sans toucher à ce qui sert encore. Un essai laissé en place finit mêlé au reste et casse l'app des mois plus tard, quand on le supprime.
4. Vérifier sur un cas réel, puis rejouer les situations de « Ça marche quand » de la fiche (si elle n'en a pas encore, en proposer deux ou trois et les ajouter) : un changement ne doit pas casser ce qui marchait.
5. `git add -A && git commit -m "<ce qui a changé>"` ; `git push` si un remote existe.
6. Mettre la fiche à jour : `url` si elle a changé, une ligne dans « Décisions » si une décision a été prise, « État » et « Prochaine étape ». C'est ce que l'équipe voit ; une fiche qui ment est pire qu'une fiche absente.
7. Confirmer en une ligne, avec l'URL si l'app en a une.

## 4. Sortir un dossier de code trouvé dans le cerveau

Un dossier de code dans le cerveau finit dans Drive avec ses `node_modules` et son `.env`. Le sortir, sans rien perdre :

1. Dire ce qu'on va faire, en une phrase (« ton app X est dans ton cerveau, je la déplace dans Apps à côté et je laisse sa fiche à sa place ; pour toi rien ne change »).
2. `mkdir -p "$APPS" && mv "<chemin dans le cerveau>" "$APPS/<app>"` (jamais `cp` : pas deux copies).
3. Écrire la fiche à l'ancien emplacement (§ 2.6) d'après ce que le dossier contient (README, `package.json`, `.vercel/project.json`, `git remote -v`). Poser le `AGENTS.md` de l'app s'il n'existe pas. `git init` si le dossier n'a pas de `.git`.
4. Chercher les références à l'ancien chemin dans le cerveau (`grep -rn "<ancien chemin>" "$BRAIN" --include='*.md' --include='*.json' --include='*.sh' --include='*.plist' -l`, plus `~/Library/LaunchAgents/*.plist` sur Mac) et les corriger. Un service qui tournait depuis l'ancien chemin est relancé et vérifié (une requête qui répond).
5. Si le dossier était suivi par le Git du cerveau : `git rm -r --cached` de l'ancien chemin, et vérifier que `git ls-files | grep -i "\.env"` ne renvoie rien.

## Garde-fous

- RLS toujours activé par défaut, dès la première table, jamais de table ouverte « pour aller plus vite, on sécurisera après ».
- Jamais de clé secrète (service role Supabase, clé API tierce) côté front ou committée dans le code.
- Jamais tes propres comptes Supabase/Vercel/GitHub pour un client : toujours les siens.
- Rendre une app publique est toujours une décision explicite de la personne, jamais automatique.
- Jamais dire « ça marche » sur la seule base d'une page qui s'ouvre : ce sont les situations de « Ça marche quand » qui le prouvent.
- Un essai abandonné ne reste jamais dans le code.
- Conditions d'utilisation, RGPD, contrat : seulement si la personne veut vendre l'app, jamais imposés à une app perso ou d'équipe.
- Jamais de clé, de `.env` ni de `node_modules` dans le cerveau. Si on en trouve, c'est le § 4.
- Jamais de dépôt public.
- Jamais deux copies du même code (une dans Apps, une dans le cerveau) : on déplace, on ne duplique pas.
- La fiche est courte et vraie. Le détail technique vit dans le README de l'app, pas dans la fiche.
- Ne pas expliquer Git, GitHub, RLS ou les liens à la personne sauf si elle demande. Elle retient « Brain et Apps », et répond aux 5 questions du cadrage en langage courant.
