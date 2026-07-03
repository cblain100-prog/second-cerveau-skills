---
name: reponse-inbox
description: Génère des drafts contextualisés pour toute une inbox de messagerie en parallèle (Beeper, WhatsApp, iMessage, LinkedIn, Slack DM... — tout outil de messagerie connecté en MCP). Lit les messages non lus des conversations humaines (filtre les notifs auto), charge le contexte du second cerveau via la carte de routing du CLAUDE.md, génère un draft personnalisé pour chaque conversation selon le type d'interlocuteur (client, lead, contact perso, vocaux, demande de facture/devis), et pose chaque draft directement dans l'outil de messagerie sans jamais l'envoyer. Déclencher quand l'utilisateur dit "réponse", "répond à mon inbox", "drafts inbox", "répond à tout le monde", "clear mes drafts", ou tape /reponse-inbox. À utiliser quand l'inbox a accumulé plusieurs messages non-lus à traiter en batch plutôt qu'un par un.
---

# Réponse inbox — batch-drafts contextualisés

Skill de batch-réponse inbox. Génère un draft pour chaque conversation humaine non-lue, en utilisant le contexte du second cerveau pour personnaliser le ton, le pitch et le contenu selon le profil de l'interlocuteur.

**À utiliser quand l'utilisateur a accumulé plusieurs messages non-lus et veut tout traiter en un coup.**

Ce skill est **général** : il ne connaît pas à l'avance le ton, l'offre ou les terrains de l'utilisateur. Il les découvre en lisant `CLAUDE.md` à chaque exécution (comme `/save`). Conséquence : quand la structure ou le ton de l'utilisateur évoluent, il n'y a **rien à changer ici** — mets juste à jour `CLAUDE.md` (ou le fichier qu'il référence), et ce skill suit.

---

## Étape 0 — Vérifier qu'un outil de messagerie est disponible

Ce skill dépend d'un **MCP de messagerie connecté** (exemples : Beeper Desktop, WhatsApp, iMessage, LinkedIn, Slack). Repère les outils MCP disponibles dont le nom contient `chat`, `message`, `inbox` ou le nom d'une appli de messagerie (`search_chats`, `list_messages`, `focus_app`, etc.).

