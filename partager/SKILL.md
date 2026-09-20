---
name: partager
description: Partage le terrain business du second cerveau avec une personne de l'équipe (assistant, freelance, associé, salarié) via Google Drive, de bout en bout et sans rien casser. Vérifie d'abord que le terrain est partageable (pas de code, pas de clé, pas de fichier lourd, rien de caché), s'assure que le cerveau est dans Mon Drive en miroir, pose les droits dans le bon ordre (Lecteur sur le terrain, Éditeur sur Clients et Docs, Éditeur sur son équipe, Finance coupé), écrit le message à envoyer à la personne, crée sa fiche dans Equipe/, et fait passer le test de bout en bout avant de dire « partagé ». Utiliser quand l'utilisateur dit "/partager", "partage mon terrain", "partage mon business avec X", "donne accès à X", "X rejoint l'équipe", "comment je partage mon second cerveau", "mettre mon cerveau sur Google Drive".
---

# Partager : donner son terrain business à quelqu'un de l'équipe

Le principe qu'on applique : le cerveau entier vit dans le « Mon Drive » du dirigeant, en miroir. On ne partage qu'un seul dossier, `1 Terrains/<Business>/`. Les droits Google Drive descendent, donc la personne voit ce dossier et rien au-dessus (ni Perso, ni Admin, ni le journal). Elle l'ouvre comme son propre cerveau : `AGENTS.md` du terrain est son point d'entrée, `Skills/` du terrain ses outils.

Ce skill fait tout dans l'ordre, et refuse d'avancer tant qu'un contrôle échoue. Parler simple à la personne : « je vérifie », « je range », « je donne accès », jamais « je configure les permissions héritées ».

## 0. Ce qu'il faut savoir avant de commencer

- Qui : prénom, rôle, email Google de la personne, et son équipe (Sales, Ops, Finance, Marketing, Support, RH). Une seule question groupée si ça manque.
- Le terrain : `1 Terrains/<Business>/` (le seul dossier avec un `AGENTS.md` dans `1 Terrains/`).
- Mac ou Windows chez le dirigeant et chez la personne (ça change le chemin de Drive).

## 1. Le terrain est-il partageable ? (contrôles, tous obligatoires)

Exécuter, lire, corriger avant de continuer. `T` est le chemin du terrain.

```bash
T="1 Terrains/<Business>"
# a. rien de caché, rien de code, rien de secret dans le terrain
find "$T" \( -name ".env" -o -name ".env.*" -o -name "node_modules" -o -name ".git" -o -name ".claude" -o -name "*.pem" -o -name "*.key" \) -maxdepth 6 | head
# b. rien de lourd (Drive ralentit, la personne ne veut pas télécharger des Go)
find "$T" -type f -size +50M | head ; du -sh "$T" ; find "$T" -type f | wc -l
# c. aucun lien symbolique (Drive ne les synchronise pas : ils disparaîtraient chez la personne)
find "$T" -type l | head
# d. le terrain a son mode d'emploi, ses skills, son dossier Équipe
ls "$T/AGENTS.md" "$T/Skills" ; ls "$T/Equipe" 2>/dev/null || echo "Equipe/ à créer"
```

Attendu : a, b (fichiers > 50 Mo) et c vides ; poids sous 1 Go et sous 5 000 fichiers ; d présent. Ce qui échoue se règle avec la règle Apps (un dossier de code → skill `/app` § 4 : il sort vers `Apps/` à côté du cerveau, une fiche reste), un fichier lourd → hors du cerveau avec une ligne dans `Outils/outils.md`, une clé → `.env` à la racine du cerveau. Dire à la personne ce qui a été déplacé, en une ligne chacun.

## 2. Le cerveau est-il dans Mon Drive, en miroir ?

```bash
ls -d ~/Library/CloudStorage/GoogleDrive-*/ 2>/dev/null          # Mac : Drive pour ordinateur installé ?
pwd -P | grep -q "CloudStorage/GoogleDrive" && echo "le cerveau est dans Drive" || echo "le cerveau n'est PAS dans Drive"
```

Deux montages possibles, à choisir avant tout :

