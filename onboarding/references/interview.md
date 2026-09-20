# Interview : les blocs de questions, les archétypes métier, le cadre universel

Fichier de référence des skills `onboarding` (de zéro) et `onboarding-migrate` (avec contexte existant). Les deux skills l'appellent en Phase 1. Il contient : les blocs A à K et V, la bibliothèque d'archétypes métier avec les process à seeder, et le cadre universel pour tout métier hors bibliothèque. Les templates des fichiers générés sont dans `structure.md`.

Rappels transverses (le SKILL.md les pose, ils sont répétés ici pour l'agent qui ne lirait que ce fichier) : un bloc à la fois ; creuser une fois quand une réponse est en surface, davantage sur le métier ; asset-first (un fichier réel vaut mille questions) ; « saute » est toujours accepté et se note « non renseigné ».

---

### Bloc A : Identité civile (FONDATION : obligatoire)

- A1. Quel est ton prénom et ton nom ?
- A2. Quel âge tu as ? (saute si tu préfères pas)
- A3. Tu vis où ? (ville + quartier si pertinent + ville d'origine si différente)
- A4. Situation perso : célibataire / en couple / marié / enfants ? (juste les grandes lignes)
- A5. Tes proches qui comptent au quotidien (parents, fratrie, conjoint, enfants, meilleurs amis) : prénoms + lien + 1 ligne par personne sur ce qu'ils représentent pour toi. (peut sauter si trop perso)

---

### Bloc B : Valeurs, mission, image

- B1. Quelle est ta valeur **racine** non-négociable ? (UNE seule : celle qui prime sur tout : liberté, famille, créativité, sécurité, impact, croissance...)
- B2. Tes 2 ou 3 autres valeurs importantes, par ordre.
- B3. Ta mission : pourquoi tu fais ce que tu fais ? (1-3 lignes : la finalité, pas le métier)
- B4. Comment tu veux que les gens te perçoivent ? (3-5 adjectifs ou une phrase)

---

### Bloc C : Parcours rapide

- C1. Études (niveau actuel ou max, école/cursus, ville).
- C2. Premiers jobs / sources d'argent avant ton activité actuelle, et ce que ça t'a appris.
- C3. Timeline pro depuis 3-5 ans (juste les grandes étapes : lancements, pivots, échecs, succès marquants).

---

### Bloc D : Activité, métier & ce que tu veux déléguer (FORTEMENT RECOMMANDÉ)

C'est le bloc le plus important pour l'utilité du cerveau. Il a 3 temps : (1) le panorama de l'activité, (2) **le deep-dive métier** (questions adaptées au secteur), (3) ce qu'on veut déléguer à l'IA.

#### D.1 : Panorama de l'activité

- D1. Tu fais quoi **concrètement** aujourd'hui ? Liste toutes tes casquettes (ex : "freelance dev + créateur de contenu + investisseur immobilier").
- D2. Laquelle te rapporte le **plus de revenu** ?
- D3. Laquelle te prend le **plus de temps** ?
- D4. Es-tu **entrepreneur** (à ton compte, factures à ton nom) ? OUI / NON / partiel (salarié + side).

#### D.2 : Classification métier (interne : NE PAS réciter la liste à l'utilisateur)

À partir de ce qu'il décrit, **range silencieusement** son activité principale dans UN archétype de la **Bibliothèque d'archétypes métier** (section dédiée plus bas dans ce skill). Puis confirme en langage normal, sans jargon de classification :

> "Donc en gros tu es plutôt dans [le e-commerce / le conseil / la formation / la presta de service / ...], c'est bien ça ?"

Règles :
- Si l'activité ne matche **aucun** archétype de la bibliothèque → utilise le **Cadre universel 7 dimensions** (section dédiée plus bas) pour générer toi-même un deep-dive sur-mesure. Ne force jamais un mauvais archétype.
- Si la personne a **2 métiers distincts** (ex : e-com + créateur de contenu) → fais le deep-dive complet sur le métier **principal** (celui de son terrain principal), puis propose un mini deep-dive (2-3 questions) sur le second.
- Si tu hésites entre 2 archétypes → demande-lui de trancher en une phrase, puis avance.

#### D.3 : Deep-dive métier (le cœur)

Charge l'archétype identifié (ou le Cadre universel) et **pose ses questions une par une**, comme un confrère du métier. Adopte son vocabulaire dès maintenant : montre que tu connais le secteur. Creuse une fois quand une réponse est en surface.

Quoi qu'il arrive, couvre ces dimensions transverses (l'archétype te donne les questions concrètes) :
- **Acteurs récurrents** du métier (fournisseurs, prescripteurs, plateformes, sous-traitants, partenaires...).
- **Outils / stack** réellement utilisés au quotidien.
- **Chiffres qui comptent** (les KPIs du métier).
- **Cycle & saisonnalité** (pics, creux, échéances récurrentes).
- **Contraintes** : réglementation, déontologie, risques propres au métier.
- **Livrables récurrents** : qu'est-ce que tu PRODUIS de façon répétée ? (devis, fiches produit, comptes-rendus, posts, rapports, propositions...).

Puis, **toujours** (c'est ce qui donne sa personnalité au cerveau) :
- D5. **Ton angle unique** : qu'est-ce que tu fais différemment des autres dans ton métier ? Tes convictions fortes, tes partis pris, ce sur quoi tu ne transigeras jamais ? (1-3 lignes)
- D6. **Ton vocabulaire** : les mots, expressions, tournures que tu emploies tout le temps dans ton taf (pour que je parle comme toi, pas comme un robot générique).

#### D.4 : Ce que tu veux déléguer

- D7. Tu utilises **déjà** l'IA pour quoi aujourd'hui ? (rien / ChatGPT de temps en temps / pour des trucs précis...)
- D8. Si je pouvais t'enlever **3 tâches répétitives** de la semaine : celles qui te bouffent du temps sans valeur ajoutée : ce serait lesquelles ?

→ Si NON entrepreneur du tout : le deep-dive métier reste pertinent (le métier existe même salarié). Mais skip le Bloc E (business & légal) s'il a été sélectionné.

---

### Bloc E : Business & légal (entrepreneurs)

- E1. **Marque(s) commerciale(s)** : nom(s) de boîte ou d'offre que tu utilises publiquement. Si plusieurs, précise leur relation (ex : "marque mère X, sous-marques Y et Z").
- E2. **Client idéal type** : c'est qui le client parfait pour toi ? (1-2 lignes : qui c'est, taille de boîte, secteur, problème principal qu'il vit).
- E3. **Offre principale** : nom, prix, durée, ce qui est livré. Si plusieurs offres, liste-les avec leur prix.
- E4. **Outil de gestion clients (CRM)** : où vivent les infos détaillées de tes clients ? Notion / Pipedrive / HubSpot / Airtable / Google Sheet / fichier sur ton ordinateur / pas encore ? Donne-moi le lien web ou le chemin du fichier. **Je n'ai pas besoin que tu listes tes clients : je veux juste savoir où regarder quand j'en aurai besoin.**
- E5. **Processus de vente** : comment quelqu'un d'intéressé devient client chez toi ? (par exemple : page de vente → prise de rendez-vous → appel de découverte → décision → installation). En 3 à 5 étapes.
- E6. **Infos légales (celles qui apparaissent sur tes factures et documents officiels)** :
    - Nom légal qui apparaît sur les factures
    - Statut juridique (EI, EURL, SASU, SAS, micro-entreprise, autre)
    - SIRET / numéro d'enregistrement
    - Régime TVA (assujetti / franchise : si franchise, mention légale exacte par exemple "TVA non applicable Art. 293 B du CGI")
    - Qualité professionnelle (Consultant IA, Développeur, Coach, etc.)
    - Adresse email professionnelle qui apparaît sur les factures
    - Adresse professionnelle (si différente de l'adresse personnelle et si elle apparaît sur les documents)
- E7. **Informations bancaires (RIB / IBAN)** : où est-ce que je peux les retrouver quand tu en auras besoin ? (chemin d'un fichier sur ton ordinateur, ou page Notion). Ne me donne PAS les numéros directement : juste l'indication d'où ils sont rangés. (tu peux sauter)
- E8. **(asset-first)** Tu as déjà un **modèle de facture** (ou de devis, de proposition commerciale) que tu utilises ? Donne-le-moi (PDF, doc, ou chemin du fichier). Je calque ta nomenclature, tes mentions légales et ta mise en forme pour que mes prochains documents soient identiques aux tiens. Pareil pour tout autre livrable récurrent dont tu as un exemplaire type.

Note : si le Bloc D a déjà couvert l'ICP via le deep-dive métier, ne redemande pas E2 : réutilise et passe.

---

### Bloc F : Style de communication (FONDATION : obligatoire)

- F1. Tu me tutoies ou je te vouvoie ?
- F2. Langue principale ? (français / anglais / autre)
- F3. Bullet points ou paragraphes ?
- F4. Direct sans filtre OU bienveillant et explicatif ?
- F5. Emoji on ou off ?
- F6. Une chose que les autres assistants IA font qui t'énerve ? (sois précis)
- F7. Une chose que tu adores qu'ils fassent ?
- F8. **(asset-first)** Tu as déjà des écrits qui sonnent comme toi : posts LinkedIn/Insta que tu as publiés, newsletters, pages de vente, scripts ? Donne-moi 2-3 liens ou colle-les. J'irai les lire et j'en extrairai ta **voix** (vocabulaire, rythme, tics, structure de phrase) pour écrire comme toi, pas comme un robot générique. Si tu n'as rien de public : "rien pour l'instant".

---

### Bloc G : tes terrains (FONDATION, obligatoire)

Avant de poser, affiche cette explication textuellement :

```
Un « terrain », c'est un domaine où tu opères de manière récurrente
(chaque semaine ou chaque mois). C'est le seul concept à retenir.

Il y a deux sortes de terrains :

1. TON BUSINESS : un terrain par boîte ou par marque. C'est lui qui
   contient tes clients, tes façons de faire, ton équipe, tes outils.
   Nom précis : le nom de la boîte ou de la marque, jamais « mon business ».
   Ton contenu (LinkedIn, YouTube, newsletter) N'EST PAS un terrain à part :
   c'est le marketing de ton business, il vit dedans.

2. TA VIE : Perso (famille, souvenirs, objectifs), Admin (papiers, banque,
   logement), Santé si tu veux suivre ça. Un terrain de vie est simple :
   un fichier de contexte et des pièces.

Exemples :

Coach solo :
- « Cabinet Dupont » (le business)
- Perso, Admin

Fondateur d'une marque e-commerce :
- « Maison Léa » (le business)
- Perso, Admin, Santé

Deux activités distinctes :
- « Acme Conseil » (le business 1)
- « Newsletter Le Réveil » (le business 2, s'il a ses propres clients et ses propres process)
- Perso, Admin

Salarié avec un side project :
- « Side Projet X » (le business, même petit)
- Perso, Admin

Critères : récurrent (chaque semaine ou chaque mois), nom précis,
autant de terrains que nécessaire, un seul c'est aussi valide.
```

Puis :

- G1. Ton ou tes terrains business : nom précis + une phrase + statut (en croissance, mature, en pause). Un par boîte ou par marque.
- G2. Tes terrains de vie : Perso et Admin sont créés d'office. Tu veux aussi Santé (sommeil, sport, dossier médical) ? Autre chose de récurrent qui n'est ni business ni perso (une école, un investissement actif) ?
- G3. Si plusieurs terrains business : lequel est ton terrain principal du moment ?
- G4. Est-ce que quelqu'un travaille déjà avec toi sur ce business (assistant, freelance, associé, salarié) ? Prénom et rôle. Ça décide si le module Equipe/ est créé maintenant et si on prépare le partage du terrain (voir la doctrine Google Drive).

Récupère sous la forme :

```
Business :
- [Nom précis] : description (statut) [principal]
Vie :
- Perso, Admin [+ Santé, + autres]
Équipe : [personne, rôle] ou « seul »
```

Astuce métier : si le deep-dive métier (Bloc D) a été fait, le terrain business principal est celui où seront seedés les process de l'archétype en Phase 3.

---

### Bloc V : Identité visuelle & charte (FONDATION : obligatoire)

C'est très important : ton IA va générer pour toi des posts, des miniatures, des présentations, des documents. Sans charte, elle va inventer des couleurs et des polices au hasard. Avec charte, tout ce qu'elle produit reste cohérent avec ton image.

Si tu n'as encore RIEN (pas de logo, pas de couleurs définies), dis-le franchement et on notera tout comme "à créer" : au moins on saura qu'il y a un chantier.

**Première question : combien de chartes différentes tu as à gérer ?**

- V1. **Tes marques / identités visuelles** :
    - Tu as une ou plusieurs marques avec chacune sa propre charte ? Liste-les.
      Exemples : "juste moi en perso, pas de marque" / "une seule marque : Acme Corp" / "deux marques : Acme Corp (SaaS) et le-blog-de-jean.fr (newsletter perso)".
    - Si pas de marque : on créera une charte "Personnel" à ton nom.
- V1bis. **(asset-first)** Avant de poser les questions une par une : tu as déjà un **document de charte graphique** quelque part (un PDF, un lien Figma, une page Notion, un brand book) ? Donne-le-moi directement : j'en extrais couleurs, polices et règles, et on ne fait que compléter les trous. Ça t'évite de tout retaper. (Si oui, note le chemin/lien comme source dans `Docs/charte/charte-<marque>.md`.)

**Puis, pour CHAQUE marque listée**, je vais te poser les 6 questions suivantes. On les fait dans l'ordre, marque par marque. Si tu n'as qu'une seule marque (ou personnel), on les fait une fois et basta.

Pour la marque [Nom de la marque en cours] :

- V2. **Logo** : tu en as un ?
    - Si oui : donne-moi le chemin du fichier sur ton ordinateur (par exemple `/Users/toi/Desktop/logo.png`) ou un lien web.
    - Plusieurs versions ? (logo sur fond clair, logo sur fond foncé, version en une seule couleur, petite icône carrée pour les profils sociaux).
    - Si non : "à créer".
- V3. **Couleurs de marque** :
    - Couleur principale (code couleur de préférence, par exemple `#FF6B35`, ou nom : "orange Anthropic").
    - Couleur secondaire (s'il y en a).
    - Couleur d'accent (s'il y en a : par exemple pour les boutons).
    - Si rien de défini : "à créer".
- V4. **Police d'écriture** :
    - Police pour les titres (par exemple Inter, Söhne, Helvetica, Times).
    - Police pour le texte courant (souvent la même, parfois différente).
    - Si rien de défini : "à créer".
- V5. **Photos professionnelles** réutilisables pour cette marque (portraits, photos en action, photos d'équipe, photos produit) ? Donne-moi les chemins ou liens.
- V6. **Bannières / images de couverture** utilisées pour cette marque sur ses profils sociaux (LinkedIn, YouTube, X, Instagram, etc.) ? Chemins ou liens.
- V7. **Style général** que tu veux que ton IA respecte pour cette marque : minimaliste / coloré / brutaliste / classique / luxe / décontracté / autre ? (1-2 mots suffisent)

→ Une fois ces questions répondues pour la marque en cours, passe à la marque suivante (si plusieurs). Quand toutes les marques sont couvertes, fin du Bloc V.

---

### Bloc H : Rythme & hygiène

- H1. **Semaine type** détaillée :
    - Heure de coucher / lever
    - Routine matin (ce que tu fais entre le lever et midi)
    - Midi / déjeuner
    - Après-midi
    - Soir
    - Différences le weekend
- H2. **Créneaux non-négociables** (sport, famille, sommeil, méditation, dropoff enfants...) avec horaires.
- H3. **Sport** : quoi, fréquence, avec/sans coach.
- H4. **Alimentation** : régime particulier ? Restrictions ? (saute si pas pertinent)
- H5. **Alcool / drogues / tabac** : conso régulière ? Jamais ? (saute si trop perso)
- H6. **Pratique mentale** : méditation, journaling, thérapie, rien ?

---

### Bloc I : Finances (optionnel mais utile)

Préambule : "Ces questions sont sensibles, tu peux passer chacune individuellement. Mais si tu veux que je sois utile sur le pilotage de ton activité, c'est mieux que je sache."

- I1. Revenu mensuel actuel (fourchette OK : ex "entre 3K et 6K").
- I2. Cible court terme (3 mois) ?
- I3. Cible fin d'année / année en cours ?
- I4. Patrimoine perso (résumé : épargne, PEA, immo, autres). Pas de chiffres précis si tu préfères pas, juste un ordre de grandeur.
- I5. Dettes / prêts en cours ?
- I6. Logement : tu paies un loyer / proprio / chez tes parents / autre ?
- I7. Voiture / mobilité ?
- I8. Charges récurrentes notables (abonnements pros, assurances, gym, etc.) ?

---

### Bloc J : Vision, mentors, carences

- J1. Tes **2 ou 3 projets** majeurs sur les 6 prochains mois ?
- J2. **Vision long terme** (3-5 ans) : où tu te vois ? (vie, lieu, taille de boîte, équipe, revenu, projet majeur)
- J3. Tes **carences pro identifiées** : où tu sais que tu es faible et tu cherches à progresser ? (vente, ops, tech, management, marketing...)
- J4. Tes **mentors / inspirations** (avec qui tu parles régulièrement, ou que tu suis de loin) : prénom + relation + ce qu'il t'apporte.
- J5. Tes **concurrents** que tu observes : qui, pourquoi tu les regardes. (Si le deep-dive métier les a déjà listés, réutilise.)

---

### Bloc K : Objectifs, garde-fous IA, notes privées

- K1. Tes **3 objectifs majeurs** sur les 3 prochains mois (mesurables si possible).
- K2. **Garde-fous IA** : actions concrètes que je ne dois **jamais** faire sans toi.

    C'est très important : tu me poses des lignes rouges pour que je ne fasse pas de connerie en autonomie. Ce ne sont PAS des valeurs morales, ce sont des actions précises que je dois éviter.

    Exemples concrets pour t'inspirer :
    - "Ne jamais envoyer un message à un client ou prospect : toujours me le poser en draft"
    - "Ne jamais dépenser plus de 100€ sur un outil/abonnement sans me valider"
    - "Ne jamais publier sur LinkedIn / YouTube sans que je relise"
    - "Ne jamais prendre une décision RH (embauche, refus candidat)"
    - "Ne jamais répondre à un mail légal/comptable/avocat : toujours me le passer"
    - "Ne jamais supprimer un fichier sans me demander"
    - "Ne jamais signer ou m'engager à un partenariat"

    Donne-moi les tiens (3 à 10). [Si le deep-dive métier a fait remonter des contraintes déontologiques/réglementaires : ex : pas d'allégation médicale, secret professionnel : propose-les ici comme garde-fous candidats.]

- K3. **Notes privées sensibles** : infos que je dois **connaître pour bien faire mon job**, mais que je dois **JAMAIS** mentionner devant un client, dans un livrable, sur un réseau social, ou en public.

    Pas un journal intime : juste les infos qui changent ma compréhension de toi mais qui ne doivent pas sortir.

    Exemples concrets pour t'inspirer :
    - "J'ai vendu un side-business cramé en 2023 : ne pas mentionner publiquement"
    - "Mon vrai revenu mensuel est X, mais je communique Y publiquement"
    - "Ma sœur traverse une dépression : ça impacte ma dispo en ce moment"
    - "J'ai eu un conflit avec [ancien associé], on ne se parle plus : éviter les sujets liés"
    - "J'ai un projet d'expat secret pour [pays] : ne jamais en parler avant le go"

    Si tu n'as rien → dis "rien", on passe. Tu pourras ajouter plus tard.
    → Stockées dans `1 Terrains/Perso/_context.md` section « Notes privées » avec la consigne explicite « à ne jamais publier ». Le terrain Perso n'est jamais partagé.

---

## Bibliothèque d'archétypes métier (référence pour le Bloc D)

Cette bibliothèque sert au **deep-dive métier**. Quand tu as classé la personne (D.2), charge l'archétype correspondant et pose ses **questions métier** une par une. Adopte son **vocabulaire** dès le deep-dive. Note tout pour la génération (section « Métier » du `_context.md` du terrain business, process seedés dans `Process/<Équipe>/`, garde-fous dans `AGENTS.md`, vocabulaire dans `Process/Marketing/ton.md`).

**Si aucun archétype ne colle → saute directement au "Cadre universel 7 dimensions" plus bas.** N'enferme jamais quelqu'un dans le mauvais bucket. Tu peux aussi combiner un archétype + 1-2 questions du cadre universel si la personne est à cheval.

Chaque archétype fournit : *signaux de détection · questions métier · vocabulaire à adopter · stack typique · livrables récurrents · KPIs · saisonnalité · garde-fous métier · process à seeder dans `Process/<Équipe>/` et sous-dossiers à ouvrir dans `Docs/`*. Un process seedé est un fichier court au gabarit standard (quand, qui, étapes, outils, pièges), rempli avec ce que la personne a dit, jamais un fichier vide.

---

### Archétype 1 : E-commerce / DTC / marque produit

- **Signaux** : "boutique en ligne", "Shopify", "je vends des [produits]", "DTC", "dropshipping", "ma marque de [X]", parle de pub Meta/TikTok, de panier, de logistique.
- **Questions métier** :
  - Tu vends quoi, combien de références (SKU), et c'est quoi tes 2-3 best-sellers ? Tes marges grosso modo ?
  - Tes canaux d'acquisition (Meta, TikTok, Google, SEO, influence, marketplace) et lequel marche le mieux ? Budget pub par mois et ROAS visé ?
  - Comment tu produis / t'approvisionnes : fournisseurs, où, délais, qui gère la logistique (toi / un 3PL / un prestataire) ?
  - Le SAV : volume de tickets, outil utilisé, taux de retour, ce qui revient le plus souvent ?
  - Rétention : email/SMS, abonnement, LTV : ou tu vis surtout d'acquisition ?
  - Tes temps forts dans l'année (les pics qui font le CA) ?
- **Vocabulaire** : ROAS, AOV (panier moyen), CAC, LTV, taux de conversion, marge, SKU, BFCM, 3PL, taux de retour, upsell/cross-sell.
- **Stack typique** : Shopify / WooCommerce, Meta Ads Manager, TikTok Ads, Google Ads, Klaviyo (email), Gorgias/Zendesk (SAV), un 3PL/logisticien, Triple Whale/analytics.
- **Livrables récurrents** : fiches produit, séquences email, briefs créa pub, réponses SAV types, descriptions, rapports de perf hebdo.
- **KPIs** : CA, ROAS, AOV, CAC, taux de conversion, marge nette, taux de retour, taux de réachat.
- **Saisonnalité** : BFCM (Black Friday/Cyber Monday) + fêtes de fin d'année = pic majeur ; soldes ; creux post-fêtes (janvier) ; saisonnalité produit propre.
- **Garde-fous métier** : droit de la consommation (rétractation 14j, mentions), RGPD (données clients, consentement email), allégations produit (pas de promesse mensongère), droits d'image sur les créas.
- **Process à seeder** : `Process/Marketing/lancer-une-campagne-pub.md`, `Process/Marketing/envoyer-une-sequence-email.md`, `Process/Ops/preparer-et-expedier-une-commande.md`, `Process/Ops/passer-une-commande-fournisseur.md`, `Process/Support/repondre-a-un-ticket-sav.md`, `Process/Support/gerer-un-retour.md`, `Process/Finance/suivre-la-marge.md`. **Docs/** : `offre/` (catalogue, fiches produit, marges), `fournisseurs/`, `marketing/` (briefs créa, visuels), `templates/` (réponses SAV types).

---

### Archétype 2 : Consultant / expert / profession libérale (services intellectuels B2B)

Couvre : consultant, géomètre, ingénieur conseil, comptable, avocat, architecte, expert d'un domaine (agro, data, finance...). Point commun : vend son expertise en missions/dossiers, souvent avec une déontologie.

- **Signaux** : "cabinet", "mes clients me confient des dossiers/missions", "expertise en [domaine]", "je facture au forfait/à la journée", profession réglementée nommée.
- **Questions métier** :
  - C'est quoi exactement ton expertise et le type de missions/dossiers que tu prends ? Une mission type dure combien de temps ?
  - D'où viennent tes clients : recommandation, appels d'offres, prescripteurs, réseau, inbound ?
  - Y a-t-il des **prescripteurs** ou partenaires qui t'amènent du business régulièrement (notaires, agences, autres cabinets, apporteurs) ?
  - Tu factures comment : forfait, jour/homme, abonnement, au dossier ? Tu sous-traites une partie ?
  - Quels **livrables** tu produis sur chaque mission (rapport, audit, plan, comptes, conclusions, note) ?
  - Ta déontologie / les règles de ta profession qui encadrent ce que tu peux dire ou faire ?
  - Les outils métier spécifiques que tu utilises (logiciel de compta, CAO, logiciel juridique, etc.) ?
- **Vocabulaire** : (selon métier) mission, livrable, dossier, mandat, honoraires, taux journalier (TJM), prescripteur, due diligence, conformité, secret professionnel.
- **Stack typique** : outil métier dédié (compta : logiciel compta/portail OEC ; géomètre : CAO/SIG ; avocat : RPVA/logiciel cabinet), suite bureautique, signature électronique, GED (gestion documentaire), facturation.
- **Livrables récurrents** : propositions/devis, rapports de mission, comptes-rendus, notes d'analyse, présentations client.
- **KPIs** : CA, TJM moyen, taux d'occupation/staffing, nombre de dossiers en cours, encours/délai de paiement, taux de renouvellement.
- **Saisonnalité** : échéances réglementaires propres (ex compta : liasse fiscale mai, TVA mensuelle/trimestrielle, bilans ; avocat : audiences ; conseil : budgets clients en Q4/Q1).
- **Garde-fous métier** : secret professionnel, déontologie de l'ordre (OEC, barreau, ordre des géomètres/architectes), conflits d'intérêt, conformité : **ne jamais produire de conseil réglementé engageant sans relecture de la personne**.
- **Process à seeder** : `Process/Sales/repondre-a-un-prospect.md`, `Process/Sales/faire-une-proposition.md`, `Process/Ops/demarrer-une-mission.md`, `Process/Ops/livrer-un-rapport.md`, `Process/Ops/cloturer-une-mission.md`, `Process/Finance/facturer.md`, `Process/Finance/relancer-un-impaye.md`, `Process/Marketing/entretenir-le-reseau-de-prescripteurs.md`. **Docs/** : `templates/` (modèles de livrables), `legal/` (déontologie, veille réglementaire), `offre/`. Les prescripteurs sont des entités dans `Clients/` (un dossier chacun, type « partenaire »).

---

### Archétype 3 : Formateur / infopreneur / créateur de contenu

Couvre : formateur, infopreneur (vend des cours/cohortes), créateur de contenu monétisant une audience (sponsoring, affiliation, produits). Point commun : produit du savoir + de l'audience.

- **Signaux** : "je forme", "ma communauté", "mon audience", "je vends une formation/un programme", "cohorte", "newsletter", "YouTube/TikTok/Insta", "sponso/affiliation".
- **Questions métier** :
  - Tu vends quoi exactement : formation evergreen, cohorte live, abonnement, coaching, sponsoring d'audience ? À quel prix ?
  - Tes canaux de contenu (YouTube, LinkedIn, Insta, TikTok, newsletter) et lequel ramène le plus d'audience/de ventes ?
  - Comment ton audience devient cliente (lead magnet → email → webinaire → vente ? DM ? VSL ?) ?
  - Quel est le **sujet/promesse** central de ton contenu, et ton angle (ce qui te distingue des autres créateurs du même thème) ?
  - Rythme de publication et ce que tu produis chaque semaine (vidéos, posts, emails, scripts) ?
  - Si tu as financement (OPCO, CPF, Qualiopi) ou des contraintes de certification ?
- **Vocabulaire** : audience, reach, engagement, lead magnet, tunnel/funnel, VSL, evergreen, cohorte, LTV, taux d'ouverture/clic, watch time, CTR, sponsoring, affiliation.
- **Stack typique** : plateforme de cours (Teachable/Podia/School/Systeme.io), email (ConvertKit/Brevo/Klaviyo), montage/édition, planificateur réseaux, analytics natifs, Stripe.
- **Livrables récurrents** : scripts vidéo, posts réseaux, newsletters, miniatures, pages de vente, modules de formation, séquences email.
- **KPIs** : abonnés/croissance, reach, taux d'engagement, taux d'ouverture/clic email, taux de conversion vente, CA par lancement, watch time/CTR.
- **Saisonnalité** : lancements (open/close cart), rentrée septembre, janvier (bonnes résolutions), creux estival ; cycles d'algorithme.
- **Garde-fous métier** : pas de promesses de résultat mensongères (notamment formation/argent/santé), respect droits d'auteur/musique, mentions sponsoring (transparence pub), RGPD email ; si Qualiopi/CPF : conformité des supports.
- **Process à seeder** : `Process/Marketing/publier-un-post.md`, `Process/Marketing/tourner-une-video.md`, `Process/Marketing/envoyer-la-newsletter.md`, `Process/Sales/repondre-a-un-lead.md`, `Process/Sales/lancer-une-vente-open-close.md`, `Process/Ops/produire-un-module.md`, `Process/Ops/animer-une-cohorte.md`, `Process/Support/repondre-a-un-eleve.md`, `Process/Finance/facturer.md` (+ `financer-par-opco-cpf.md` si concerné). **Docs/** : `offre/` (programmes, modules), `marketing/` (scripts, posts, miniatures), `legal/` (Qualiopi, CPF), `temoignages/`.

---

### Archétype 4 : Coach / thérapeute / prestataire de services solo

Couvre : coach (business, sport, vie), thérapeute/praticien bien-être, prestataire de service solo en relation 1:1 (beauté, conseil perso...). Point commun : vend son temps/accompagnement en relation directe.

- **Signaux** : "j'accompagne", "mes coachés/clients", "séances", "1:1", "praticien", "cabinet de [bien-être]", relation individuelle au cœur.
- **Questions métier** :
  - Tu accompagnes qui, sur quel problème, et avec quel format (séances unitaires, programme de X semaines, abonnement) ? Prix ?
  - Comment les gens te trouvent et décident de travailler avec toi (bouche-à-oreille, contenu, appel découverte, recommandation) ?
  - C'est quoi ton **process d'accompagnement** type, étape par étape, du premier contact au bilan ?
  - Qu'est-ce que tu produis autour des séances (comptes-rendus, exercices, supports, plans, suivis) ?
  - Ta méthode / approche propre : ce qui te distingue des autres praticiens de ton domaine ?
  - Des contraintes : réglementation de ta pratique, ce que tu ne peux PAS promettre/affirmer ?
- **Vocabulaire** : séance, accompagnement, programme, coaché/client, bilan, suivi, objectif, protocole (selon domaine).
- **Stack typique** : prise de RDV (Calendly/Cal.com), visio (Zoom/Meet), facturation, notes clients, paiement (Stripe/PayPal), parfois un espace membre.
- **Livrables récurrents** : comptes-rendus de séance, plans d'action, supports/exercices, emails de suivi, propositions d'accompagnement.
- **KPIs** : nombre de clients actifs, taux de remplissage de l'agenda, taux de renouvellement/rétention, panier moyen, taux de no-show, satisfaction/témoignages.
- **Saisonnalité** : rentrée septembre + janvier (pics de demande), creux estival ; cycles de cohortes si programmes groupés.
- **Garde-fous métier** : pas d'allégation thérapeutique/médicale non autorisée, confidentialité des échanges clients (sensible ++), limites du périmètre de pratique, RGPD données clients.
- **Process à seeder** : `Process/Sales/repondre-a-un-lead.md`, `Process/Sales/appel-decouverte.md`, `Process/Sales/faire-une-proposition.md`, `Process/Ops/preparer-une-seance.md`, `Process/Ops/apres-une-seance.md`, `Process/Ops/faire-le-bilan-de-fin.md`, `Process/Finance/facturer.md`, `Process/Marketing/publier-un-post.md` ; la méthode d'accompagnement (doctrine) dans `Process/Ops/methode/_context.md`. **Docs/** : `offre/` (programmes, prix), `templates/` (compte rendu de séance, exercices, supports), `temoignages/`.

---

### Archétype 5 : Agence / studio (gère des clients en récurrent avec une petite équipe)

Couvre : agence marketing/web/SMMA/com, studio créatif, agence de prestation gérant un portefeuille de clients en récurrent, souvent avec freelances.

- **Signaux** : "mes clients (au pluriel, en abonnement)", "mon équipe / mes freelances", "on gère les [réseaux / sites / pub] de nos clients", "retainer/forfait mensuel".
- **Questions métier** :
  - Vous délivrez quoi exactement et pour quel type de clients ? Modèle : régie, forfait, retainer mensuel, à la perf ?
  - Comment tu gères la **prod** : qui fait quoi, combien de freelances/salariés, comment tu répartis les projets ?
  - D'où viennent les nouveaux clients (recommandation, prospection, contenu, ads) ?
  - Quels **livrables récurrents** par client (rapports, créas, posts, dev, audits) et à quelle cadence ?
  - Comment tu suis la rentabilité par client / par projet (temps passé vs facturé) ?
  - Tes process / SOPs : tu en as de documentés ou tout est dans ta tête ?
- **Vocabulaire** : retainer, scope, livrable, SOP, brief, rétroplanning, marge par projet, taux d'occupation, churn client, upsell.
- **Stack typique** : gestion de projet (Notion/ClickUp/Asana/Trello), suivi temps, facturation, Slack/Discord équipe, outils de prod selon spécialité, reporting (Looker/Metabase/sheets).
- **Livrables récurrents** : rapports clients, créas/contenus, propositions commerciales, briefs, comptes-rendus de réunion, SOPs.
- **KPIs** : MRR/CA récurrent, churn client, marge par client, taux d'occupation équipe, délai de livraison, satisfaction client.
- **Saisonnalité** : budgets clients (Q4 dépense, Q1 renouvellements), creux estival, pics liés aux secteurs des clients.
- **Garde-fous métier** : confidentialité données clients, ne pas s'engager au nom d'un client, respect des contrats/scope, RGPD, droits sur les contenus produits.
- **Process à seeder** : `Process/Sales/qualifier-un-lead.md`, `Process/Sales/faire-une-proposition.md`, `Process/Sales/passer-le-client-a-ops.md`, `Process/Ops/kickoff-client.md`, `Process/Ops/produire-un-livrable.md`, `Process/Ops/faire-recetter.md`, `Process/Ops/envoyer-le-reporting-mensuel.md`, `Process/RH/briefer-un-freelance.md`, `Process/RH/integrer-un-collaborateur.md`, `Process/Finance/facturer.md`, `Process/Finance/suivre-la-rentabilite-par-client.md`. Module `Equipe/` créé d'office (un dossier par freelance ou salarié). **Docs/** : `templates/` (briefs, rapports, propales), `offre/`.

---

### Archétype 6 : Commerce, artisan & service local (physique / local)

Couvre : commerce physique, restauration, salon, artisan/BTP, agent immobilier, tout business ancré local avec présence physique ou clientèle géographique.

- **Signaux** : "ma boutique/mon salon/mon resto/mon chantier", "mes clients du coin", "Google Business", "horaires", "sur place", zone géographique.
- **Questions métier** :
  - Tu proposes quoi sur place / en local, et c'est quoi ton offre phare ?
  - Comment les clients te trouvent (Google Business, bouche-à-oreille, passage, réseaux locaux, plateformes type Doctolib/TheFork/Leboncoin) ?
  - Tu gères une équipe sur place ? Des fournisseurs / sous-traitants locaux récurrents ?
  - Ce que tu produis/gères en récurrent (devis chantier, planning, stock, réservations, fiche Google, posts locaux) ?
  - Ton cycle : jours/heures de pointe, saison forte vs creuse ?
  - Contraintes du métier (normes, hygiène, sécurité, assurances, autorisations) ?
- **Vocabulaire** : (selon métier) couverts/tickets, réservation, devis/chantier, marge, stock, avis Google, zone de chalandise, saisonnalité.
- **Stack typique** : Google Business Profile, plateforme de réservation/commande sectorielle, caisse/POS, devis-facturation, réseaux locaux, gestion de stock/planning.
- **Livrables récurrents** : devis, plannings, posts/avis locaux, fiches Google, fiches produit/menu, relances clients.
- **KPIs** : CA, panier/ticket moyen, fréquentation, taux de remplissage/réservation, avis & note moyenne, marge, taux de transformation devis.
- **Saisonnalité** : très forte et propre au métier (resto = midi/soir + saison ; BTP = beaux jours ; commerce = fêtes/soldes) : à capturer précisément.
- **Garde-fous métier** : normes (hygiène, sécurité, ERP), assurances obligatoires, autorisations, ne jamais répondre à un avis client négatif sans validation.
- **Process à seeder** : `Process/Sales/faire-un-devis.md`, `Process/Sales/relancer-un-devis.md`, `Process/Ops/planifier-la-semaine.md`, `Process/Ops/gerer-le-stock.md` (ou `preparer-un-chantier.md`), `Process/Support/repondre-a-un-avis.md`, `Process/Support/gerer-une-reclamation.md`, `Process/Marketing/tenir-la-fiche-google.md`, `Process/RH/faire-le-planning-equipe.md` (si équipe), `Process/Finance/facturer.md`, `Process/Finance/payer-les-fournisseurs.md`. **Docs/** : `offre/` (carte, prestations, tarifs), `legal/` (normes, assurances, autorisations), `templates/` (devis).

---

## Cadre universel 7 dimensions (pour TOUT métier hors bibliothèque)

Quand aucun archétype ne colle, **tu deviens l'interviewer expert de CE métier**. Génère toi-même 6-8 questions concrètes en couvrant ces 7 dimensions. C'est le vrai moteur d'adaptation : la bibliothèque n'est qu'un raccourci pour les cas fréquents : ce cadre marche pour n'importe quel métier (taxidermiste, viticulteur, prof de yoga, revendeur de pièces auto, peu importe).

Pour chaque dimension, formule UNE question dans la langue du métier de la personne :

1. **Unités de production / ce qui se vend** : qu'est-ce que la personne vend ou produit concrètement, sous quelle forme, à quel prix, quelles marges ?
2. **Acquisition** : d'où viennent les clients / missions / ventes ? Quel canal domine ?
3. **Acteurs récurrents** : qui gravite autour : fournisseurs, prescripteurs, plateformes, partenaires, sous-traitants, donneurs d'ordre ?
4. **Outils / stack** : quels logiciels et outils sont réellement utilisés au quotidien dans ce métier ?
5. **Cycle & saisonnalité** : pics, creux, échéances récurrentes, rythme de l'année ?
6. **KPIs** : quels 3-5 chiffres pilotent ce métier ? Qu'est-ce que "une bonne semaine/un bon mois" ?
7. **Contraintes** : réglementation, déontologie, normes, risques propres au métier ?

Puis, comme pour tout archétype, capture **toujours** : les **livrables récurrents** (ce qui est produit chaque semaine), le **vocabulaire/jargon** du métier, **l'angle unique** de la personne (D5) et les **tâches répétitives à déléguer** (D8).

**Process à seeder** quand on improvise : déduis 5 à 8 process des livrables récurrents et de l'acquisition, et range chacun dans l'équipe qui le portera (`Sales/`, `Ops/`, `Finance/`, `Marketing/`, `Support/`, `RH/`). Nomme-les par le verbe, avec les mots du métier (`preparer-une-vendange.md`, pas `process-production.md`). Ouvre dans `Docs/` seulement les sous-dossiers qui reçoivent déjà de la matière (`offre/`, `templates/`, `legal/`…).

---