- **Si un tel outil existe** : utilise-le pour les étapes 2/3/4/4e (adapte les noms de paramètres exacts à l'outil réellement branché — ils varient d'une intégration à l'autre, la logique ci-dessous reste la même).
- **Si aucun outil de messagerie n'est connecté** : arrête-toi et indique clairement qu'aucune intégration de messagerie n'est configurée, donc ce skill ne peut rien lister ni draft. Ne rien inventer.

---

## Étape 1 — Charger le contexte permanent

**Avant de toucher à la messagerie**, lis dans cet ordre (Read tool) :

1. `CLAUDE.md` à la racine du vault — repère sa section **routing** (souvent "Routing — où lire et où écrire"). Elle indique où vivent : le ton/la voix de l'utilisateur, les infos clients, les règles de facturation, un éventuel lien de prise de RDV ou formulaire d'intake, la stratégie de contenu (utile pour répondre à un commentaire de post).
2. Le fichier mémoire auto-chargé du vault (`memory.md` ou équivalent indiqué par `CLAUDE.md`) — décisions récentes, focus du moment, leçons apprises (notamment sur le ton ou les règles d'outreach).
3. Le(s) fichier(s) de **ton/voix** référencé(s) par le routing, s'ils existent (ex. `Personal Brand/ton.md`, `regles.md`, ou équivalent propre à ce vault). C'est ce fichier qui fixe tutoiement/vouvoiement, emojis, formulations types, etc.
4. Le(s) fichier(s) de **contexte business** référencé(s) par le routing (offre, ICP, tarifs — souvent un `_context.md` de terrain), utiles pour pitcher correctement.
5. Le(s) fichier(s) de **facturation** référencé(s) par le routing, si l'utilisateur facture ses clients (pour les demandes de facture).

**Repli si aucune règle de ton n'existe dans le vault** : adopte un ton neutre, professionnel, poli, sans emoji, sans jargon commercial forcé. Ne jamais inventer un tutoiement/vouvoiement ou des formulations "de marque" qui ne sont écrites nulle part dans le vault.

---

## Étape 2 — Lister les conversations non lues

Avec l'outil de messagerie repéré à l'Étape 0, liste les conversations non lues (option "unread only", boîte principale, muets exclus par défaut).

Si l'utilisateur a passé un paramètre de limite (`--limit N`), l'utiliser à la place de la valeur par défaut de l'outil.

---

## Étape 3 — Filtrer les conversations à ignorer

**Skip une conversation si** au moins une de ces conditions :

### Heuristique nom d'expéditeur / titre de conversation

Les notifications automatiques (services e-commerce, opérateurs télécom, plateformes de paiement, réseaux sociaux en mode notif, numéros bruts non enregistrés) polluent presque toujours une inbox. Il n'existe pas de liste universelle — **construis-la depuis ce que tu observes réellement dans les conversations listées à l'Étape 2**, avec ces heuristiques génériques :

```python
import re

NOTIF_PATTERNS = [
    r"^[A-Z]{4,}$",  # ALLCAPS court (souvent un nom de marque/service)
    r"^\+\d{2,}",    # Numéros bruts non-sauvegardés
    r"^\d+$",        # Que des chiffres
]

def is_notif(chat_title: str) -> bool:
    t = chat_title.strip().lower()
    if any(re.search(p, t, re.IGNORECASE) for p in NOTIF_PATTERNS):
        return True
    return False
```

Complète avec les noms de service évidents que tu vois dans la liste (banques, opérateurs, e-commerce, paiement, réseaux sociaux en mode notif) — ce sont quasi toujours des expéditeurs automatiques, pas des humains.

### Skip aussi si

- Le dernier message vient de l'utilisateur lui-même (il a déjà répondu) — vérifier le flag "isSender"/"fromMe" équivalent de l'outil
- La conversation est un groupe et le dernier message est juste une réaction emoji ou un acquittement court
- La conversation est marquée muted/masquée

---

## Étape 4 — Pour chaque conversation humaine restante

### 4a. Lire les derniers messages

Récupère les ~5 derniers messages de la conversation avec l'outil de messagerie, pour avoir le contexte de l'échange.

### 4b. Détecter le type de conversation

Catégoriser selon ce qui est observable, en s'appuyant sur ce que `CLAUDE.md` sait de l'activité de l'utilisateur (client, coach, créateur de contenu, e-commerce, etc. — adapter les libellés à son activité réelle) :

| Type | Signal | Stratégie de draft |
|------|--------|--------------------|
| **Client / contact identifié** | Le nom matche un dossier client connu du vault (voir routing `CLAUDE.md`) | Lire les infos du client avant de drafter, ton chaleureux et précis |
| **Lead chaud** | Réponse positive après une prise de contact commerciale (si l'utilisateur fait de la prospection) | Pitch de l'offre + CTA vers le lien de prise de RDV/intake **si un tel lien existe dans le vault** |
| **Commentateur / lead magnet** | A commenté un contenu publié par l'utilisateur | Réponse adaptée au contenu + éventuel lien de ressource **si prévu dans le vault**, sans en inventer un |
| **Contact perso** | Message hors contexte pro, ton informel dans l'historique | Ton chill, pas de pitch |
| **Inconnu** | Ni client ni lead clair | Question ouverte courte pour qualifier |
| **Vocaux uniquement** | Tous les messages récents sont des messages vocaux | Version safe générique + flag pour traitement manuel |

### 4c. Charger les infos du contact si applicable

Si le nom/titre de la conversation matche un client/contact connu du vault (dossier repéré via le routing `CLAUDE.md`), lis les fichiers pertinents de ce dossier pour personnaliser le draft (ne jamais deviner un contenu spécifique-client non écrit dans le vault).

### 4d. Générer le draft

Applique **strictement** ce que le vault décrit sur le ton (Étape 1, point 3) :

- Registre (tutoiement/vouvoiement), longueur, emojis ou non, formulations types : **tel que défini dans le fichier de ton/voix du vault** — sinon repli neutre professionnel (voir Étape 1).
- Pas de question dans un message de prospection à froid si le vault dit d'éviter les questions en outreach (vérifier dans les règles/leçons du vault) ; sinon, une question de qualification courte est acceptable.
- CTA vers un lien de prise de RDV ou un formulaire d'intake : **uniquement si un tel lien est référencé dans `CLAUDE.md` ou dans le `_context.md` du terrain business** de l'utilisateur. Si aucun lien de ce type n'existe dans le vault, ne pas en inventer — proposer un CTA générique ("dis-moi si ça t'intéresse", "je peux t'en dire plus si tu veux").

**Structure indicative d'un message de prospection à froid** (à ajuster selon les règles réelles du vault) :
1. Accroche liée au contexte (cas concret, rebond sur un engagement récent)
2. Constat/besoin de l'interlocuteur
3. Présentation courte de l'offre (telle que décrite dans le `_context.md` business du vault)
4. CTA (lien s'il existe, sinon phrase ouverte)

**Pour une conversation déjà en cours (pas un premier contact)** :
Répondre au contenu factuel, donner la prochaine étape concrète (créneau, lien, action attendue), sans repitcher l'offre en plus.

### 4e. Poser le draft dans l'outil de messagerie

Utilise la fonction de "brouillon"/"focus" de l'outil MCP connecté pour poser le texte dans le champ de saisie de la conversation — **jamais l'envoyer**.

Si une pièce jointe est attendue (facture, devis, document), ne pas la générer ici : signaler dans le récap final que la PJ doit être ajoutée manuellement (ou déclencher le skill de facturation du vault s'il existe, sur confirmation).

---

## Étape 5 — Output récap

Afficher :

```
## Drafts placés (N)

✓ [Nom] (id conversation) → résumé draft 1 ligne
✓ [Nom] (id conversation) → résumé draft 1 ligne
...

## Skipped (N)

→ [Nom] : raison (notif auto / déjà répondu / vocal seul / etc.)

## À traiter manuellement (N)

⚠ [Nom] : raison (vocaux à écouter / contexte ambigu / facture à générer / etc.)
```

---

## Cas particuliers

### Vocaux uniquement
Ne pas inventer de réponse au contenu du vocal. Mettre un draft safe :
```
Bien reçu, je reviens vers toi rapidement.
```
+ noter dans le récap : "⚠ [Nom] : vocal à écouter avant envoi".

### Demande de facture / devis
Ne pas générer le document ici — c'est le rôle d'un skill/flux de facturation dédié, s'il existe dans ce vault (voir `CLAUDE.md`). Mettre un draft qui annonce l'envoi :
```
Je t'envoie ça rapidement, je te confirme dès que c'est prêt.
```
+ flagger dans le récap : "⚠ [Nom] : facture/devis à générer".

### Conversation en cours après un appel de closing
Si un outil de transcription d'appel est connecté (ex. Fathom) et qu'une transcription récente existe pour ce contact, signaler dans le récap que le workflow post-signature du vault (s'il existe) peut être lancé pour ce client après le batch.

### Doublon entre "lead" et client déjà connu
Avant de générer un draft de type "lead", croiser le nom de l'expéditeur avec les dossiers clients connus du vault (routing `CLAUDE.md`). En cas de match → traiter comme client existant, jamais comme un nouveau lead : c'est une erreur fréquente et coûteuse (relance commerciale envoyée à un client déjà signé), donc systématiquement vérifier avant de drafter.

---

## Règles de garde-fous

- **Ne jamais envoyer** : seulement poser le draft. L'utilisateur envoie manuellement.
- **Pas de génération de facture/PDF dans ce skill** : renvoyer vers le skill/flux dédié du vault, s'il existe.
- **Pas de modification du vault** depuis ce skill : lecture seule (hormis la pose de drafts dans l'outil de messagerie, qui n'écrit rien dans le vault).
- **Jamais de lien inventé** (RDV, formulaire, offre) : seulement s'il est écrit noir sur blanc dans `CLAUDE.md` ou le `_context.md` du terrain business.
- **Si ambiguïté sur le ton ou le contenu** : version safe générique + flag dans le récap plutôt que d'improviser.

---

## Exemple d'invocation

```
/reponse-inbox
```

ou

```
réponse
répond à mon inbox
drafts inbox
```