- **Le cerveau entier dans Mon Drive** (cas standard pour quelqu'un sans Git : tout est au même endroit, on ne partage qu'un sous-dossier). C'est le montage décrit plus bas.
- **Seulement le terrain dans Drive, le cerveau reste où il est** (cas de quelqu'un dont le cerveau est déjà synchronisé autrement, par Git par exemple, ou qui ne veut pas mettre sa vie perso dans Drive). Drive pour ordinateur sait synchroniser un dossier de l'ordinateur sans le déplacer : Préférences → Mon ordinateur (Mon Mac) → Ajouter un dossier → choisir `1 Terrains/<Business>` → « Synchroniser avec Google Drive ». Le dossier apparaît dans Drive sur le web sous « Ordinateurs », synchronisé dans les deux sens, et c'est ce dossier-là qu'on partage (§ 3). Rien ne bouge sur le disque, Obsidian et Git continuent comme avant. Le premier envoi prend quelques minutes. À vérifier la première fois : que le dossier sous « Ordinateurs » accepte bien le partage (sinon, montage 1).

Trois situations pour le montage 1 :

- **Drive pas installé** : dire d'installer « Google Drive pour ordinateur » (google.com/drive/download), de se connecter avec le compte Google du business, et dans ses préférences de choisir « Mettre en miroir les fichiers » (tout est sur le disque, pas seulement dans le cloud). Puis reprendre ici.
- **Drive installé, cerveau ailleurs** (le cas normal la première fois) : déplacer le cerveau entier dans `Mon Drive/`. Avant : fermer Claude Code et Obsidian. Le déplacement : `mv "<cerveau>" ~/Library/CloudStorage/GoogleDrive-<mail>/Mon\ Drive/<cerveau>` (sur Mac ; sur Windows, glisser le dossier dans `G:\Mon Drive`). Après : rouvrir Claude Code depuis le nouveau chemin, relancer une fois `Skills/onboarding/setup/scripts/link-skills.sh` (le raccourci des skills pointe sur l'ancien chemin), et si le cerveau a une sauvegarde en ligne par Git, sortir le dépôt du dossier Drive avec `git init --separate-git-dir ~/.<cerveau>-git` (Git et Drive ne cohabitent pas sur le même dossier). Vérifier que `AGENTS.md` s'ouvre wifi coupé.
- **Cerveau déjà dans Drive** : vérifier le mode miroir (préférences Drive → compte → « Mettre en miroir »). En flux, Obsidian et Claude voient des fichiers vides ou lents.

Un Drive partagé Workspace (l'objet « Drives partagés ») ne se met pas en miroir : flux + « Disponible hors connexion » sur le dossier, poste par poste. Le dire si c'est le cas, et préférer Mon Drive quand on a le choix.

## 3. Donner accès, dans le bon ordre

L'ordre compte : Drive donne d'abord le moins, puis élargit dossier par dossier. Jamais partager la racine du cerveau.

| Étape | Dossier | Droit | Pour qui |
|---|---|---|---|
| 1 | `1 Terrains/<Business>/` | Lecteur | la personne |
| 2 | `Clients/` et `Docs/` | Éditeur | la personne |
| 3 | `Process/<son équipe>/` | Éditeur | la personne |
| 4 | `Process/Finance/` et `Docs/finance/` | héritage coupé, puis Éditeur | compta et direction seulement |

Deux façons de le faire :

- **Si un connecteur Google Drive est branché** (outils `share_file`, `get_file_permissions`) : retrouver chaque dossier par son nom (`search_files`), poser les droits dans cet ordre, relire les permissions après chaque étape et les montrer. Pour l'étape 4, retirer les accès hérités puis ajouter les bons.
- **Sinon, à la main dans Drive sur le web**, dossier par dossier : clic droit → Partager → email → rôle. Donner les quatre étapes une par une, attendre « fait » entre chaque, et à l'étape 4 expliquer : clic droit sur `Process/Finance/` → Partager → roue dentée → décocher l'héritage (ou « Restreindre »), puis retirer la personne si elle y apparaît.

Vérification : demander à la personne (ou vérifier via le connecteur) qu'elle voit `1 Terrains/<Business>/` dans « Partagés avec moi », et rien d'autre.

## 4. Sa fiche dans Equipe/

Créer `1 Terrains/<Business>/Equipe/<prenom-nom>/brief.md` : rôle, équipe, depuis quand, périmètre, accès donnés (les quatre lignes ci-dessus, avec la date), ce qu'elle ne fait pas. Ajouter une ligne dans `_context.md` § Équipe. Si `Process/RH/integrer-un-collaborateur.md` n'existe pas, l'écrire maintenant avec ces étapes (gabarit : quand, qui, étapes, outils, pièges).

## 5. Le message à lui envoyer

Écrit pour elle, en langage courant, à copier dans un mail ou un message. Adapter Mac / Windows. Pas de tirets pour lister (retours à la ligne).

```
Salut <Prénom>,

Tu as maintenant accès au dossier « <Business> » : c'est notre cerveau d'équipe, tout ce qu'on sait sur la boîte, les clients et nos façons de faire. Voilà comment l'installer, une fois, dix minutes.

1. Installe « Google Drive pour ordinateur » (google.com/drive/download) et connecte-toi avec ton compte <email>.
2. Dans Drive sur le web, ouvre « Partagés avec moi », clic droit sur « <Business> », puis Organiser → Ajouter un raccourci → Mon Drive.
3. Dans les préférences de Drive pour ordinateur, choisis « Mettre en miroir les fichiers ».
4. Attends que tout soit téléchargé, puis coupe le wifi et ouvre le fichier AGENTS.md du dossier : s'il s'ouvre, c'est bon.
5. Installe Claude Code si ce n'est pas fait, ouvre-le dans le dossier « <Business> », et dis-lui : « lance Skills/onboarding/setup/scripts/link-skills.sh ». C'est ce qui lui donne nos outils.
6. Demande-lui « qu'est-ce que je dois faire aujourd'hui ? » pour voir que tout marche.

Trois règles chez nous : tu écris seulement dans ton dossier Process/<équipe> et dans les dossiers clients ; on ajoute, on n'efface pas (une suppression est définitive pour tout le monde) ; si tu vois un fichier avec « [Conflit] » dans le nom, tu me le dis.

<Prénom du dirigeant>
```

## 6. Le test de bout en bout (avant de dire « partagé »)

Ne pas conclure sans ces six points, faits avec la personne ou sur un second compte de test :

1. Chez elle, `AGENTS.md` du terrain s'ouvre wifi coupé.
2. Claude Code ouvert dans le terrain répond, et `/save` ou un skill du terrain répond (les raccourcis sont posés).
3. Une modification faite chez le dirigeant arrive chez elle (noter le délai, en général moins de deux minutes).
4. Une modification faite chez elle dans `Clients/` arrive chez le dirigeant ; une tentative dans `Process/Finance/` est refusée.
5. Le même fichier modifié des deux côtés à trente secondes d'écart produit une copie « [Conflit] » : la montrer, dire où elle apparaît, rappeler la règle « un rédacteur par fichier ».
6. Rien de la racine du cerveau (Perso, Admin, Journal) n'apparaît chez elle.

Résultat écrit dans `Equipe/<prenom-nom>/brief.md` (date, délai mesuré, ce qui a coincé). Puis confirmer en une ligne : `✓ <Business> partagé avec <Prénom> (<équipe>) : accès posés, fiche créée, test passé le <date>`.

## Quand ça coince

- Le raccourci « Partagés avec moi → Mon Drive » ne se synchronise pas chez elle : redémarrer Drive pour ordinateur ; sinon, dans ses préférences, retirer et remettre le compte. C'est le point faible connu du montage.
- Elle voit les fichiers mais vides ou très lents : elle est en flux, pas en miroir (ou « Disponible hors connexion » pas coché sur un Drive partagé).
- Elle ne voit aucun skill : le script n'a pas tourné chez elle, ou son Claude Code n'a pas été relancé après.
- Fin de collaboration : retirer les accès dans Drive (dans l'ordre inverse), dater dans sa fiche, la déplacer dans `2 Archives/equipe/`. Ce qu'elle avait déjà téléchargé reste sur son disque : le dire au dirigeant, c'est une limite de Drive, pas un bug.
